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
  String nodeAddress = "";
  dynamic nonce;
  dynamic gas_price;
  dynamic gas_limit;
  final myController = TextEditingController();

  Widget buildFooter(BuildContext context) {
    return Container(
      color: context.bgPrimaryColor,
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
                  handleCreateTransaction(true);
                },
                bordered: true,
                backgroundColor: context.bgPrimaryColor,
              ),
            ),
            SizedBox(width: context.edgeSize),
            Flexible(
              child: CSButton(
                label: tr('asset:lbl_withdrawal_button'),
                onPressed: () {
                  handleCreateTransaction(false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleCreateTransaction(isTou) {
    print("操作了 $isTou");

    var time = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
    var params = {
      "time": time,
      "fork": "",
      "nonce": nonce,
      "from": widget.coinInfo.address,
      "to": widget.voteNodeItem["address"],
      "amount": myController.text,
      "gasprice": gas_price,
      "gaslimit": gas_limit,
      "data": ""
    };
    print("ppppp $params");
    AssetRepository()
        .createTransaction(
            time: time,
            fork: "",
            nonce: nonce,
            from: widget.coinInfo.address,
            to: widget.voteNodeItem['address'],
            amount: myController.text,
            gasprice: gas_price,
            gaslimit: gas_limit,
            data: "")
        .then((res) => {print("看看结果 $res"), AppNavigator.popWithResult(true)});
    print("ppppp $params");
  }

  @override
  void initState() {
    super.initState();

    print("参数啊 voteNodeItem 17wcpy");
    print(widget.voteNodeItem);
    print(widget.coinInfo.address);

    // 投票地址生成
    AssetRepository()
        .getVoteNodeDetail(
            delegate: widget.voteNodeItem["address"].toString(),
            owner: widget.coinInfo.address.toString(),
            rewardmode: 0)
        .then((res) => {
              print(res),
              setState(() {
                nodeAddress = res['address'];
              }),
            });

    // 获取nos
    fetchNosData();
  }

  fetchNosData() async {
    var res = await AssetRepository().getTransactionFee(
        address: widget.coinInfo.address.toString(), symbol: "HAH");
    setState(() {
      nonce = res["nonce"];
      gas_price = res["gas_price"];
      gas_limit = res["gas_limit"];
    });
    print("noos ==== == = = =");
    print(nonce);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return CSScaffold(
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
                  AssetCoinBox(
//                    title: tr('asset:withdraw_lbl_coin'),
                    title: tr('asset:lbl_vote_currency'),
                    coinInfo: null,
                  ),
                  FormBox(
                    type: FormBoxType.inputText,
//                    title: tr('asset:withdraw_lbl_address'),
                    title: tr('asset:lbl_vote_address'),
                    iconName: CSIcons.Scan,
                    iconColor: context.bodyColor,
                    readOnly: true,
                    onPressIcon: () {
//                      handleOpenAddressScan(viewModel);
                    },
//                    controller: address,
                    hintText: tr(nodeAddress),
                    titleAction: Transform.translate(
                      offset: Offset(context.edgeSize, 0),
                      child: CSButton(
                        label: tr('asset:withdraw_btn_address'),
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
                    type: FormBoxType.inputNumber,
//                    title: tr('asset:withdraw_lbl_amount'),
                    title: tr('asset:lbl_vote_number'),
                    maxLength: 25,
                    controller: myController,
                    validator: RequiredValidator(
                      errorText: tr('请输入投票数量'),
                    ),
//                    inputFormatters: [
//                      DecimalTextInputFormatter(
//                        decimalRange: coinInfo.chainPrecision,
//                      ),
//                    ],
                    iconName: CSIcons.All,
                    iconSize: 27,
                    onPressIcon: () {
//                      handleWithdrawAll(viewModel);
                    },
                    hintText: tr('请输入投票数量'),
                    onFocusChanged: (hasFocus) {
                      if (!hasFocus) {}
                    },
                  ),
                  FormBox(
                      type: FormBoxType.inputText,
                      title: tr('旷工费'),
                      iconColor: context.bodyColor,
                      hintText: tr("0.01"),
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
            buildFooter(context),
          ],
        ),
      ),
    );
  }
}
