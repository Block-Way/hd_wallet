part of trade_ui_module;

class TradeOrderDetailPage extends HookWidget {
  const TradeOrderDetailPage(
    this.paramsOrderInfo, {
    Key key,
  }) : super(key: key);
  final TradeOrder paramsOrderInfo;

  static const routeName = '/trade/order/detail';

  static Future<bool> open(
    TradeOrder paramsOrderInfo,
  ) {
    return AppNavigator.push<bool>(routeName, params: paramsOrderInfo);
  }

  static Route<bool> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      TradeOrderDetailPage(settings.arguments as TradeOrder),
    );
  }

  void copyToClipboard(String data) {
    copyTextToClipboard(data);
    Toast.show(tr('global:msg_copy_success'));
  }

  Widget buildTradeDetail(
    BuildContext context,
    TradeOrder detail,
    TradeOrderDetailVM viewModel, {
    double balance,
  }) {
    final precision = GetIt.I<CoinConfig>().getDealPrecision(detail.symbol);
    final infoList = [
      {
        'label': tr('trade:order_lbl_order_time'),
        'value': formatDate(
          DateTime.fromMillisecondsSinceEpoch(detail.displayTime),
          'MM.dd HH:mm:ss',
        ),
      },
      {
        'label': tr('trade:order_lbl_price', namedArgs: {
          'symbol': detail.priceSymbol,
        }),
        'value': NumberUtil.truncateDecimal<String>(detail.price, 8),
      },
      {
        'label': tr('trade:order_lbl_amount', namedArgs: {
          'symbol': detail.tradeSymbol,
        }),
        'value': NumberUtil.truncateDecimal<String>(detail.amount, 8),
      },
      {
        'label': tr('trade:order_lbl_average_price',
            namedArgs: {'symbol': detail.priceSymbol}),
        'value': NumberUtil.truncateDecimal<String>(detail.avgPrice, 8),
      },
      {
        'label': tr('trade:order_lbl_trade_total',
            namedArgs: {'symbol': detail.tradeSymbol}),
        'value': NumberUtil.truncateDecimal<String>(detail.filled, 8),
      },
      {
        'label': tr('trade:order_lbl_remaining',
            namedArgs: {'symbol': detail.symbol}),
        'value': balance >= 0
            ? NumberUtil.truncateDecimal<String>(balance, precision)
            : '-',
      },
      {
        'label': detail.isChainUseApiRawTx
            ? tr('trade:order_lbl_template_key')
            : tr('trade:order_lbl_template_address'),
        'value': detail.templateId ?? '',
        'showCopyBtn': true,
        'fullWidth': true,
      },
      {
        'label': tr('trade:order_lbl_txid'),
        'value': detail.txId ?? '-',
        'showCopyBtn': true,
        'fullWidth': true,
      },
    ];

    return SizedBox(
      width: context.mediaWidth,
      child: Wrap(
        runSpacing: 15,
        children: infoList.asMap().keys.map<Widget>(
          (index) {
            final item = infoList[index];
            final itemWidth = (context.mediaWidth - context.edgeSize * 5) / 2;

            return SizedBox(
              width: item['fullWidth'] == true
                  ? context.mediaWidth
                  : itemWidth.toInt().toDouble(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['label'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTiny(),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['showCopyBtn'] == true
                              ? StringUtils.strCut(
                                  item['value'].toString(),
                                  startKeep: 15,
                                  endKeep: 15,
                                )
                              : item['value'].toString(),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textSecondary(
                            color: context.bodyColor,
                          ),
                        ),
                      ),
                      if (item['showCopyBtn'] == true)
                        CSButtonIcon(
                          size: 18,
                          borderRadius: 4,
                          icon: CSIcons.Copy,
                          padding: EdgeInsets.zero,
                          containerSize: 20,
                          margin: context.edgeLeft20,
                          onPressed: () {
                            copyToClipboard(item['value'].toString());
                          },
                        ),
                    ],
                  )
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget renderDealItem(
    BuildContext context,
    TradeOrder detail,
    TradeOrderDetailVM viewModel, {
    TradeOrderDetailItem data,
    bool isLast,
    bool isExchange,
  }) {
    final infoList = [
      {
        'label': tr('trade:order_lbl_time'),
        'value': formatDate(
          DateTime.fromMillisecondsSinceEpoch(data.createdAt * 1000),
          'MM.dd HH:mm:ss',
        ),
      },
      {
        'label': tr(
          'trade:order_lbl_final_price',
          namedArgs: {'symbol': detail.priceSymbol},
        ),
        'value': data.matchPrice,
      },
      {
        'label': tr(
          'trade:order_lbl_quantity',
          namedArgs: {'symbol': detail.tradeSymbol},
        ),
        'value': data.amount,
      },
      if (isExchange != true)
        {
          'label': detail.isChainUseApiRawTx
              ? tr('trade:order_lbl_template_key')
              : tr('trade:order_lbl_template_address'),
          'value': data.matchId,
          'showCopyBtn': true,
        },
      if (isExchange == true)
        {
          'label': tr(
            'trade:order_lbl_handling_fee',
            namedArgs: {
              'symbol': detail.isBuy ? detail.tradeSymbol : detail.priceSymbol
            },
          ),
          'value': data.fee,
        },
      if (isExchange == true)
        {
          'label': tr('trade:order_lbl_txid'),
          'value': data.txId,
          'showCopyBtn': true,
        },
    ];
    return Container(
      width: context.mediaWidth,
      padding: context.edgeBottom16,
      decoration: !isLast
          ? context.boxCardBorder(
              borderColor: context.greyColor,
              borderWidth: 0.5,
              left: false,
              right: false,
              top: false,
            )
          : null,
      child: Column(
        children: [
          ...infoList.map(
            (item) => Padding(
              padding: context.edgeTop16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['label'].toString(),
                    style: context.textSecondary(),
                  ),
                  Row(
                    children: [
                      Text(
                        item['value'] == null || item['value'] == ''
                            ? '-'
                            : item['showCopyBtn'] == true
                                ? StringUtils.strCut(
                                    item['value'].toString(),
                                    startKeep: 6,
                                    endKeep: 6,
                                  )
                                : item['value'].toString(),
                        style: context.textSecondary(color: context.bodyColor),
                      ),
                      if (item['showCopyBtn'] == true &&
                          item['value'] != null &&
                          item['value'] != '')
                        CSButtonIcon(
                          size: 18,
                          borderRadius: 4,
                          icon: CSIcons.Copy,
                          padding: EdgeInsets.zero,
                          containerSize: 20,
                          margin: context.edgeLeft10,
                          onPressed: () {
                            copyToClipboard(item['value'].toString());
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balance = useState<double>(0.0);
    final orderInfo = useState(paramsOrderInfo);
    final orderDetailInfo = useState(TradeOrderDetail());
    final order = orderInfo.value;

    void getOrderDetail(TradeOrderDetailVM viewModel, TradeOrder order) {
      if (order.isConfirming == false && order.isFailed == false) {
        LoadingDialog.show(context);
        viewModel.getOrderDetail(order.txId).then((value) {
          LoadingDialog.dismiss(context);
          orderDetailInfo.value = value;
        }).catchError((error) {
          LoadingDialog.dismiss(context);
          Toast.showError(error);
        });
      }
    }

    return CSScaffold(
      title: tr('trade:order_detail_title'),
      child: StoreConnector<AppState, TradeOrderDetailVM>(
        distinct: true,
        converter: TradeOrderDetailVM.fromStore,
        onInitialBuild: (viewModel) {
          // Get balance
          viewModel
              .getOrderBalance(order)
              .then((value) => balance.value = value)
              .catchError((_) => balance.value = -1);
          // Get info
          if (order.needStatusCheck) {
            LoadingDialog.show(context);
            viewModel.doOrderCheckStatus(order).then((value) {
              LoadingDialog.dismiss(context);
              orderInfo.value = value ?? order;
              getOrderDetail(viewModel, orderInfo.value);
            }).catchError((error) {
              LoadingDialog.dismiss(context);
              Toast.showError(error);
            });
          } else {
            getOrderDetail(viewModel, orderInfo.value);
          }
        },
        builder: (context, viewModel) => Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CSContainer(
                    padding: context.edgeAll16.copyWith(left: 8, right: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextTradePair(
                              order.tradeSymbol,
                              order.priceSymbol,
                              TextSize.body,
                              direction: true,
                              isBuy: order.tradeSide == TradeSide.buy,
                              sameStyle: true,
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            Text(
                              tr(order.statusTransKey),
                              style: context.textSmall(),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        buildTradeDetail(
                          context,
                          order,
                          viewModel,
                          balance: balance.value,
                        ),
                      ],
                    ),
                  ),
                  if (orderDetailInfo.value?.hasMatchList == true)
                    CSContainer(
                      margin: context.edgeAll.copyWith(top: 0),
                      padding: context.edgeAll8.copyWith(
                        bottom: 0,
                        top: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('trade:order_detail_lbl_matching'),
                            style: context.textSecondary(
                              bold: true,
                              color: context.bodyColor,
                            ),
                          ),
                          ...orderDetailInfo.value.matchList
                              .asMap()
                              .entries
                              .map(
                                (entry) => renderDealItem(
                                  context,
                                  order,
                                  viewModel,
                                  data: entry.value,
                                  isLast: (entry.key + 1) ==
                                      orderDetailInfo.value.matchList.length,
                                  isExchange: false,
                                ),
                              ),
                        ],
                      ),
                    ),
                  if (orderDetailInfo.value?.hasExchangeList == true)
                    CSContainer(
                      margin: context.edgeAll.copyWith(
                        top: 0,
                      ),
                      padding: context.edgeAll8.copyWith(
                        bottom: 0,
                        top: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('trade:order_detail_lbl_transaction'),
                            style: context.textSecondary(
                              bold: true,
                              color: context.bodyColor,
                            ),
                          ),
                          ...orderDetailInfo.value.exchangeList
                              .asMap()
                              .entries
                              .map(
                                (entry) => renderDealItem(
                                  context,
                                  order,
                                  viewModel,
                                  data: entry.value,
                                  isLast: entry.key + 1 ==
                                      orderDetailInfo.value.exchangeList.length,
                                  isExchange: true,
                                ),
                              ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (order.canCancel && balance.value > 0)
              StoreConnector<AppState, TradeHomeVM>(
                distinct: true,
                converter: TradeHomeVM.fromStore,
                builder: (context, viewModel) => CSButton(
                  label: order.isHistory
                      ? tr('trade:order_btn_withdraw')
                      : tr('trade:order_btn_cancel'),
                  fullwidth: true,
                  borderRadius: 0,
                  onPressed: () {
                    TradeOrderCancelProcess.doCancelOrder(
                      context,
                      viewModel,
                      order: order,
                      onSuccessTransaction: (txId) {
                        AppNavigator.popWithResult(true);
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
