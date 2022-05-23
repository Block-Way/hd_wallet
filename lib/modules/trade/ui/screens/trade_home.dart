part of trade_ui_module;

class TradeHomePage extends HookWidget {
  final refreshController = CSRefresherController();

  Future<void> doLoadData(
    BuildContext context, {
    @required TradeHomeVM viewModel,
    @required TradePair tradePair,
    @required StreamController<double> updateApproveBalance,
    bool isRefresh = false,
  }) {
    if (tradePair == null) {
      throw FlutterError('No Trade Pair');
    }
    if (isRefresh != true) {
      viewModel.doSubscribeMqtt(tradePair);
    }

    final tradeCoinInfo = viewModel.getCoinInfo(
      chain: tradePair.tradeChain,
      symbol: tradePair.tradeSymbol,
    );
    final priceCoinInfo = viewModel.getCoinInfo(
      chain: tradePair.priceChain,
      symbol: tradePair.priceSymbol,
    );

    return Future.wait([
      viewModel.doUpdateCoinBalance(tradePair),
      if (tradePair.isChainNeedApprove(viewModel.tradeSide))
        viewModel.getApproveBalance(tradePair).then((value) {
          if (!updateApproveBalance.isClosed) {
            updateApproveBalance.add(value);
          }
        }),
      GetIt.I<CoinPriceCubit>().updateSingle(tradePair.id),
      GetIt.I<FiatPriceCubit>().updateAll(),
      context.read<TradeTickersCubit>().loadData(tradePair),
      if (viewModel.hasWallet)
        GetIt.I<TradeOrdersPendingCubit>().loadData(
          walletId: viewModel.activeWalletId,
          tradePairId: tradePair.id,
          priceAddress: priceCoinInfo?.address,
          tradeAddress: tradeCoinInfo?.address,
        )
    ]);
  }

  void doShowSlowTip(
    BuildContext context,
    TradeHomeVM viewModel,
    TradePair tradePair,
  ) {
    if (viewModel.needShowSlowTradePair(tradePair)) {
      showConfirmDialog(
        context,
        content: tr('trade:trade_pair_msg_slow'),
        title: tr('global:dialog_important_title'),
        cancelBtnText: tr('global:btn_not_ask'),
        confirmBtnText: tr('global:btn_confirm'),
        onConfirm: () {
          //
        },
        onCancel: () {
          viewModel.doHideSlowTradePair(tradePair);
        },
      );
    }
  }

