part of swap_ui_module;

class SwapCreatePage extends HookWidget {
  SwapCreatePage({Key key}) : super(key: key);
  static const routeName = '/swap/create';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(settings, SwapCreatePage());
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fieldAmount = useTextEditingController(text: '');
    final fromCoinConfig = useState<SwapConfigCoin>(null);
    final toCoinConfig = useState<SwapConfigCoin>(null);
    final fromCoinInfo = useState<AssetCoin>(null);
    final toCoinInfo = useState<AssetCoin>(null);
    final autovalidate = useState(false);
    final approveBalance = useState<double>(null);
    final approveBalanceLoading = useState(false);

    final transferMin = fromCoinConfig.value?.transferMin ?? 1;
    final transferMax = fromCoinConfig.value?.transferMax ?? 1;

    final needApprove = fromCoinConfig.value?.isChainNeedApprove == true &&
        (approveBalance.value ?? 0) <= 0;

    void doUpdateApproveBalance(
      SwapCreateVM viewModel,
      SwapConfigCoin coinConfig,
    ) {
      approveBalanceLoading.value = true;
      viewModel
          .getApproveBalance(
        chain: coinConfig.chain,
        symbol: coinConfig.symbol,
      )
          .then((value) {
        approveBalance.value = value;
        approveBalanceLoading.value = false;
      }).catchError((error) {
        approveBalance.value = null;
        approveBalanceLoading.value = false;
        Toast.showError(error);
      });
    }

    void doChangeDirection(
      SwapCreateVM viewModel,
      MapEntry<SwapConfigCoin, SwapConfigCoin> pair,
    ) {
      formKey.currentState.reset();

      fromCoinConfig.value = pair.key;
      toCoinConfig.value = pair.value;

      final fromCoin = fromCoinInfo.value;
      fromCoinInfo.value = toCoinInfo.value;
      toCoinInfo.value = fromCoin;

      if (fromCoinConfig.value.isChainNeedApprove &&
          approveBalanceLoading.value != true &&
          approveBalance.value == null) {
        doUpdateApproveBalance(viewModel, fromCoinConfig.value);
      }
    }

    void doChangeCoin(
      SwapCreateVM viewModel,
      MapEntry<SwapConfigCoin, SwapConfigCoin> pair,
    ) {
      fieldAmount.clear();
      formKey.currentState.reset();
      approveBalance.value = null;
      approveBalanceLoading.value = false;

      fromCoinConfig.value = pair.key;
      toCoinConfig.value = pair.value;

      fromCoinInfo.value = viewModel.getCoinInfo(
        chain: fromCoinConfig.value.chain,
        symbol: fromCoinConfig.value.symbol,
      );
      toCoinInfo.value = viewModel.getCoinInfo(
        chain: toCoinConfig.value.chain,
        symbol: toCoinConfig.value.symbol,
      );

      if (fromCoinConfig.value.isChainNeedApprove &&
          approveBalanceLoading.value != true) {
        doUpdateApproveBalance(viewModel, fromCoinConfig.value);
      }
    }

    void doResetApproveBalance(SwapCreateVM viewModel) {
      if (approveBalance.value != null && approveBalance.value <= 0) {
        Toast.show(
          tr('swap:create_msg_error_approve_balance_zero'),
        );
        return;
      }
      showConfirmDialog(
        context,
        content: tr('swap:create_msg_approve_reset_confirm'),
        onConfirm: () {
          SwapSubmitProcess.doApproveSwap(
            context,
            viewModel,
            outCoinInfo: fromCoinInfo.value,
            outCoinConfig: fromCoinConfig.value,
            userReset: true,
            onSuccessTransaction: (txId) {
              doUpdateApproveBalance(viewModel, fromCoinConfig.value);
            },
          );
        },
      );
    }

    Future<void> handleSubmit(SwapCreateVM viewModel) async {
      final isValid = formKey.currentState.validate();
      if (!autovalidate.value) {
        autovalidate.value = true;
      }

      if (!isValid) {
        return;
      }

      if (NumberUtil.isLessOrEqual(fieldAmount.text, transferMin)) {
        Toast.show(tr(
          'swap:create_req_receive',
          namedArgs: {
            'min': transferMin.toString(),
            'max': transferMax.toString(),
            'symbol': fromCoinInfo.value.name,
          },
        ));
        return;
      }

      if (fromCoinInfo.value.balance <= 0) {
        return Toast.show(tr('swap:create_msg_error_balance'));
      }

      formKey.currentState.save();

      if (needApprove) {
        SwapSubmitProcess.doApproveSwap(
          context,
          viewModel,
          outCoinInfo: fromCoinInfo.value,
          outCoinConfig: fromCoinConfig.value,
          userReset: false,
          onSuccessTransaction: (txId) {
            doUpdateApproveBalance(viewModel, fromCoinConfig.value);
          },
        );
      } else {
        SwapSubmitProcess.doSubmitSwap(
          context,
          viewModel,
          amount: fieldAmount.text,
          inCoinInfo: toCoinInfo.value,
          outCoinInfo: fromCoinInfo.value,
          inCoinConfig: toCoinConfig.value,
          outCoinConfig: fromCoinConfig.value,
          onSuccessTransaction: (txId) {
            Toast.show(tr('swap:create_msg_exchange_success'));
            AppNavigator.gotoTabBar();
          },
        );
      }
    }

