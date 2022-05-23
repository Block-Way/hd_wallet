part of trade_ui_module;

class ChartOrderDeals extends StatelessWidget {
  const ChartOrderDeals({
    @required this.tradePair,
    Key key,
  }) : super(key: key);

  final TradePair tradePair;

  Widget renderItem(BuildContext context, int index, TradeDeal item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: context.edgeLeft8,
            child: Text(
              item.displayCreatedAt,
              style: context.textSmallPrice(color: context.whiteLightColor),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: TickerItem(
            item.price,
            item.amount,
            isBuy: item.isBuy,
            backgroundIsDark: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF676f83);

    final data = context.select<TradeDealsCubit, List<TradeDeal>>(
      (cubit) => cubit.byTradePair(
        data: cubit.state.data,
        tradePairId: tradePair.id,
      ),
    );

    return Column(
      children: [
        Padding(
          padding: context.edgeVertical8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: context.edgeLeft8,
                  child: Text(
                    tr('trade:chart_lbl_time'),
                    style: context.textTiny(color: textColor),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  padding: context.edgeHorizontal8,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr(
                              'trade:chart_lbl_price',
                              namedArgs: {'symbol': tradePair.priceSymbol},
                            ),
                            style: context.textTiny(color: textColor),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          tr(
                            'trade:chart_lbl_amount',
                            namedArgs: {'symbol': tradePair.tradeSymbol},
                          ),
                          style: context.textTiny(color: textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            final item = index < data.length
                ? data[index]
                : TradeDeal.fromPlaceholder(tradePairId: tradePair.id);
            return renderItem(context, index, item);
          },
        ),
      ],
    );
  }
}