  Widget buildHeader(
    BuildContext context,
    TradeHomeVM viewModel,
    TradeOrdersPendingCubit tradeOrdersCubit,
    StreamController<String> updateOrderPrice,
    StreamController<double> updateApproveBalance,
  ) {
    return SizedBox(
      height: 410,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: HomeTickersCard(
              tradePair: viewModel.tradePair,
              onPressed: (price) {
                updateOrderPrice.sink.add(price);
              },
              onChangeSpan: (span) {
                context.read<TradeTickersCubit>().changeSpan(span);
              },
            ),
          ),
          Flexible(
            flex: 4,
            child: HomeInputCard(
              priceCoinInfo: viewModel.priceCoinInfo,
              tradeCoinInfo: viewModel.tradeCoinInfo,
              sideCoinInfo: viewModel.sideCoinInfo,
              sideCoinConfig: viewModel.sideCoinConfig,
              tradePair: viewModel.tradePair,
              tradeSide: viewModel.tradeSide,
              updatePriceEvent: updateOrderPrice.stream,
              updateApproveEvent: updateApproveBalance.stream,
              onChangeSide: (direction) {
                viewModel.doChangeTradeSide(direction);
                context.read<TradeTickersCubit>().loadData(viewModel.tradePair);
              },
              onApproveOrder: ({isReset}) {
                TradeOrderSubmitProcess.doApproveOrder(
                  context,
                  viewModel,
                  userReset: isReset,
                  coinInfo: viewModel.sideCoinInfo,
                  onSuccessTransaction: (txId) {
                    viewModel
                        .getApproveBalance(viewModel.tradePair)
                        .then((value) {
                      if (!updateApproveBalance.isClosed) {
                        updateApproveBalance.add(value);
                      }
                    });
                  },
                );
              },
              onSubmitOrder: ({price, amount, total}) {
                TradeOrderSubmitProcess.doCreateOrder(
                  context,
                  viewModel,
                  price: price,
                  amount: amount,
                  total: total,
                  onSuccessTransaction: (txId) {
                    tradeOrdersCubit.loadData(
                      walletId: viewModel.activeWalletId,
                      tradePairId: viewModel.tradePair.id,
                      tradeAddress: viewModel.tradeCoinInfo.address,
                      priceAddress: viewModel.priceCoinInfo.address,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tradeOrdersCubit = GetIt.I<TradeOrdersPendingCubit>();
    final updateOrderPrice = useStreamController<String>();
    final updateApproveBalance = useStreamController<double>();

    return TradeOrderMqttProvider(
      mqtt: GetIt.I<TradeMqtt>(),
      child: CSScaffold(
        hideLeading: true,
        titleCenter: false,
        headerBgColor: context.bgPrimaryColor,
        backgroundColor: Colors.transparent,
        title: tr('trade:title'),
        titleStyle: context.textHuge(fontWeight: FontWeight.w700),
        drawer: CSDrawer(
          width: context.mediaWidth * 0.826,
          elevation: 100,
          decoration: BoxDecoration(
            color: context.bgSecondaryColor,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(24.0),
            ),
          ),
          child: StoreConnector<AppState, TradeHomeVM>(
            distinct: true,
            converter: TradeHomeVM.fromStore,
            builder: (context, viewModel) => TradeSelectDrawer(
              selected: viewModel.tradePair,
              onSelected: (tradePair) {
                if (refreshController.isRefresh) {
                  refreshController.refreshCompleted();
                }
                updateApproveBalance.add(null);
                viewModel.doChangeTradePair(tradePair).then((_) {
                  doLoadData(
                    context,
                    viewModel: viewModel,
                    tradePair: tradePair,
                    updateApproveBalance: updateApproveBalance,
                  ).catchError((error) {
                    Toast.showError(error);
                  });
                });
              },
            ),
          ),
        ),
        child: StoreConnector<AppState, TradeHomeVM>(
          distinct: true,
          converter: TradeHomeVM.fromStore,
          onInitialBuild: (viewModel) {
            Toast.show(tr('swap:development'), duration: 30000);
            if (!viewModel.hasWallet) {
              tradeOrdersCubit.clearData();
            } else {
              doShowSlowTip(context, viewModel, viewModel.tradePair);
            }
            doLoadData(
              context,
              viewModel: viewModel,
              tradePair: viewModel.tradePair,
              updateApproveBalance: updateApproveBalance,
            ).catchError((error) {
              Toast.showError(error);
            });
          },
          builder: (context, viewModel) => Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: context.bgPrimaryColor,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                toolbarHeight: 46,
                title: Row(
                  children: [
                    TradeTitle(
                      tradePair: viewModel.tradePair,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Spacer(),
                  ],
                ),
                actions: [
                  CSButton(
                    flat: true,
                    padding: context.edgeHorizontal5,
                    customBorder: CircleBorder(),
                    onPressed: () {
                      if (!viewModel.hasWallet) {
                        AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
                        Toast.show(tr('wallet:msg_create_wallet_need'));
                        return;
                      }
                      SwapCreatePage.open();
                    },
                    child: RiveAnimation(
                      fileName: 'change',
                      animation: 'change',
                      width: 22,
                      isLoop: false,
                    ),
                  ),
                  CSButton(
                    flat: true,
                    padding: context.edgeHorizontal,
                    customBorder: CircleBorder(),
                    onPressed: () {
                      TradeChartPage.open(viewModel.tradePair);
                    },
                    child: RiveAnimation(
                      fileName: 'line',
                      animation: 'line',
                      width: 20,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CSRefresher(
                  controller: refreshController,
                  onRefresh: () {
                    doLoadData(
                      context,
                      viewModel: viewModel,
                      tradePair: viewModel.tradePair,
                      updateApproveBalance: updateApproveBalance,
                      isRefresh: true,
                    ).then((_) {
                      refreshController.refreshCompleted();
                    }).catchError((_) {
                      refreshController.refreshFailed();
                    });
                  },
                  header: ListViewHeader(),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      buildHeader(
                        context,
                        viewModel,
                        tradeOrdersCubit,
                        updateOrderPrice,
                        updateApproveBalance,
                      ),
                      HomeOrdersCard(
                        hasWallet: viewModel.hasWallet,
                        tradePair: viewModel.tradePair,
                        tradeSide: viewModel.tradeSide,
                        onCancelOrder: (item) {
                          TradeOrderCancelProcess.doCancelOrder(
                            context,
                            viewModel,
                            order: item,
                            onSuccessTransaction: (txId) {
                              tradeOrdersCubit.loadData(
                                walletId: viewModel.activeWalletId,
                                tradePairId: viewModel.tradePair.id,
                                tradeAddress: viewModel.tradeCoinInfo.address,
                                priceAddress: viewModel.priceCoinInfo.address,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
