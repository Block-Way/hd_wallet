part of asset_ui_module;

class AssetPriceListener extends StatelessWidget {
  const AssetPriceListener({
    @required this.builder,
    Key key,
    this.amount = 1.0,
    this.symbol,
    this.tradePairId,
  }) : super(key: key);

  final double amount;
  final String symbol;
  final String tradePairId;

  final Widget Function(
    BuildContext context,
    String fiatPrice,
    String fiatCurrency,
    AssetPrice price,
  ) builder;

  @override
  Widget build(BuildContext context) {
    final _tradePairId = tradePairId ?? '$symbol/USDT';

    return BlocBuilder<CoinPriceCubit, CoinPriceState>(
        cubit: GetIt.I<CoinPriceCubit>(),
        buildWhen: (a, b) =>
            a.getCoinPrice(tradePairId: _tradePairId)?.price !=
            b.getCoinPrice(tradePairId: _tradePairId)?.price,
        builder: (context, coinPrices) {
          final coinPrice = coinPrices.getCoinPrice(tradePairId: _tradePairId);
          return BlocBuilder<FiatPriceCubit, FiatPriceState>(
            cubit: GetIt.I<FiatPriceCubit>(),
            builder: (context, fiatPrices) => builder(
              context,
              fiatPrices.getFiatPrice(
                coinPrice: coinPrice,
                amount: amount,
              ),
              fiatPrices.fiatCurrency,
              coinPrice,
            ),
          );
        });
  }
}
