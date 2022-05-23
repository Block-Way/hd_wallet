part of trade_domain_module;

abstract class TradeConfigPair
    implements Built<TradeConfigPair, TradeConfigPairBuilder> {
// Constructors
  factory TradeConfigPair([Function(TradeConfigPairBuilder) b]) =
      _$TradeConfigPair;
  TradeConfigPair._();

  static Serializer<TradeConfigPair> get serializer =>
      _$tradeConfigPairSerializer;

// Fields
  @BuiltValueField(wireName: 'name')
  BuiltMap<String, String> get localizedName;

  @BuiltValueField(wireName: 'list')
  BuiltList<TradeConfigPairItem> get pairs;
}
