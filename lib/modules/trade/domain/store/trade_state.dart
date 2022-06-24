part of trade_domain_module;

abstract class TradeState implements Built<TradeState, TradeStateBuilder> {
// Constructors

  factory TradeState() {
    return _$TradeState._(
      tradeSide: TradeSide.buy,
      hideSlowTradePairTip: BuiltList(),
      configState: ConfigState.loading.index,
      config: TradeConfig(),
      //tradePair: TradePair(),
      currentOrderDetail: TradeOrderDetail(),
    );
  }
  TradeState._();

  factory TradeState.fromCache(
    List<dynamic> data,
  ) {
    try {
      return _$TradeState._(
        config: deserialize<TradeConfig>(data[0])!,
        hideSlowTradePairTip:
            BuiltList.from(data.length > 1 ? data[1] as List : []),
        tradeSide: TradeSide.buy,
        configState: ConfigState.loading.index,
        //tradePair: TradePair(),
        currentOrderDetail: TradeOrderDetail(),
      );
    } catch (_) {
      return TradeState();
    }
  }
  static Serializer<TradeState> get serializer => _$tradeStateSerializer;

  List<dynamic> toCache() {
    try {
      return [
        serialize<TradeConfig>(config!),
        hideSlowTradePairTip.toList(),
      ];
    } catch (_) {
      return [null];
    }
  }

// Fields

  //@nullable
  TradeConfig? get config;

  //@nullable
  int? get configState;

  //@nullable
  //TradePair? get tradePair;

  TradeSide get tradeSide;

  BuiltList<String> get hideSlowTradePairTip;

  //@nullable
  TradeOrderDetail? get currentOrderDetail;

  //Methods
  /*
  TradePair getDefaultTradePair() => (config?.allTradePairs ?? []).firstWhere(
        (e) => e.id == AppConstants.defaultTradePair,
        orElse: () => TradePair.fromConfig(
          priceChain: '',
          priceSymbol: '',
          tradeChain: '',
          tradeSymbol: '',
          speed: 'high',
          spans: [],
          pairId: '',
          pairName: '',
          marketId: '',
          apiStatus: 'NOT_ONLINE',
        ),
      );
*/

  TradeConfigCoin getCoinConfig({
    required String symbol,
    required String chain,
  }) =>
      config!.coins.firstWhere(
        (e) => e.symbol == symbol && e.chain == chain,
      );
}
