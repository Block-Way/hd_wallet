part of trade_domain_module;

abstract class TradeTicker implements Built<TradeTicker, TradeTickerBuilder> {
// Constructors
  factory TradeTicker([Function(TradeTickerBuilder) b]) = _$TradeTicker;
  TradeTicker._();

  factory TradeTicker.fromPlaceholder({
    @required int tradeSideId,
    @required String tradePairId,
  }) =>
      TradeTicker(
        (b) => b
          ..tradePairId = tradePairId
          ..tradeSideId = tradeSideId
          ..price = '-'
          ..amount = -1,
      );

  factory TradeTicker.fromApi({
    @required int tradeSideId,
    @required String tradePairId,
    @required String price,
    @required String amount,
  }) =>
      TradeTicker(
        (b) => b
          ..tradePairId = tradePairId
          ..tradeSideId = tradeSideId
          ..price = price
          ..amount = NumberUtil.getDouble(amount),
      );

  factory TradeTicker.fromMqtt({
    @required Map<String, dynamic> json,
    @required String span,
  }) =>
      TradeTicker(
        (b) => b
          ..tradePairId = json['coin_pair'].toString()
          ..tradeSideId =
              json['side'] == 'BUY' ? TradeSide.buy.index : TradeSide.sell.index
          ..price = NumberUtil.getIntAmountAsDouble(json['price'], 10)
              .toStringAsFixed(NumberUtil.getDecimalDigits(span))
          ..amount = NumberUtil.getDouble(json['amount']),
      );

  static Serializer<TradeTicker> get serializer => _$tradeTickerSerializer;

// Serializers
  static TradeTicker fromJson(Map<String, dynamic> json) {
    return deserialize<TradeTicker>(json);
  }

// Fields
  int get tradeSideId;

  String get tradePairId;

  String get price;

  double get amount;

  String get displayAmount =>
      amount <= 0 ? '-' : StringUtils.displaySize(amount, 3);

  /// Is Buy equal to Bid
  bool get isBuy => tradeSideId == TradeSide.buy.index;

  /// Is Sell equal to Ask
  bool get isSell => tradeSideId == TradeSide.sell.index;
}
