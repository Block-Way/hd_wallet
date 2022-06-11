part of trade_domain_module;

enum TradePairStatus {
  /// 0-未开始  NOT_ONLINE
  opening,

  /// 1-正常 ONLINE
  online,

  /// 2-关闭中 ABOUT_CLOSE
  closing,

  /// 3-已关闭 CLOSE
  close,
}

abstract class TradePair implements Built<TradePair, TradePairBuilder> {
// Constructors
  factory TradePair([Function(TradePairBuilder) b]) = _$TradePair;
  TradePair._();

  factory TradePair.fromConfig({
    required String priceChain,
    required String priceSymbol,
    required String tradeChain,
    required String tradeSymbol,
    required String speed,
    required List<String> spans,
    required String pairId,
    required String pairName,
    required String marketId,
    required String apiStatus,
  }) {
    final names = pairName.split('/');
    return TradePair(
      (b) => b
        ..id = pairId
        ..name = pairName
        ..speed = speed
        ..spans = ListBuilder(spans)
        ..marketId = marketId
        ..apiStatus = apiStatus
        ..tradeName = names.first
        ..tradeChain = tradeChain
        ..tradeSymbol = tradeSymbol
        ..priceName = names.last
        ..priceChain = priceChain
        ..priceSymbol = priceSymbol,
    );
  }

  static Serializer<TradePair> get serializer => _$tradePairSerializer;

  static TradePairStatus mapTradePairStatus(
    String apiStatus,
  ) {
    switch (apiStatus) {
      case 'NOT_ONLINE':
        return TradePairStatus.opening;
      case 'ONLINE':
        return TradePairStatus.online;
      case 'ABOUT_CLOSE':
        return TradePairStatus.closing;
      case 'CLOSE':
        return TradePairStatus.close;
      default:
        return TradePairStatus.online;
    }
  }

  String toMqttTopic() {
    return id.split('/').reversed.join('/');
  }

// Fields
  String get id;
  String get name;
  String get speed;

  @BuiltValueField(wireName: 'deep_span')
  BuiltList<String> get spans;

  @BuiltValueField(wireName: 'status')
  String get apiStatus;

  String get marketId;

  /// Coin
  String get tradeName;
  String get tradeChain;
  String get tradeSymbol;

  /// Price
  String get priceName;
  String get priceChain;
  String get priceSymbol;

  TradePairStatus get status => mapTradePairStatus(apiStatus);

  bool get isFast => speed == 'high';

  bool get isSlow => speed == 'slow';

  bool get isClosing => status == TradePairStatus.closing;

  bool get isOpening => status == TradePairStatus.opening;

  String sideSymbol(TradeSide side) =>
      side == TradeSide.buy ? priceSymbol : tradeSymbol;

  String sideChain(TradeSide side) =>
      side == TradeSide.buy ? priceChain : tradeChain;

  String buySideSymbol(TradeSide side) =>
      side == TradeSide.sell ? priceSymbol : tradeSymbol;

  String buySideChain(TradeSide side) =>
      side == TradeSide.sell ? priceChain : tradeChain;

  /// If true, this chain need to Approve transactions
  bool isChainNeedApprove(TradeSide side) =>
      ['ETH', 'TRX'].contains(sideChain(side));

  String get statusTransKey {
    switch (status) {
      case TradePairStatus.opening:
        return 'trade:trade_pair_status_not_online';
      case TradePairStatus.closing:
        return 'trade:trade_pair_status_closing';
      default:
        return '-';
    }
  }
}
