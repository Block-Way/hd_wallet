part of admission_ui_module;

class AdmissionCreatePage extends HookWidget {
  const AdmissionCreatePage(this.info);
  final AdmissionInfo info;

  static const routeName = '/admission/create';
  static void open(AdmissionInfo info) {
    AppNavigator.push(routeName, params: info);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      AdmissionCreatePage(settings.arguments as AdmissionInfo),
    );
  }

  Future<void> doSubmit(
    BuildContext context, {
    @required AssetCoin coinInfo,
    @required AdmissionCreateVM viewModel,
  }) async {
    final address = info.transferCondition.address;
    final amount = info.transferCondition.transferAmount;
    final txData = info.transferCondition.transferData;

    AdmissionSubmitProcess.doSubmit(
      context: context,
      viewModel: viewModel,
      amount: amount,
      toAddress: address,
      txData: txData,
      coinInfo: coinInfo,
      getCoinInfo: viewModel.getCoinInfo,
      onSuccessTransaction: (txId) {
        AnalyticsReport().reportLog('Admission_Create_Action', {
          'walletId': viewModel.walletId,
          'chain': coinInfo.chain,
          'symbol': coinInfo.chain,
          'toAddress': address,
        });
        LoadingDialog.dismiss(context);
        Toast.show(tr('admission:create_msg_success'));
        AppNavigator.goBack();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final coinInfo = useState<AssetCoin>(null);
    final condition = useState<AdmissionCondition>(null);

    void initData(
      AdmissionCreateVM viewModel,
      ValueNotifier<AssetCoin> coinInfo,
    ) {
      final mCondition = info.transferCondition;
      if (mCondition == null || mCondition.transferFork.isEmpty) {
        AppNavigator.goBack();
        return;
      }

      final coin = viewModel.getCoinInfoByFork(mCondition.transferFork);
      coinInfo.value = coin;
      condition.value = mCondition;
    }

    return CSScaffold(
      title: tr('admission:create_title'),
      child: StoreConnector<AppState, AdmissionCreateVM>(
        distinct: true,
        converter: AdmissionCreateVM.fromStore,
        onInitialBuild: (viewModel) {
          initData(viewModel, coinInfo);
        },
        builder: (context, viewModel) => ModelPermissionView(
          moduleName: ModuleName.admission,
          onRefreshSuccess: () {
            initData(viewModel, coinInfo);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBox(
                      type: FormBoxType.child,
                      title: tr('admission:create_lbl_task_desc'),
                      child: CSContainer(
                        height: 170,
                        margin: EdgeInsets.zero,
                        child: SingleChildScrollView(
                          child: Text(
                            info.describe ?? '',
                            style: context.textSecondary(
                              color: context.bodyColor,
                              lineHeight: 1.61,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AssetCoinBox(
                      title: tr('admission:create_lbl_coin'),
                      coinInfo: coinInfo.value,
                    ),
                    FormBox(
                      type: FormBoxType.child,
                      title: tr('admission:create_lbl_amount'),
                      child: CSContainer(
                        height: 64,
                        margin: EdgeInsets.zero,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            condition.value?.transferAmount ?? '',
                            style: context.textBody(),
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ),
                    if (coinInfo.value != null)
                      Padding(
                        padding: context.edgeAll.copyWith(top: 0),
                        child: AssetBalanceListener(
                          item: coinInfo.value,
                          builder: (context, {balance, unconfirmed, data}) =>
                              Text(
                            tr(
                              'asset:lbl_balance',
                              namedArgs: {
                                'balance': balance,
                                'symbol': coinInfo.value?.name ?? '',
                              },
                            ),
                            style: context.textSmall(),
                          ),
                        ),
                      ),
                    FormBox(
                      type: FormBoxType.child,
                      title: tr('admission:create_lbl_address'),
                      child: CSContainer(
                        height: 64,
                        margin: EdgeInsets.zero,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            condition.value?.address ?? '',
                            style: context.textBody(),
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.edgeSizeDouble),
                CSButton(
                  label: tr('admission:create_btn_submit'),
                  onPressed: () {
                    doSubmit(
                      context,
                      viewModel: viewModel,
                      coinInfo: coinInfo.value,
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
