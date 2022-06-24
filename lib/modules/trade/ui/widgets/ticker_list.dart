part of trade_ui_module;

class TickerList extends StatelessWidget {
  const TickerList({
    required this.tradePair,
    required this.tradeSide,
    Key? key,
    this.limit = 5,
    this.onPressed,
    this.colReverse = false,
    this.rowReverse = false,
    this.showBackground = false,
    this.backgroundIsDark = false,
    this.backgroundOnPrice = false,
  }) : super(key: key);

  final TradePair tradePair;
  final TradeSide tradeSide;
  final int limit;
  final bool colReverse;
  final bool rowReverse;
  final bool showBackground;
  final bool backgroundIsDark;
  final bool backgroundOnPrice;
  final Function(String)? onPressed;

  @override
  Widget build(BuildContext context) {
    final currentData =
        context.select<TradeTickersCubit, MapEntry<double, List<TradeTicker>>>(
      (cubit) => cubit.byTradePair(
        tradePair.id,
        tradeSide.index,
      ),
    );

    final data = currentData.value;
    final maxAmount = currentData.key;

    return ListView.builder(
      shrinkWrap: true,
      reverse: rowReverse,
      physics: NeverScrollableScrollPhysics(),
      itemCount: limit,
      itemBuilder: (context, index) {
        final item = index < data.length
            ? data[index]
            : TradeTicker.fromPlaceholder(
                tradeSideId: tradeSide.index,
                tradePairId: tradePair.id,
              );
        return TickerItem(
          item.price,
          item.displayAmount,
          isBuy: item.isBuy,
          reverse: colReverse,
          showBackground: showBackground,
          backgroundIsDark: backgroundIsDark,
          backgroundOnPrice: backgroundOnPrice,
          scale: maxAmount > 0 ? item.amount / maxAmount : 0,
          onPressed: onPressed,
        );
      },
    );
  }
}
