part of trade_ui_module;

class ChartOrderTickers extends StatelessWidget {
  const ChartOrderTickers({
    @required this.tradePair,
    Key key,
  }) : super(key: key);

  final TradePair tradePair;

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF676f83);
    return Column(
      children: [
        Padding(
          padding: context.edgeAll8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(
                  'trade:chart_lbl_amount_buy',
                  namedArgs: {'symbol': tradePair.tradeSymbol},
                ),
                style: context.textTiny(color: textColor),
              ),
              Text(
                tr(
                  'trade:chart_lbl_price',
                  namedArgs: {'symbol': tradePair.priceSymbol},
                ),
                style: context.textTiny(color: textColor),
              ),
              Text(
                tr(
                  'trade:chart_lbl_amount_sell',
                  namedArgs: {'symbol': tradePair.tradeSymbol},
                ),
                style: context.textTiny(color: textColor),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Flexible(
              child: TickerList(
                limit: 10,
                tradeSide: TradeSide.buy,
                tradePair: tradePair,
                showBackground: true,
                backgroundIsDark: true,
                backgroundOnPrice: true,
                colReverse: true,
              ),
            ),
            Flexible(
              child: TickerList(
                limit: 10,
                tradeSide: TradeSide.sell,
                tradePair: tradePair,
                showBackground: true,
                backgroundIsDark: true,
                backgroundOnPrice: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
