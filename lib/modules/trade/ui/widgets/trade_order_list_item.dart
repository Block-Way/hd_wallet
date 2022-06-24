part of trade_ui_module;

class TradeOrderItem extends StatelessWidget {
  const TradeOrderItem({
    required this.order,
    required this.onCancelOrder,
    Key? key,
    this.isHistory = false,
    this.margin,
    this.onPress,
  }) : super(key: key);

  final TradeOrder order;
  final EdgeInsetsGeometry? margin;
  final bool isHistory;
  final Function(TradeOrder) onCancelOrder;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final statusColor = order.isConfirming || order.isCancelling
        ? context.secondaryColor
        : order.isPending
            ? context.greenColor
            : context.secondaryColor;

    final List<Map<String, String>> infoList = [
      {
        'label': tr(
          'trade:order_lbl_price',
          namedArgs: {'symbol': order.priceSymbol},
        ),
        'value': NumberUtil.truncateDecimal<String>(order.price, 8),
      },
      {
        'label': tr(
          'trade:order_lbl_amount',
          namedArgs: {'symbol': order.tradeSymbol},
        ),
        'value': NumberUtil.truncateDecimal<String>(order.amount, 8),
      },
      {
        'label': tr(
          'trade:order_lbl_entire_total',
          namedArgs: {'symbol': order.priceSymbol},
        ),
        'value': NumberUtil.truncateDecimal<String>(order.dealAmount, 8),
      },
      if (isHistory) // 均价
        {
          'label': tr(
            'trade:order_lbl_average_price',
            namedArgs: {'symbol': order.priceSymbol},
          ),
          'value': NumberUtil.truncateDecimal<String>(order.avgPrice, 8),
        },
      if (isHistory)
        {
          'label': tr(
            'trade:order_lbl_miner_fee_all',
            namedArgs: {'symbol': order.feeSymbol},
          ),
          'value': NumberUtil.truncateDecimal<String>(order.networkFee, 8),
        },
      {
        'label': tr('trade:order_lbl_trade_time'),
        'value': formatDate(
            DateTime.fromMillisecondsSinceEpoch(order.displayTime),
            'MM.dd HH:mm:ss'),
      },
    ];

    return CSContainer(
      onTap: onPress,
      margin: margin ?? context.edgeAll.copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextTradePair(
                order.tradeSymbol,
                order.priceSymbol,
                TextSize.secondary,
                sameStyle: true,
                direction: true,
                isBuy: order.tradeSide == TradeSide.buy,
              ),
              if (!isHistory && order.canCancel)
                CSButton(
                  mainAxisSize: MainAxisSize.min,
                  borderRadius: 6,
                  height: 30,
                  backgroundColor: Color(0xFFFFF9D7),
                  textStyle: context.textSmall(
                    bold: true,
                    color: context.bodyColor,
                    fontWeight: FontWeight.normal,
                  ),
                  autoWidth: true,
                  onPressed: () {
                    if (onCancelOrder != null) {
                      onCancelOrder(order);
                    }
                  },
                  label: tr(order.statusCancelKey),
                )
              else
                Text(
                  tr(order.statusTransKey),
                  style: context.textSmall(
                    bold: true,
                    color: statusColor,
                    fontWeight: FontWeight.normal,
                  ),
                )
            ],
          ),
          SizedBox(height: context.edgeSize),
          Wrap(
            spacing: context.edgeSize,
            runSpacing: 15,
            children: infoList.asMap().keys.map<Widget>(
              (index) {
                final itemWidth =
                    (context.mediaWidth - context.edgeSize * 5) / 2;
                return SizedBox(
                  width: itemWidth.toInt().toDouble(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        infoList[index]['label'].toString(),
                        style: context.textTiny(
                          bold: true,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        infoList[index]['value'].toString(),
                        style: context.textSecondary(
                          color: context.bodyColor,
                          bold: true,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
