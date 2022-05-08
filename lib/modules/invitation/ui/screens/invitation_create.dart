part of invitation_ui_module;

class InvitationCreatePage extends HookWidget {
  InvitationCreatePage(this.defaultCoin);
  final AssetCoin defaultCoin;

  static const routeName = '/invitation/create';

  static void open([AssetCoin coinInfo]) {
    AppNavigator.push(routeName, params: coinInfo);
  }

  static Route<dynamic> route(RouteSettings settings) {
    final arg = settings.arguments;
    return DefaultTransition(
      settings,
      InvitationCreatePage(arg != null ? arg as AssetCoin : null),
    );
  }

  final formKey = GlobalKey<FormState>();

  Future<void> doSubmit(
    BuildContext context, {
    @required AssetCoin coinInfo,
    @required InvitationCreateVM viewModel,
    @required String address,
    @required String signCode,
    @required String sharePrvKey,
    @required String amount,
  }) async {
    final isValid = formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    final confirmTip = await showConfirmSubmit(context);
    if (!confirmTip) {
      return;
    }

    formKey.currentState.save();
    InvitationSubmitProcess.doSubmit(
      context: context,
      viewModel: viewModel,
      amount: amount,
      toAddress: address,
      signCode: signCode,
      getCoinInfo: viewModel.getCoinInfo,
      sharePrvKey: sharePrvKey,
      coinInfo: coinInfo,
      onSuccessTransaction: (txId) {
        AnalyticsReport().reportLog('Invitation_Create_Action', {
          'walletId': viewModel.walletId,
          'chain': coinInfo.chain,
          'symbol': coinInfo.chain,
          'toAddress': address,
        });

        LoadingDialog.dismiss(context);
        Toast.show(tr('invitation:defi_create_msg_success'));
        AppNavigator.goBack();
      },
    );
  }

  Future<bool> showConfirmSubmit(BuildContext context) {
    final completer = Completer<bool>();
    showConfirmDialog(
      context,
      content: tr('invitation:defi_create_dialog_tip'),
      cancelBtnText: tr('global:btn_return'),
      confirmBtnText: tr('global:btn_continue'),
      onConfirm: () => completer.complete(true),
      onCancel: () => completer.complete(false),
    );
    return completer.future;
  }

  void showCoinSelect({
    @required BuildContext context,
    @required InvitationCreateVM viewModel,
    @required ValueNotifier<AssetCoin> coinInfo,
    @required TextEditingController address,
    @required TextEditingController signCode,
    @required TextEditingController sharePrvKey,
    @required TextEditingController amount,
    @required ValueNotifier<double> miniAmount,
  }) {
    InvitationCoinSelectPage.open().then((coin) {
      if (coinInfo.value.chain != coin.chain ||
          coinInfo.value.symbol != coin.symbol) {
        coinInfo.value = coin;
        address.text = '';
        signCode.text = '';
        sharePrvKey.text = '';
        amount.text = '';

        final mini = GetIt.I<CoinConfig>().getTransferMinQuota(
          chain: coin.chain,
          symbol: coin.symbol,
        );
        miniAmount.value = mini;
      }
    });
  }

  void handleWithdrawMini(
    TextEditingController amount,
    AssetCoin coinInfo,
  ) {
    final mini = GetIt.I<CoinConfig>().getTransferMinQuota(
      chain: coinInfo.chain,
      symbol: coinInfo.symbol,
    );
    amount.text = '$mini';
  }

