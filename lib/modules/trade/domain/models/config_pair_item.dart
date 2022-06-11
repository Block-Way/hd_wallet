part of trade_domain_module;

abstract class TradeConfigPairItem
    implements Built<TradeConfigPairItem, TradeConfigPairItemBuilder> {
// Constructors
  factory TradeConfigPairItem([Function(TradeConfigPairItemBuilder) b]) =
      _$TradeConfigPairItem;
  TradeConfigPairItem._();

  static Serializer<TradeConfigPairItem> get serializer =>
      _$tradeConfigPairItemSerializer;

// Fields
  String get id;

  String get name;

  String get speed;

  @BuiltValueField(wireName: 'deep_span')
  BuiltList<String> get spans;

  //@nullable
  String? get status;

  @BuiltValueField(wireName: 'buy')
  TradeConfigPairItemInfo get price;

  @BuiltValueField(wireName: 'sell')
  TradeConfigPairItemInfo get trade;
}
