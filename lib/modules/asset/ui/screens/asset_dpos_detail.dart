part of asset_ui_module;

class AssetDposDetail extends StatefulWidget {
//  const AssetDposDetail({Key key, this.voteNodeItem, this.coinInfo}) : super(key: key);
  const AssetDposDetail(this.voteNodeItem, this.coinInfo);
  static const routeName = '/asset/dpos/detail';

  final voteNodeItem;
  final coinInfo;

  static Route<dynamic> route(RouteSettings settings) {
    final params = settings.arguments as Map<dynamic, dynamic>;
    final node = params['voteNodeItem'];
    final coinInfos = params['coinInfo'];
    return DefaultTransition(settings, AssetDposDetail(node, coinInfos));
  }

  @override
  State<StatefulWidget> createState() {
    return _AssetDposDetail();
  }
}

class _AssetDposDetail extends State<AssetDposDetail> {
  String nodeAddress = ''; //vote address
  String compoundInterestAddress = ''; //address
  String superNodeAddress = ''; //super node address
  String superNodeName = ''; // super node name
  String addressBalance = '0'; //wallet address balance
  String voteAddressBalance = '0';
  String compoundInterestAddressBalance = '0';
  String voteLockedAmount = '0';
  String fuliLockedAmount = '0';
  bool insufficientBalance = false;
  dynamic nonce;
  //dynamic gas_price;
  //dynamic gas_limit;
  dynamic status = 1; // 0：address， 1：vote address
  dynamic txData;
  final myController = TextEditingController();
  String hex;
  Widget buildFooter(BuildContext context, AssetWithdrawVM viewModel) {
    return Container(
      // color: context.bgPrimaryColor,
      color: Color(0xFF17191C),
      padding: context.edgeAll.copyWith(
        bottom: context.edgeSize + context.safeAreaBottom,
      ),
      child: Padding(
        padding: context.edgeHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: CSButton(
                label: tr('asset:lbl_vote_button'),
                onPressed: () {
                  handleCreateTransaction(context, viewModel, true);
                },
                bordered: true,
                backgroundColor: Color(0xFF2f3741),
                textColor: context.placeholderColor,
              ),
            ),
            SizedBox(width: context.edgeSize),
            Flexible(
              child: CSButton(
                label: tr('asset:lbl_withdrawal_button'),
                backgroundColor: Color(0xFF2f3741),
                textColor: context.placeholderColor,
                onPressed: () {
                  handleCreateTransaction(context, viewModel, false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleCreateTransaction(BuildContext context, AssetWithdrawVM viewModel, bool isTou) {
    assemblyTransaction(isTou);
    print('insufficientBalance $insufficientBalance');
    if(!insufficientBalance) {
      showPasswordDialog(
        context,
            (password) => viewModel.doUnlockWallet(password),
            (walletData, _) async {
          WalletActionBBCTxSubmit.reduceDpos(txData, walletData.mnemonic)
              .then((res) {
            AssetRepository()
                .submitTransaction(hex: res.toString())
                .then((hexRes) => {
                  Toast.show(tr('asset:operating_success')),
                  AppNavigator.goBack()
                });
          });
        },
      );
    } else {
      Toast.show(tr('asset:insufficient_address_balance'));
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      superNodeAddress = widget.voteNodeItem['address'].toString();
      superNodeName = widget.voteNodeItem['name'].toString();
      addressBalance = widget.coinInfo.balance.toString();
    });
    // print('dddd ${widget.coinInfo}');
    getWalletBalance(widget.coinInfo.address);
    getVoteAddress();
    getCompoundInterestAddress();
  }
//get vote address balance
  void getVoteAddressBalance(address) async {
    var res = await AssetRepository()
        .getCoinBalance(address: address.toString(), symbol: 'HAH');
    setState(() {
      voteAddressBalance = res['balance'].toString();
      voteLockedAmount = res['locked'].toString();
    });
    print('投票地址余额 $res $address');
  }
  //get address balance
  void getCompoundInterestAddressBalance(address) async {
    var res = await AssetRepository().getCoinBalance(address: address.toString(), symbol: 'HAH');
    setState(() {
      compoundInterestAddressBalance = res['balance'].toString();
      fuliLockedAmount = res['locked'].toString();
    });
  }
//get wallet address balance
  void getWalletBalance(address) async {
    var res = await AssetRepository().getCoinBalance(address: address.toString(), symbol: 'HAH');
    setState(() {
      // addressBalance = res['balance'].toString();
    });
  }

//
  void assemblyTransaction(bool isTou) {
    print('isTou $voteAddressBalance $compoundInterestAddressBalance $addressBalance');
    // if(!isTou) { //撤投
    //   if(status == 1) {
    //     insufficientBalance = double.parse(voteAddressBalance) < double.parse(addressBalance);
    //   } else {
    //     insufficientBalance = double.parse(compoundInterestAddressBalance) < double.parse(addressBalance);
    //   }
    // } else {
    //   insufficientBalance = false;
    // }
    dynamic address;
    if (status == 1) {
      address = nodeAddress;
    } else {
      address = compoundInterestAddress;
    }
    if (isTou) {
      fetchNonceData(widget.coinInfo.address.toString(), isTou);
    } else {
      fetchNonceData(address, isTou);
    }
  }

  //get vote address
  void getVoteAddress() {
    final ret = getVote(widget.voteNodeItem['address'].toString(),
        widget.coinInfo.address.toString(), 1);
    setState(() {
      nodeAddress = ret['address'].toString();
      hex = ret['hex'].toString();
    });
    getVoteAddressBalance(nodeAddress);
  }

  //get address
  void getCompoundInterestAddress() {
    final ret = getVote(widget.voteNodeItem['address'].toString(),
        widget.coinInfo.address.toString(), 0);
    setState(() {
      compoundInterestAddress = ret['address'].toString();
    });
    getCompoundInterestAddressBalance(compoundInterestAddress);
  }

  // get nonce
  void fetchNonceData(addressNonce, bool isTou) async {
    print('isTou $isTou');
    dynamic address;
    if (status == 1) {
      address = nodeAddress;
    } else {
      address = compoundInterestAddress;
    }
    var res = await AssetRepository()
        .getTransactionFee(address: addressNonce.toString(), symbol: 'HAH');
    final time = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();
    final params = {
      'time': time,
      'fork': AppConstants.hah_fork,
      'nonce': res['nonce'] + 1,
      'from': isTou ? widget.coinInfo.address : address,
      'to': isTou ? address : widget.coinInfo.address,
      'amount': myController.text,
      'gasprice': '0.00000000000001',
      'gaslimit': '20000',
      'data': isTou ? '01010146$hex' : '00'
    };
    final ret = getTx(params);
    print('$ret');
    print('$params');

    setState(() {
      txData = ret;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return CSScaffold(
      headerBgColor: context.mainColor,
      backgroundColor: context.mainColor,
      scrollable: true,
      title: tr('asset:lbl_vote_detail'),
      child: StoreConnector<AppState, AssetWithdrawVM>(
        distinct: true,
        converter: AssetWithdrawVM.fromStore,
        onInitialBuild: (viewModel) {},
        builder: (context, viewModel) => Column(
          children: [
            Form(
              key: formKey,
//              autovalidateMode: autovalidate.value
//                  ? AutovalidateMode.onUserInteraction
//                  : AutovalidateMode.disabled,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//                   AssetCoinBox(
// //                    title: tr('asset:withdraw_lbl_coin'),
//                     title: tr('asset:lbl_vote_currency'),
//                     coinInfo: null,
//                   ),
                  FormBox(
                    type: FormBoxType.inputText,
//                    title: tr('asset:withdraw_lbl_address'),
                    title: tr('asset:super_node_address'), //super node address
                    hintText: tr(superNodeAddress),
                    // iconName: CSIcons.Scan,
                    // iconColor: context.bodyColor,
                    readOnly: true,
                    onPressIcon: () {
//                      handleOpenAddressScan(viewModel);
                    },
//                    controller: address,
                    titleAction: Transform.translate(
                      offset: Offset(context.edgeSize, 0),
                      child: CSButton(
                        // label: tr('asset:withdraw_btn_address'),
                        height: 30,
                        textStyle: context
                            .textBody(color: context.placeholderColor)
                            .copyWith(
                              decoration: TextDecoration.underline,
                            ),
                        autoWidth: true,
                        backgroundColor: Colors.transparent,
                        onPressed: () {},
                      ),
                    ),
                    maxLines: null,
                    onFocusChanged: (hasFocus) {
                      if (!hasFocus) {
//                        handleChangeAddress(viewModel);
                      }
                    },
                  ),
                  FormBox(
                    //super node name
                    type: FormBoxType.inputText,
//                    title: tr('asset:withdraw_lbl_address'),
                    title: tr('asset:super_node_name'), //super node address
                    // iconName: CSIcons.Scan,
                    // iconColor: context.bodyColor,
                    readOnly: true,
                    onPressIcon: () {
//                      handleOpenAddressScan(viewModel);
                    },
//                    controller: address,
                    hintText: tr(superNodeName),
                    titleAction: Transform.translate(
                      offset: Offset(context.edgeSize, 0),
                      child: CSButton(
                        // label: tr('asset:withdraw_btn_address'),
                        height: 30,
                        textStyle: context
                            .textBody(color: context.placeholderColor)
                            .copyWith(
                              decoration: TextDecoration.underline,
                            ),
                        autoWidth: true,
                        backgroundColor: Colors.transparent,
                        onPressed: () {},
                      ),
                    ),
                    maxLines: null,
                    onFocusChanged: (hasFocus) {
                      if (!hasFocus) {
//                        handleChangeAddress(viewModel);
                      }
                    },
                  ),
                  FormBox(
                    type: FormBoxType.inputText,
//                    title: tr('asset:withdraw_lbl_address'),
                    title: tr('asset:amount_of_votes'), //vote amount
                    // iconName: CSIcons.Scan,
                    // iconColor: context.bodyColor,
                    readOnly: true,
                    onPressIcon: () {
//                      handleOpenAddressScan(viewModel);
                    },
//                    controller: address,
                    hintText: tr(addressBalance),
                    titleAction: Transform.translate(
                      offset: Offset(context.edgeSize, 0),
                      child: CSButton(
                        // label: tr('asset:withdraw_btn_address'),
                        height: 30,
                        textStyle: context
                            .textBody(color: context.placeholderColor)
                            .copyWith(
                              decoration: TextDecoration.underline,
                            ),
                        autoWidth: true,
                        backgroundColor: Colors.transparent,
                        onPressed: () {},
                      ),
                    ),
                    maxLines: null,
                    onFocusChanged: (hasFocus) {
                      if (!hasFocus) {
//                        handleChangeAddress(viewModel);
                      }
                    },
                  ),
                  FormBox( //vote address balance
                    type: FormBoxType.inputText,
                    title: tr('wallet:vote_address_balance'),
                    readOnly: true,
                    hintText: tr(voteAddressBalance),
                  ),
                  FormBox( //vote address locked amount
                    type: FormBoxType.inputText,
                    title: tr('wallet:vote_address_locked_amount'),
                    readOnly: true,
                    hintText: tr(voteLockedAmount),
                  ),
                  FormBox( //address balance
                    type: FormBoxType.inputText,
                    title: tr('wallet:fuli_address_balance'),
                    readOnly: true,
                    hintText: tr(compoundInterestAddressBalance),
                  ),
                  FormBox( //address locked amount
                    type: FormBoxType.inputText,
                    title: tr('wallet:fuli_address_locked_amount'),
                    readOnly: true,
                    hintText: tr(fuliLockedAmount),
                  ),
                  Center(
                    child: Container(
                        width: 390,
                        decoration: new BoxDecoration(
                          color: Color(0xFF17191C),
                          borderRadius:
                              new BorderRadius.circular((12.0)),
                        ),
                        child: Column(
                          children: [
                            RadioListTile(
                                //vote address
                                value: 1,
                                onChanged: (value) {
                                  setState(() {
                                    this.status = value;
                                  });
                                },
                                groupValue: this.status,
                                // title: Text("asset:lbl_vote_address"),
                                title: Text(tr('asset:lbl_vote_address')),
                                subtitle: Text(nodeAddress),
                                selected: this.status == 1,
                                activeColor: context.placeholderColor),
                            RadioListTile(
                                //address
                                value: 0,
                                onChanged: (value) {
                                  setState(() {
                                    this.status = value;
                                  });
                                },
                                groupValue: this.status,
                                title:
                                    Text(tr('asset:compound_interest_address')),
                                subtitle: Text(compoundInterestAddress),
                                selected: this.status == 0,
                                activeColor:context.placeholderColor),
                          ],
                        )),
                  ),

                  FormBox(
                    type: FormBoxType.inputNumber,
                    title: tr('asset:lbl_vote_number'),
                    maxLength: 25,
                    controller: myController,
                    validator: RequiredValidator(
                      errorText: tr('asset:defi_vote_number'),
                    ),
                    // inputFormatters: [
                    //   DecimalTextInputFormatter(
                    //     decimalRange: coinInfo.chainPrecision,
                    //   ),
                    // ],
                    //  iconName: CSIcons.All,
                    // iconSize: 27,
//                     onPressIcon: () {
// //                      handleWithdrawAll(viewModel);
//                     },
//                       onChanged: (d) {
//                         bool test = myController.text - 4 > 0;
//
//                       },
                    hintText: tr('asset:defi_vote_number'),
                    onFocusChanged: (hasFocus) {
                      if (!hasFocus) {
                        bool exceedBalance = double.parse(addressBalance) -
                                0.01 -
                                int.parse(myController.text) <
                            0;
                        if (exceedBalance) {
                          myController.text =
                              (double.parse(addressBalance) - 0.01).toString();
                        }
                      }
                    },
                  ),
                  FormBox(
                      type: FormBoxType.inputText,
                      title: tr('asset:gas_free'),
                      iconColor: context.bodyColor,
                      hintText: tr('0.000001'),
                      maxLines: null,
                      readOnly: true)
                ],
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: context.edgeAll20,
              child: Text(
                tr('asset:withdraw_msg_attention'),
                style: context.textSecondary(color: context.redColor),
                textAlign: TextAlign.center,
              ),
            ),
            buildFooter(context, viewModel),
          ],
        ),
      ),
    );
  }
}
