part of trade_ui_module;

class TradeOrderClosingPage extends HookWidget {
  const TradeOrderClosingPage(this.tradePair);
  final TradePair tradePair;

  static const routeName = '/trade/closing';

  static void open(TradePair tradePair) {
    AppNavigator.push(routeName, params: tradePair);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      MultiBlocProvider(
        providers: [
          BlocProvider<TradeOrdersPendingCubit>(
            create: (context) => TradeOrdersPendingCubit(),
          ),
          BlocProvider<TradeOrdersDealFailCubit>(
            create: (context) => TradeOrdersDealFailCubit(),
          ),
        ],
        child: TradeOrderClosingPage(settings.arguments as TradePair),
      ),
    );
  }

  Future<int> loadData(
    TradeHomeVM viewModel,
    TradeOrdersCubit cubit, {
    CSListViewParams<_GetOrderListParams> params,
    bool onlyCache = false,
  }) async {
    final tradePair = params.params.tradePair;
    String tradeAddress;
    String priceAddress;
    if (tradePair != null) {
      tradeAddress = viewModel
          .getCoinInfo(
            chain: tradePair?.tradeChain,
            symbol: tradePair?.tradeSymbol,
          )
          ?.address;
      priceAddress = viewModel
          .getCoinInfo(
            chain: tradePair?.priceChain,
            symbol: tradePair?.priceSymbol,
          )
          ?.address;
    }
    return cubit
        .loadAll(
      tradePairId: tradePair.id,
      tradeAddress: tradeAddress,
      priceAddress: priceAddress,
      walletId: viewModel.activeWalletId,
      skip: params.skip,
      take: params.take,
      tradeSide: params.params.tradeSide,
      status: params.params.status,
      onlyCache: onlyCache,
    )
        .catchError((error) {
      Toast.showError(error);
      throw error;
    });
  }

  void reloadList(
    BuildContext context,
    TradeHomeVM viewModel,
    BehaviorSubject<CSListViewParams<_GetOrderListParams>> request,
  ) {
    request.add(request.value.copyWith(isRefresh: true));
  }

  void updateOrderAmount(
    BuildContext context,
    TradeHomeVM viewModel,
    TradeOrder order,
    ValueNotifier<Map<String, double>> orderAmounts,
  ) {
    LoadingDialog.show(context);
    viewModel.getOrderBalance(order).then((value) {
      LoadingDialog.dismiss(context);
      final map = orderAmounts.value;
      map[order.templateId] = value;
      orderAmounts.value = {...map};
    }).catchError((error) {
      LoadingDialog.dismiss(context);
      Toast.showError(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCubit = useState<TradeOrdersCubit>(
      BlocProvider.of<TradeOrdersPendingCubit>(context),
    );
    final selectedTabId = useState(TradeOrderApiStatus.pending);
    final request =
        useBehaviorStreamController<CSListViewParams<_GetOrderListParams>>();
    final orderAmounts = useState<Map<String, double>>({});

    void doCancelOrder(TradeHomeVM viewModel, TradeOrder item) {
      TradeOrderCancelProcess.doCancelOrder(
        context,
        viewModel,
        order: item,
        onSuccessTransaction: (txId) {
          reloadList(
            context,
            viewModel,
            request,
          );
        },
      );
    }

    return CSScaffold(
      titleWidget: CSButton(
        padding: context.edgeAll,
        label: getOrderListTitle(selectedTabId.value),
        autoWidth: true,
        textStyle: context.textTitle(bold: true),
        onPressed: () {
          showOrderCloseMenuDialog(context, selectedTabId.value, (selectedId) {
            if (selectedId != selectedTabId.value) {
              selectedTabId.value = selectedId;
              switch (selectedId) {
                case TradeOrderApiStatus.pending:
                  selectedCubit.value = context.read<TradeOrdersPendingCubit>();
                  break;
                case TradeOrderApiStatus.cancelled:
                  selectedCubit.value =
                      context.read<TradeOrdersDealFailCubit>();
                  break;
                default:
              }
              request.add(CSListViewParams.withParams(
                _GetOrderListParams(
                  selectedTab: selectedId,
                  tradePair: tradePair,
                ),
              ));
            }
          });
        },
        cmpRight: Padding(
          padding: context.edgeLeft8.copyWith(top: 3),
          child: Icon(
            CSIcons.ArrowDownBold,
            size: 8,
            color: context.bodyColor,
          ),
        ),
        flat: true,
        mainAxisSize: MainAxisSize.min,
      ),
      child: StoreConnector<AppState, TradeHomeVM>(
        distinct: true,
        onInitialBuild: (viewModel) {
          if (viewModel.hasWallet) {
            request.add(CSListViewParams.withParams(
              _GetOrderListParams(tradePair: tradePair),
            ));
          } else {
            AppNavigator.gotoTabBar();
            AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
          }
        },
        converter: TradeHomeVM.fromStore,
        builder: (context, viewModel) => Column(
          children: [
            Expanded(
              child: BlocBuilder<TradeOrdersCubit, List<TradeOrder>>(
                cubit: selectedCubit.value,
                builder: (context, data) =>
                    CSListViewStream<_GetOrderListParams>(
                  requestStream: request,
                  onLoadCachedData: (params) {
                    return loadData(
                      viewModel,
                      selectedCubit.value,
                      params: params,
                      onlyCache: true,
                    );
                  },
                  onLoadData: (params) {
                    return loadData(
                      viewModel,
                      selectedCubit.value,
                      params: params,
                    );
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return selectedTabId.value == TradeOrderApiStatus.cancelled
                        ? TradeOrderCancelItem(
                            orderAmount: orderAmounts
                                .value[data[index].templateId]
                                ?.toString(),
                            key: Key(data[index].txId),
                            order: data[index],
                            onCancelOrder: (item) {
                              doCancelOrder(viewModel, item);
                            },
                            onGetOrderAmount: () {
                              updateOrderAmount(
                                context,
                                viewModel,
                                data[index],
                                orderAmounts,
                              );
                            })
                        : TradeOrderItem(
                            key: Key(data[index].txId),
                            order: data[index],
                            onCancelOrder: (item) {
                              doCancelOrder(viewModel, item);
                            },
                          );
                  },
                  emptyLabel: tr('trade:order_list_empty_msg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
