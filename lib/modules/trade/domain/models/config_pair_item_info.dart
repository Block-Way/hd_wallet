part of trade_domain_module;

abstract class TradeConfigPairItemInfo
    implements Built<TradeConfigPairItemInfo, TradeConfigPairItemInfoBuilder> {
// Constructors
  factory TradeConfigPairItemInfo(
      [Function(TradeConfigPairItemInfoBuilder) b]) = _$TradeConfigPairItemInfo;
  TradeConfigPairItemInfo._();

  static Serializer<TradeConfigPairItemInfo> get serializer =>
      _$tradeConfigPairItemInfoSerializer;

// Fields
  String get chain;

  String get symbol;
}
