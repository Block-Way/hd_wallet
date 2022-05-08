part of asset_domain_module;

class CoinPriceState {
  CoinPriceState(this.prices);

  factory CoinPriceState.fromState(CoinPriceState old) {
    return CoinPriceState({...old.prices});
  }

  /// Coin Prices
  final Map<String, AssetPrice> prices;

  AssetPrice getCoinPrice({
    @required String tradePairId,
  }) {
    return prices.containsKey(tradePairId)
        ? prices[tradePairId]
        : AssetPrice.fromPrice(
            tradePairId: tradePairId ?? '',
            precision: 8,
            price: 0,
            price24h: 0,
          );
  }

  void updateCoinPrice({
    @required String tradePairId,
    @required AssetPrice price,
  }) {
    prices[tradePairId] = price;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is CoinPriceState && mapEquals(o.prices, prices);
  }

  @override
  int get hashCode => prices.hashCode;
}

class CoinPriceCubit extends Cubit<CoinPriceState> {
  CoinPriceCubit([AssetRepository assetRepository])
      : super(CoinPriceState({})) {
    _assetRepository = assetRepository ?? AssetRepository();
  }

  AssetRepository _assetRepository;

  Future<void> updateSingle(String tradePairId) async {
    final coinConfigs = GetIt.I<CoinConfig>();
    final symbol = tradePairId.split('/').first;

    // Price from DEX
    final dexPriceJson = await _assetRepository.getCoinPrice(tradePairId);

    final price = AssetPrice.fromApi(
      tradePairId: tradePairId,
      json: dexPriceJson,
      precision: coinConfigs.getDisplayPrecision(symbol),
    );

    final newState = CoinPriceState.fromState(state);
    newState.updateCoinPrice(tradePairId: tradePairId, price: price);
    emit(newState);
  }

  Future<void> updateAll() async {
    final coinConfigs = GetIt.I<CoinConfig>();

    // Update from Market Prices
    final marketState = CoinPriceState.fromState(state);
    final coinPrices = await _assetRepository.getCoinPrices();
    coinPrices.forEach((symbol, value) {
      final tradePairId = '$symbol/USDT';
      final coinPrice = coinPrices[symbol] ?? 0;
      final price = AssetPrice.fromPrice(
        tradePairId: tradePairId,
        precision: coinConfigs.getDisplayPrecision(symbol),
        price: coinPrice,
        price24h: coinPrice,
      );
      marketState.updateCoinPrice(tradePairId: tradePairId, price: price);
    });
    emit(marketState);
    /*
    // Update from Dex Prices
    final dexState = CoinPriceState.fromState(marketState);
    final dexPrices = await _assetRepository.getDexPrices();
    dexPrices.forEach((tradePairId, value) {
      final symbol = tradePairId.split('/').first;
      final price = AssetPrice.fromApi(
        tradePairId: tradePairId,
        precision: coinConfigs.getDisplayPrecision(symbol),
        json: value as Map<String, dynamic>,
      );
      dexState.updateCoinPrice(tradePairId: tradePairId, price: price);
    });
    emit(dexState);
    */
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqtt({
    @required String tradePairId,
    @required Map<String, dynamic> json,
  }) async {
    final coinConfigs = GetIt.I<CoinConfig>();
    final symbol = tradePairId.split('/').first;

    final currentPrice = state.getCoinPrice(
      tradePairId: tradePairId,
    );

    final newState = CoinPriceState.fromState(state);
    final price = AssetPrice.fromPrice(
      tradePairId: tradePairId,
      precision: coinConfigs.getDisplayPrecision(symbol),
      price: NumberUtil.getIntAmountAsDouble(json['new'], 10),
      price24h: currentPrice.price, // TODO: should be 24h before price
    );
    newState.updateCoinPrice(tradePairId: tradePairId, price: price);

    emit(newState);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
