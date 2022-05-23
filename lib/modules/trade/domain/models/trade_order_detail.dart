part of trade_domain_module;

abstract class TradeOrderDetail
    implements Built<TradeOrderDetail, TradeOrderDetailBuilder> {
// Constructors
  factory TradeOrderDetail([Function(TradeOrderDetailBuilder) b]) =
      _$TradeOrderDetail;
  TradeOrderDetail._();

  static Serializer<TradeOrderDetail> get serializer =>
      _$tradeOrderDetailSerializer;

  @nullable
  @BuiltValueField(wireName: 'min_amount')
  String get total;

  @nullable
  @BuiltValueField(wireName: 'match_list')
  BuiltList<TradeOrderDetailItem> get matchList;

  @nullable
  @BuiltValueField(wireName: 'exchange_list')
  BuiltList<TradeOrderDetailItem> get exchangeList;

  bool get hasMatchList => matchList != null && matchList.isNotEmpty;

  bool get hasExchangeList => exchangeList != null && exchangeList.isNotEmpty;
}

abstract class TradeOrderDetailItem
    implements Built<TradeOrderDetailItem, TradeOrderDetailItemBuilder> {
// Constructors
  factory TradeOrderDetailItem([Function(TradeOrderDetailItemBuilder) b]) =
      _$TradeOrderDetailItem;
  TradeOrderDetailItem._();

  static Serializer<TradeOrderDetailItem> get serializer =>
      _$tradeOrderDetailItemSerializer;

  @nullable
  @BuiltValueField(wireName: 'match_price')
  String get matchPrice;

  @nullable
  String get amount;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  int get createdAt;

  @nullable
  String get fee;

  @nullable
  @BuiltValueField(wireName: 'tx_id')
  String get txId;

  @nullable
  @BuiltValueField(wireName: 'template_match_address')
  String get matchId;
}
