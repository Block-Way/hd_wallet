part of trade_domain_module;

abstract class TradePairVM implements Built<TradePairVM, TradePairVMBuilder> {
  factory TradePairVM([void Function(TradePairVMBuilder) b]) = _$TradePairVM;
  TradePairVM._();

  // Fields
  BuiltList<TradePair> get allTradePairs;
  BuiltList<TradeMarket> get allTradeMarkets;

  String get fiatCurrency;

  TradePair get tradePair;

  // Methods
  @BuiltValueField(compare: false)
  void Function() get doLoadTradePair;

  static TradePairVM fromStore(Store<AppState> store) {
    final tradeState = store.state.tradeState;
    final fiatCurrency = store.state.commonState.fiatCurrency ?? '';

    final tradePair = tradeState.tradePair ?? tradeState.getDefaultTradePair();

    return TradePairVM((viewModel) => viewModel
      ..tradePair = tradePair.toBuilder()
      ..allTradePairs = ListBuilder(tradeState.config?.allTradePairs ?? [])
      ..allTradeMarkets = ListBuilder(tradeState.config?.allTradeMarkets ?? [])
      ..fiatCurrency = fiatCurrency
      ..doLoadTradePair = () {
        GetIt.I<CoinPriceCubit>().updateAll();
      });
  }
}
