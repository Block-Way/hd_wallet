part of swap_domain_module;

abstract class SwapState implements Built<SwapState, SwapStateBuilder> {
// Constructors

  factory SwapState() {
    return _$SwapState._(
      swaps: BuiltList<Swap>(),
      configState: ConfigState.loading.index,
    );
  }
  SwapState._();

  static Serializer<SwapState> get serializer => _$swapStateSerializer;

// Fields

  @nullable
  SwapConfig get config;

  @nullable
  int get configState;

  @nullable
  BuiltList<Swap> get swaps;

  SwapConfigCoin getCoinSwapConfig({
    @required String chain,
    @required String symbol,
  }) {
    if (config.tradePairs != null && config.tradePairs.isNotEmpty) {
      for (final pair in config.tradePairs) {
        for (final coin in pair) {
          if (coin.chain == chain && coin.symbol == symbol) {
            return coin;
          }
        }
      }
    }
    return null;
  }
}