    void doSwapAll(SwapCreateVM viewModel) {
      fieldAmount.text = fromCoinInfo.value.balance.toString();
    }

    return CSScaffold(
      title: tr('swap:create_title'),
      actions: [
        CSButtonIcon(
          icon: CSIcons.Mark,
          size: 20,
          padding: EdgeInsets.zero,
          background: Colors.transparent,
          onPressed: () {
            showSwapTipDialog(context);
          },
        ),
      ],
      child: StoreConnector<AppState, SwapCreateVM>(
        distinct: true,
        onInitialBuild: (viewModel) {
          final enabledTradePairs = viewModel.getEnabledTradePairs();
          if (enabledTradePairs != null && enabledTradePairs.isNotEmpty) {
            doChangeCoin(viewModel, enabledTradePairs.first);
          }
        },
        converter: SwapCreateVM.fromStore,
        builder: (context, viewModel) => ModelPermissionView(
          onRefreshSuccess: () {
            final enabledTradePairs = viewModel.getEnabledTradePairs();
            if (enabledTradePairs != null && enabledTradePairs.isNotEmpty) {
              doChangeCoin(viewModel, enabledTradePairs.first);
            }
          },
          moduleName: ModuleName.swap,
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
                      SwapCoin(
                        fromCoin: fromCoinConfig.value,
                        toCoin: toCoinConfig.value,
                        coinList: viewModel.getEnabledTradePairs(),
                        doChangeDirection: (value) {
                          doChangeDirection(viewModel, value);
                        },
                        onChangeCoin: (value) {
                          doChangeCoin(viewModel, value);
                        },
                      ),
                      if (fromCoinConfig.value?.isChainNeedApprove == true)
                        SwapApproveBalance(
                          approveBalance: approveBalance.value,
                          isRefreshing: approveBalanceLoading.value,
                          onGetApproveBalance: () {
                            doUpdateApproveBalance(
                              viewModel,
                              fromCoinConfig.value,
                            );
                          },
                          onResetApproveBalance: () {
                            doResetApproveBalance(viewModel);
                          },
                        ),
                      FormBox(
                        type: FormBoxType.inputNumber,
                        title: tr(
                          'swap:create_lbl_amount',
                          namedArgs: {
                            'symbol': fromCoinConfig.value?.name ?? '',
                          },
                        ),
                        hintText: tr('swap:create_hint_amount'),
                        controller: fieldAmount,
                        initialValue: '',
                        maxLength: 25,
                        validator: RangeValidator(
                          min: transferMin,
                          max: transferMax,
                          graterThen: true,
                          isRequired: true,
                          errorText: tr(
                            'swap:create_req_amount',
                            namedArgs: {
                              'min': transferMin.toString(),
                              'max': transferMax.toString(),
                              'symbol': fromCoinInfo.value?.name ?? '',
                            },
                          ),
                        ),
                        inputFormatters: [
                          DecimalTextInputFormatter(
                            decimalRange:
                                fromCoinInfo.value?.chainPrecision ?? 8,
                          ),
                        ],
                        iconName: CSIcons.All,
                        iconSize: 27,
                        onPressIcon: () {
                          doSwapAll(viewModel);
                        },
                      ),
                      Padding(
                        padding: context.edgeAll.copyWith(top: 0),
                        child: AssetBalanceListener(
                          item: fromCoinInfo.value,
                          builder: (context, {balance, unconfirmed, data}) =>
                              Text(
                            tr(
                              'swap:create_lbl_balance',
                              namedArgs: {
                                'balance': balance,
                                'symbol': fromCoinInfo.value?.name ?? '',
                              },
                            ),
                            style: context.textSecondary(),
                          ),
                        ),
                      ),
                      ValueListenableBuilder<TextEditingValue>(
                          valueListenable: fieldAmount,
                          builder: (context, value, _) {
                            final total = NumberUtil.minus<double>(
                              NumberUtil.getDouble(value.text),
                              toCoinConfig?.value?.transferFee ?? 0,
                            );
                            return FormBox(
                              key: ValueKey(value),
                              type: FormBoxType.child,
                              editable: false,
                              title: tr('swap:create_lbl_receive'),
                              child: CSContainer(
                                margin: EdgeInsets.zero,
                                height: 65,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        total <= 0 ? '-' : total.toString(),
                                        style: context.textBody(),
                                      ),
                                    ),
                                    Container(
                                      height: 28,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        toCoinConfig.value?.name ?? '',
                                        style: context.textBody(bold: true),
                                        maxLines: 1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: context.edgeAll.copyWith(top: 0),
                        child: Text(
                          tr('swap:create_msg_tip_receive'),
                          style: context.textSecondary(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                CSButton(
                  label: needApprove
                      ? tr('swap:create_btn_approve')
                      : tr('swap:create_btn_submit'),
                  onPressed: () {
                    handleSubmit(viewModel);
                  },
                ),
                // Padding(
                //   padding: context.edgeAll,
                //   child: Text(
                //     tr('swap:create_msg_tip_network'),
                //     style: context.textSecondary(),
                //   ),
                // ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
