part of trade_ui_module;

class TradeOrderCancelItem extends StatelessWidget {
  const TradeOrderCancelItem({
    @required this.order,
    @required this.onCancelOrder,
    @required this.onGetOrderAmount,
    Key key,
    this.isHistory = false,
    this.orderAmount,
    this.onPress,
  }) : super(key: key);

  final TradeOrder order;
  final bool isHistory;
  final String orderAmount;
  final void Function(TradeOrder) onCancelOrder;
  final void Function() onGetOrderAmount;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    final amount = orderAmount ??
        NumberUtil.truncateDecimal<String>(order.withdrawAmount, 8) ??
        '0';
    final List<Map<String, String>> infoList = [
      {
        'label': tr(
          'trade:order_list_lbl_amount',
          namedArgs: {'symbol': order.symbol},
        ),
        'value': amount,
        'showGetAmount': (orderAmount == null).toString(),
      },
      {
        'label': order.isChainUseApiRawTx
            ? tr('trade:order_lbl_template_key')
            : tr('trade:order_lbl_match_address'),
        'value': StringUtils.strCut(
          order.templateId ?? '',
          startKeep: 6,
          endKeep: 6,
        ),
      },
    ];

    return CSContainer(
      margin: context.edgeAll.copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextTradePair(
                order.tradeSymbol,
                order.priceSymbol,
                TextSize.secondary,
                sameStyle: true,
                direction: true,
                isBuy: order.tradeSide == TradeSide.buy,
              ),
              Spacer(),
              Text(
                tr('trade:order_list_lbl_trade_failed'),
                style: context.textSmall(bold: true),
              )
            ],
          ),
          SizedBox(height: context.edgeSize),
          Wrap(
            spacing: context.edgeSize,
            runSpacing: 20,
            children: infoList.map<Widget>(
              (item) {
                final itemWidth =
                    (context.mediaWidth - context.edgeSize * 5) / 2;
                return SizedBox(
                  width: itemWidth.toInt().toDouble(),
                  height: 45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['label'].toString(),
                        style: context.textTiny(),
                      ),
                      SizedBox(height: 10),
                      if (item['showGetAmount'] == 'true')
                        CSButton(
                          label: tr('trade:order_btn_show_amount'),
                          flat: true,
                          onPressed: onGetOrderAmount,
                          alignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          textStyle: context
                              .textSecondary(color: context.bodyColor)
                              .copyWith(decoration: TextDecoration.underline),
                        )
                      else
                        Text(
                          item['value'].toString(),
                          style: context.textSecondary(
                            bold: item['bold'] != 'false',
                            color: context.bodyColor,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
          Container(
            height: 0.5,
            margin: context.edgeVertical,
            color: context.greyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CSButton(
                label: tr(order.isChainUseApiRawTx == true
                    ? 'trade:order_btn_copy_template_key'
                    : 'global:btn_copy_address'),
                bordered: true,
                mainAxisSize: MainAxisSize.min,
                borderRadius: 6,
                height: 28,
                borderWidth: 0.5,
                borderColor: context.bodyColor,
                backgroundColor: Colors.transparent,
                textStyle: context.textSmall(
                  bold: true,
                  color: context.bodyColor,
                ),
                autoWidth: true,
                onPressed: () {
                  copyTextToClipboard(order.templateId ?? '');
                  Toast.show(tr('global:msg_copy_success'));
                },
              ),
              SizedBox(width: 10),
              CSButton(
                mainAxisSize: MainAxisSize.min,
                borderRadius: 6,
                height: 28,
                textStyle: context.textSmall(
                  bold: true,
                  color: context.bodyColor,
                ),
                autoWidth: true,
                label: tr('trade:order_btn_retract'),
                onPressed: () {
                  if (onCancelOrder != null) {
                    onCancelOrder(order);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
