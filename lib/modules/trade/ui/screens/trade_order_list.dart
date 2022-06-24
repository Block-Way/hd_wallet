part of trade_ui_module;

class _GetOrderListParams {
  _GetOrderListParams({
    this.tradePair,
    this.tradeSide = 'all',
    this.selectedTab = TradeOrderApiStatus.pending,
    this.status = TradeOrderApiStatus.history,
  });
  final TradePair? tradePair;
  final String tradeSide;
  final String status;
  final String selectedTab;

  @override
  String toString() {
    return '''GetOrderListParams(tradePair: $tradePair, tradeSide:$tradeSide, status: $status, selectedTab: $selectedTab)''';
  }
}

class TradeOrderListPage extends HookWidget {
  static const routeName = '/trade/order/list';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      MultiBlocProvider(
        providers: [
          BlocProvider<TradeOrdersHistoryCubit>(
            create: (context) => TradeOrdersHistoryCubit(),
          ),
          BlocProvider<TradeOrdersDealFailCubit>(
            create: (context) => TradeOrdersDealFailCubit(),
          ),
          BlocProvider<TradeOrdersPendingCubit>(
            create: (context) => TradeOrdersPendingCubit(),
          ),
        ],
        child: TradeOrderListPage(),
      ),
    );
  }

  Future<int> loadData(
    TradeHomeVM viewModel,
    TradeOrdersCubit cubit, {
    CSListViewParams<_GetOrderListParams>? params,
    bool onlyCache = false,
  }) async {
    return 0;
  }

  void reloadData(
    BuildContext context,
    TradeHomeVM viewModel,
    BehaviorSubject<CSListViewParams<_GetOrderListParams>> request,
  ) {}

  void updateOrderAmount(
    BuildContext context,
    TradeHomeVM viewModel,
    TradeOrder order,
    ValueNotifier<Map<String, double>> orderAmounts,
  ) {}

  @override
  Widget build(BuildContext context) {
    final selectedTabId = useState(TradeOrderApiStatus.pending);
    // filter
    final filterTradePair = useState<TradePair?>(null);
    final filterTradeSide = useState<String>('all');
    final filterStatus = useState<String>(TradeOrderApiStatus.history);
    final orderAmounts = useState<Map<String, double>>({});

    final selectedCubit = useState<TradeOrdersCubit>(
      BlocProvider.of<TradeOrdersPendingCubit>(context),
    );
    final request =
        useBehaviorStreamController<CSListViewParams<_GetOrderListParams>>();

    void doFilterRefreshData(
      TradePair tradePair,
      String tradeSide,
      String status,
    ) {
      request.add(
        CSListViewParams.withParams(_GetOrderListParams(
          tradePair: tradePair,
          tradeSide: tradeSide,
          status: status,
          selectedTab: selectedTabId.value,
        )),
      );
    }

    void doCancelOrder(TradeHomeVM viewModel, TradeOrder item) {
      TradeOrderCancelProcess.doCancelOrder(
        context,
        viewModel,
        order: item,
        onSuccessTransaction: (txId) {
          reloadData(
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
        textStyle: context.textTitle(
          bold: true,
          fontWeight: FontWeight.normal,
        ),
        onPressed: () {
          showOrderListMenuDialog(context, selectedTabId.value, (selectedId) {
            if (selectedId != selectedTabId.value) {
              filterTradePair.value = null;
              filterTradeSide.value = 'all';
              filterStatus.value = TradeOrderApiStatus.history;
              selectedTabId.value = selectedId;
              switch (selectedId) {
                case TradeOrderApiStatus.pending:
                  selectedCubit.value = context.read<TradeOrdersPendingCubit>();
                  break;
                case TradeOrderApiStatus.history:
                  selectedCubit.value = context.read<TradeOrdersHistoryCubit>();
                  break;
                case TradeOrderApiStatus.cancelled:
                  selectedCubit.value =
                      context.read<TradeOrdersDealFailCubit>();
                  break;
                default:
              }
              request.add(CSListViewParams.withParams(
                _GetOrderListParams(selectedTab: selectedId),
              ));
            }
          });
        },
        cmpRight: Padding(
          padding: context.edgeLeft8.copyWith(top: 3),
          child: Icon(
            CSIcons.ArrowDownBold,
            size: 5,
            color: context.bodyColor,
          ),
        ),
        flat: true,
        mainAxisSize: MainAxisSize.min,
      ),
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
            showSelectAll: true,
            selected: filterTradePair.value!,
            onSelected: (tradePair) {
              if (tradePair != filterTradePair.value) {
                filterTradePair.value = tradePair;
                doFilterRefreshData(
                  tradePair,
                  filterTradeSide.value,
                  filterStatus.value,
                );
              }
            },
          ),
        ),
      ),
      child: StoreConnector<AppState, TradeHomeVM>(
        distinct: true,
        converter: TradeHomeVM.fromStore,
        onInitialBuild: (_, __, viewModel) {
          request.add(CSListViewParams.withParams(_GetOrderListParams()));
        },
        builder: (context, viewModel) => Column(
          children: [
            if (selectedTabId.value != TradeOrderApiStatus.cancelled)
              TradeOrderFilterBar(
                key: Key(selectedTabId.value),
                isHistory: selectedTabId.value == TradeOrderApiStatus.history,
                filterTradePair: filterTradePair.value!,
                onChange: (tradeSide, status) {
                  filterTradeSide.value = tradeSide;
                  filterStatus.value = status;
                  doFilterRefreshData(
                      filterTradePair.value!, tradeSide, status);
                },
              ),
            Expanded(
              child: BlocBuilder<TradeOrdersCubit, List<TradeOrder>>(
                bloc: selectedCubit.value,
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
                  margin: context.edgeTop5,
                  emptyLabel: tr('trade:order_list_empty_msg'),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final order = data[index];

                    return selectedTabId.value == TradeOrderApiStatus.cancelled
                        ? TradeOrderCancelItem(
                            key: Key(order.txId),
                            order: order,
                            orderAmount:
                                orderAmounts.value[order.templateId].toString(),
                            isHistory: selectedTabId.value ==
                                TradeOrderApiStatus.history,
                            onCancelOrder: (item) {
                              doCancelOrder(viewModel, item);
                            },
                            onGetOrderAmount: () {
                              updateOrderAmount(
                                context,
                                viewModel,
                                order,
                                orderAmounts,
                              );
                            },
                            onPress: () {
                              TradeOrderDetailPage.open(order)?.then((value) {
                                if (value == true) {
                                  reloadData(
                                    context,
                                    viewModel,
                                    request,
                                  );
                                }
                              });
                            },
                          )
                        : TradeOrderItem(
                            key: Key(order.txId),
                            order: order,
                            isHistory: selectedTabId.value ==
                                TradeOrderApiStatus.history,
                            onCancelOrder: (item) {
                              doCancelOrder(viewModel, item);
                            },
                            onPress: () {
                              TradeOrderDetailPage.open(order)?.then(
                                (value) {
                                  if (value == true) {
                                    reloadData(
                                      context,
                                      viewModel,
                                      request,
                                    );
                                  }
                                },
                              );
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
