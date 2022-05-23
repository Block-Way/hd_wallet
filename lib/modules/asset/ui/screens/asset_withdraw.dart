part of asset_ui_module;

// 尚尚
class AssetWithdrawPage extends HookWidget {
  AssetWithdrawPage({Key key, this.coinInfo}) : super(key: key);

  final AssetCoin coinInfo;

  static const routeName = '/asset/withdraw';

  static void open(AssetCoin coinInfo) {
    AppNavigator.push(routeName, params: coinInfo);
  }

  static Route<dynamic> route(RouteSettings settings, [AssetCoin coinInfo]) {
    return DefaultTransition(
      settings,
      AssetWithdrawPage(coinInfo: coinInfo ?? settings.arguments as AssetCoin),
    );
  }

  final formKey = GlobalKey<FormState>();

  void doSubmit(
    BuildContext context,
    AssetWithdrawVM viewModel, {
    @required WalletWithdrawData withdrawInfo,
    @required String address,
    @required String amount,
  }) {
    final isValid = formKey.currentState.validate();

    if (!isValid) {
      return;
    }

    AnalyticsReport().reportLog('Asset_Withdraw_Submit', {
      'chain': coinInfo.chain,
      'symbol': coinInfo.symbol,
      'amount': amount,
    });
    formKey.currentState.save();

    AssetWithdrawProcess.doSubmitWithdraw(
      context,
      viewModel: viewModel,
      amount: NumberUtil.getDouble(amount),
      toAddress: address,
      withdrawData: withdrawInfo,
      chainPrecision: coinInfo.chainPrecision,
      onWithdrawSuccess: (txId) {
        LoadingDialog.dismiss(context);
        Toast.show(tr('asset:withdraw_msg_success'));
        AppNavigator.goBack();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final withdrawInfo = useState<WalletWithdrawData>(null);
    final address = useTextEditingController(text: '');
    final amount = useTextEditingController(text: '');
    final autovalidate = useState(false);
    final feeIsRefreshing = useState(false);

    void handleSubmit(AssetWithdrawVM viewModel) {
      if (feeIsRefreshing.value == true) {
        return Toast.show(tr('asset:withdraw_msg_fee_loading'));
      }

      if (withdrawInfo.value == null) {
        return Toast.show(tr('asset:withdraw_msg_get_fee'));
      }

      if (!autovalidate.value) {
        autovalidate.value = true;
      }

      doSubmit(
        context,
        viewModel,
        withdrawInfo: withdrawInfo.value,
        address: address.text,
        amount: amount.text,
      );
    }

    void handleChangeAddress(AssetWithdrawVM viewModel) {
      if (address.text.isNotEmpty &&
          AssetWithdrawProcess.getFeeOnChangeAddress.contains(coinInfo.chain) &&
          feeIsRefreshing.value == false &&
          withdrawInfo.value?.toAddress != address.text) {
        feeIsRefreshing.value = true;
        AssetWithdrawProcess.getWithdrawFee(
          coinInfo: coinInfo,
          viewModel: viewModel,
          previousWithdrawData: withdrawInfo.value,
          toAddress: address.text,
          amount: amount.text,
        ).then((value) {
          withdrawInfo.value = value;
        }).whenComplete(() {
          feeIsRefreshing.value = false;
        });
      }
    }

    void handleChangeAmount(AssetWithdrawVM viewModel) {
      if (amount.text.isNotEmpty &&
          AssetWithdrawProcess.getFeeOnChangeAmount.contains(coinInfo.chain) &&
          feeIsRefreshing.value == false) {
        feeIsRefreshing.value = true;
        AssetWithdrawProcess.getWithdrawFee(
          coinInfo: coinInfo,
          viewModel: viewModel,
          previousWithdrawData: withdrawInfo.value,
          toAddress: address.text,
          amount: amount.text,
        ).then((value) {
          withdrawInfo.value = value;
        }).whenComplete(() {
          feeIsRefreshing.value = false;
        });
      }
    }

    Future<void> handleChangeGas(String type) async {
      if (feeIsRefreshing.value == false) {
        feeIsRefreshing.value = true;
        final data = withdrawInfo.value;
        data.fee = await WalletFeeUtils.getFeeData(
          coinInfo: coinInfo,
          defaultFee: data.feeDefault,
          level: type,
          fromAddress: data?.fromAddress,
        );

        withdrawInfo.value = data;
        feeIsRefreshing.value = false;
      }
    }

    void onGetFee(AssetWithdrawVM viewModel) {
      if (address.text.isEmpty &&
          AssetWithdrawProcess.getFeeOnChangeAddress.contains(coinInfo.chain)) {
        return Toast.show(tr('asset:withdraw_req_address'));
      }
      if (feeIsRefreshing.value == false) {
        feeIsRefreshing.value = true;
        AssetWithdrawProcess.getWithdrawFee(
          coinInfo: coinInfo,
          viewModel: viewModel,
          previousWithdrawData: withdrawInfo.value,
          toAddress: address.text,
          amount: amount.text,
        ).then((value) {
          withdrawInfo.value = value;
        }).whenComplete(() {
          feeIsRefreshing.value = false;
        });
      }
    }

    void handleOpenAddressScan(AssetWithdrawVM viewModel) {
      QRScannerPage.open().then((toAddress) {
        if (toAddress != null && toAddress.isNotEmpty) {
          address.text = toAddress;
          handleChangeAddress(viewModel);
        }
      });
    }

    void handleWithdrawAll(AssetWithdrawVM viewModel) {
      final balance = viewModel.getCoinBalance(
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
      );
      if (withdrawInfo.value?.fee?.feeSymbol == coinInfo.symbol) {
        if (withdrawInfo.value.fee.feeValue > balance) {
          amount.text = '0';
        } else {
          amount.text = NumberUtil.minus<String>(
            balance,
            withdrawInfo.value.fee.feeValue,
          );
        }
      } else {
        // 矿工费 扣的不是当前币 那可以把余额全转出去
        amount.text =
            NumberUtil.truncateDecimal(balance, coinInfo.chainPrecision) ?? '0';
      }
    }

    return CSScaffold(
      scrollable: true,
      title: tr('asset:withdraw_title'),
      child: StoreConnector<AppState, AssetWithdrawVM>(
        distinct: true,
        converter: AssetWithdrawVM.fromStore,
        onInitialBuild: (viewModel) {
          if (AssetWithdrawProcess.getFeeOnInit.contains(coinInfo.chain)) {
            LoadingDialog.show(context);
            AssetWithdrawProcess.getWithdrawFee(
              viewModel: viewModel,
              coinInfo: coinInfo,
              previousWithdrawData: withdrawInfo.value,
              toAddress: '',
              amount: '0',
            ).then((value) {
              withdrawInfo.value = value;
            }).whenComplete(() {
              LoadingDialog.dismiss(context);
            });
          }
        },
        builder: (context, viewModel) => Column(
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
                    title: tr('asset:withdraw_lbl_coin'),
                    coinInfo: coinInfo,
                  ),
                  FormBox(
                    type: FormBoxType.inputText,
                    title: tr('asset:withdraw_lbl_address'),
                    iconName: CSIcons.Scan,
                    iconColor: context.bodyColor,
                    validator: RequiredValidator(
                      errorText: tr('asset:withdraw_req_address'),
                    ),
                    onPressIcon: () {
                      handleOpenAddressScan(viewModel);
                    },
                    controller: address,
                    hintText: tr('asset:withdraw_hint_address'),
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
                        onPressed: () {
                          AssetAddressListPage.open(coinInfo, address.text)
                              .then((value) {
                            if (value != address.text) {
                              address.text = value;
                              handleChangeAddress(viewModel);
                            }
                          });
                        },
                      ),
                    ),
                    maxLines: null,
                    onFocusChanged: (hasFocus) {
                      if (!hasFocus) {
                        handleChangeAddress(viewModel);
                      }
                    },
                  ),
                  FormBox(
                    type: FormBoxType.inputNumber,
                    title: tr('asset:withdraw_lbl_amount'),
                    controller: amount,
                    maxLength: 25,
                    validator: RequiredValidator(
                      errorText: tr('asset:withdraw_req_amount'),
                    ),
                    inputFormatters: [
                      DecimalTextInputFormatter(
                        decimalRange: coinInfo.chainPrecision,
                      ),
                    ],
                    iconName: CSIcons.All,
                    iconSize: 27,
                    onPressIcon: () {
                      handleWithdrawAll(viewModel);
                    },
                    hintText: tr('asset:withdraw_hint_amount'),
                    onFocusChanged: (hasFocus) {
                      if (!hasFocus) {
                        handleChangeAmount(viewModel);
                      }
                    },
                  ),
                  Padding(
                    padding: context.edgeAll.copyWith(top: 0),
                    child: AssetBalanceListener(
                      item: coinInfo,
                      builder: (context, {balance, unconfirmed, data}) => Text(
                        tr(
                          'asset:lbl_balance',
                          namedArgs: {
                            'balance': balance,
                            'symbol': coinInfo.name,
                          },
                        ),
                        style: context.textSecondary(),
                      ),
                    ),
                  ),
                  AssetWithdrawFee(
                    withdrawInfo: withdrawInfo.value,
                    isRefreshing: feeIsRefreshing.value,
                    onPress: (type) {
                      handleChangeGas(type);
                    },
                    onGetFee: () {
                      onGetFee(viewModel);
                    },
                  ),
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
            ButtonDisableListener(
              listenValues: [address, amount],
              builder: (disabled) {
                return CSButton(
                  label: tr('asset:withdraw_btn_withdraw'),
                  disabled: disabled,
                  onPressed: () {
                    handleSubmit(viewModel);
                  },
                );
              },
            ),
            SizedBox(height: context.edgeSize),
          ],
        ),
      ),
    );
  }
}
