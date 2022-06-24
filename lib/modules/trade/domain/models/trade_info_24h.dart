part of trade_domain_module;

abstract class TradeInfo24h
    implements Built<TradeInfo24h, TradeInfo24hBuilder> {
  // Constructors

  factory TradeInfo24h([Function(TradeInfo24hBuilder) b]) = _$TradeInfo24h;
  TradeInfo24h._();

  // Serializers
  static TradeInfo24h? fromJson(Map<String, dynamic> json) {
    return deserialize<TradeInfo24h>(json);
  }

  static Serializer<TradeInfo24h> get serializer => _$tradeInfo24hSerializer;

  //@nullable
  String? get high;

  //@nullable
  String? get low;

  //@nullable
  String? get vol;

  String get displayHigh => (high?.isEmpty ?? true) ? '-' : high!;

  String get displayLow => (low?.isEmpty ?? true) ? '-' : low!;

  String get displayVol => (vol?.isEmpty ?? true)
      ? '-'
      : StringUtils.displaySize(NumberUtil.getDouble(vol), 0);
}
