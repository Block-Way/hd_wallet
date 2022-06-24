part of trade_domain_module;

abstract class TradeConfigCoin
    implements Built<TradeConfigCoin, TradeConfigCoinBuilder> {
// Constructors
  factory TradeConfigCoin([Function(TradeConfigCoinBuilder) b]) =
      _$TradeConfigCoin;
  TradeConfigCoin._();

  static Serializer<TradeConfigCoin> get serializer =>
      _$tradeConfigCoinSerializer;

// Fields
  @BuiltValueField(wireName: 'chain')
  String get chain;

  @BuiltValueField(wireName: 'currency')
  String get symbol;

  //@nullable
  @BuiltValueField(wireName: 'deal_address')
  String? get dealAddress;

  //@nullable
  @BuiltValueField(wireName: 'match_address')
  String? get matchAddress;

  @BuiltValueField(wireName: 'default_fee')
  int get matchFee;

  @BuiltValueField(wireName: 'deal_precision')
  int get dealPrecision;

  @BuiltValueField(wireName: 'min_fee')
  double get networkFee;

  @BuiltValueField(wireName: 'min_height')
  int get minBlockHeight;

  @BuiltValueField(wireName: 'max_height')
  int get maxBlockHeight;

  @BuiltValueField(wireName: 'min_amount')
  double get minAmount;

  @BuiltValueField(wireName: 'max_amount')
  double get maxAmount;

  double get inputNetworkFee =>
      chain == 'ETH' || chain == 'TRX' ? 0 : networkFee;
}
