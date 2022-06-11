part of trade_domain_module;

abstract class TradeDeal implements Built<TradeDeal, TradeDealBuilder> {
  // Constructors
  factory TradeDeal([Function(TradeDealBuilder) b]) = _$TradeDeal;
  TradeDeal._();

  factory TradeDeal.fromPlaceholder({
    required String tradePairId,
  }) =>
      TradeDeal(
        (b) => b
          ..tradePairId = tradePairId
          ..tradeSideId = TradeSide.buy.index
          ..price = '-'
          ..amount = '-'
          ..createdAt = -1,
      );

  factory TradeDeal.fromApi(
    String tradePairId, {
    required Map<String, dynamic> json,
  }) =>
      TradeDeal(
        (b) => b
          ..tradePairId = tradePairId
          ..tradeSideId =
              json['side'] == 'BUY' ? TradeSide.buy.index : TradeSide.sell.index
          ..price = json['match_price'] as String
          ..amount = json['amount'] as String
          ..createdAt = NumberUtil.getInt(json['created_at']),
      );

  static Serializer<TradeDeal> get serializer => _$tradeDealSerializer;

  // Serializers
  static TradeDeal? fromJson(Map<String, dynamic> json) {
    return deserialize<TradeDeal>(json);
  }

  // Fields
  int get tradeSideId;

  String get tradePairId;

  String get price;

  String get amount;

  int get createdAt;

  String get displayCreatedAt => createdAt <= 0
      ? '-'
      : formatDate(
          DateTime.fromMillisecondsSinceEpoch(createdAt * 1000), 'HH:mm:ss');

  bool get isBuy => tradeSideId == TradeSide.buy.index;
}