  @override
  Widget build(BuildContext context) {
    final address = useTextEditingController(text: '');
    final signCode = useTextEditingController(text: '');
    final sharePrvKey = useTextEditingController(text: '');
    final amount = useTextEditingController(text: '');
    final coinInfo = useState<AssetCoin>(defaultCoin);
    final autovalidate = useState(false);
    final feeIsRefreshing = useState(false);
    final miniAmount = useState<double>(0);
    final coinName = coinInfo.value?.name ?? '';

    void openQrScan() {
      QRScannerPage.open().then((qrStr) {
        if (qrStr != null && qrStr.isNotEmpty) {
          InvitationCodeUtils.decodeQRCodeData(
            chain: coinInfo.value.chain,
            symbol: coinInfo.value.symbol,
            data: qrStr,
          ).then((value) {
            address.text = value[0];
            signCode.text = value[1];
            sharePrvKey.text = value[2];
          }).catchError((e) {
            Toast.showError(e);
          });
        }
      });
    }

    void handleSubmit(InvitationCreateVM viewModel) {
      if (feeIsRefreshing.value == true) {
        return Toast.show(tr('asset:withdraw_msg_fee_loading'));
      }

      if (NumberUtil.isLess(amount.text, miniAmount.value)) {
        return Toast.show(tr(
          'asset:withdraw_req_minimum',
          namedArgs: {'value': '${miniAmount.value}', 'symbol': coinName},
        ));
      }

      if (coinInfo.value.address == address.text) {
        return Toast.show(tr('invitation:defi_create_msg_self'));
      }

      if (!autovalidate.value) {
        autovalidate.value = true;
      }

      doSubmit(
        context,
        viewModel: viewModel,
        coinInfo: coinInfo.value,
        amount: amount.text,
        signCode: signCode.text,
        sharePrvKey: sharePrvKey.text,
        address: address.text,
      );
    }

    void loadDefaultCoin(InvitationCreateVM viewModel) {
      final coins = viewModel.getInvitationCoins();
      if (coins?.isNotEmpty == true) {
        final defaultCoin = coinInfo.value ?? coins.first;
        final mini = GetIt.I<CoinConfig>().getTransferMinQuota(
          chain: defaultCoin.chain,
          symbol: defaultCoin.symbol,
        );
        miniAmount.value = mini;
        coinInfo.value = defaultCoin;
      }
    }

    return CSScaffold(
      title: tr('invitation:defi_create_title'),
      child: StoreConnector<AppState, InvitationCreateVM>(
        distinct: true,
        converter: InvitationCreateVM.fromStore,
        onInitialBuild: (viewModel) {
          loadDefaultCoin(viewModel);
        },
        builder: (context, viewModel) => ModelPermissionView(
          moduleName: ModuleName.invitation,
          onRefreshSuccess: () {
            loadDefaultCoin(viewModel);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  autovalidateMode: autovalidate.value
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AssetCoinBox(
                        title: tr('invitation:defi_create_lbl_coin'),
                        coinInfo: coinInfo.value,
                        onPress: () {
                          showCoinSelect(
                            context: context,
                            viewModel: viewModel,
                            coinInfo: coinInfo,
                            address: address,
                            signCode: signCode,
                            sharePrvKey: sharePrvKey,
                            amount: amount,
                            miniAmount: miniAmount,
                          );
                        },
                      ),
                      FormBox(
                        type: FormBoxType.child,
                        margin: context.edgeAll.copyWith(bottom: 0),
                        title: tr('invitation:defi_create_lbl_scan_code'),
                        titleAction: CSButtonIcon(
                          padding: EdgeInsets.zero,
                          containerSize: 28,
                          size: 18,
                          borderRadius: 8,
                          onPressed: openQrScan,
                          icon: CSIcons.Scan,
                        ),
                        child: SizedBox(),
                      ),
                      // 地址
                      FormBox(
                        type: FormBoxType.inputText,
                        title: tr('invitation:defi_create_lbl_address'),
                        validator: RequiredValidator(
                          errorText: tr('invitation:defi_create_req_address'),
                        ),
                        maxLength: 128,
                        controller: address,
                        hintText: tr('invitation:defi_create_req_address'),
                        maxLines: null,
                      ),
                      // 邀请码
                      FormBox(
                        type: FormBoxType.inputText,
                        title: tr('invitation:defi_create_lbl_code'),
                        validator: RequiredValidator(
                          errorText: tr('invitation:defi_create_req_code'),
                        ),
                        maxLength: 128,
                        controller: signCode,
                        hintText: tr('invitation:defi_create_hint_code'),
                        maxLines: null,
                      ),
                      // 分享私钥
                      FormBox(
                        type: FormBoxType.inputText,
                        title: tr('invitation:defi_create_lbl_prvkey'),
                        validator: RequiredValidator(
                          errorText: tr('invitation:defi_create_req_prvkey'),
                        ),
                        maxLength: 128,
                        controller: sharePrvKey,
                        hintText: tr('invitation:defi_create_hint_prvkey'),
                        maxLines: null,
                      ),
                      //金额
                      FormBox(
                        type: FormBoxType.inputNumber,
                        inputTextStyle: context.textBody(bold: true),
                        title: tr('invitation:defi_create_lbl_amount'),
                        controller: amount,
                        maxLength: 25,
                        validator: RequiredValidator(
                          errorText: tr('asset:withdraw_req_amount'),
                        ),
                        inputFormatters: [
                          DecimalTextInputFormatter(
                            decimalRange: coinInfo.value?.chainPrecision ?? 8,
                          ),
                        ],
                        onPressIcon: () {
                          handleWithdrawMini(amount, coinInfo.value);
                        },
                        iconName: CSIcons.Min,
                        iconSize: 27,
                        hintText: tr(
                          'invitation:defi_hint_minimum',
                          namedArgs: {
                            'symbol': coinName,
                            'value': miniAmount.value.toString(),
                          },
                        ),
                      ),
                      if (coinInfo.value != null)
                        Padding(
                          padding: context.edgeAll,
                          child: AssetBalanceListener(
                            item: coinInfo.value,
                            builder: (context, {balance, unconfirmed, data}) =>
                                Text(
                              tr(
                                'asset:lbl_balance',
                                namedArgs: {
                                  'balance': balance,
                                  'symbol': coinName,
                                },
                              ),
                              style: context.textSecondary(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: context.edgeAll,
                  child: Text(
                    tr('invitation:defi_create_tip'),
                    style: context.textSecondary(color: context.redColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: context.edgeSize),
                ButtonDisableListener(
                  listenValues: [address, signCode, sharePrvKey, amount],
                  builder: (disabled) {
                    return CSButton(
                      disabled: disabled,
                      label: tr('invitation:defi_btn_create'),
                      onPressed: () {
                        handleSubmit(viewModel);
                      },
                    );
                  },
                ),
                SizedBox(height: context.edgeSizeDouble),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
