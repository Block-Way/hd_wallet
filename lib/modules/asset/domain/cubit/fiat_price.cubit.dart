part of asset_domain_module;

class FiatPriceState {
  FiatPriceState(
    this.prices,
    this.fiatCurrency,
  );

  factory FiatPriceState.fromState(FiatPriceState old) {
    return FiatPriceState({...old.prices}, old.fiatCurrency);
  }

  /// Fiat Prices
  final Map<String, double> prices;

  /// Selected Fiat currency
  final String fiatCurrency;

  // /// Get Coin Fiat Price
  String getFiatPrice({
    @required AssetPrice coinPrice,
    double amount = 1,
  }) {
    if (prices == null) {
      return '-';
    }
    final price = coinPrice.price;

    if (price <= 0) {
      return '-';
    }

    if (amount <= 0) {
      return '0.0';
    }

    final total = price * amount;
    final fiatKey = 'USD_$fiatCurrency';
    final fiatPrice = prices.containsKey(fiatKey) ? prices[fiatKey] : 0.0;

    return NumberUtil.truncateDecimal(
      total * fiatPrice,
      AppConstants.fiatPrecision,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is FiatPriceState &&
        o.prices == prices &&
        o.fiatCurrency == fiatCurrency;
  }

  @override
  int get hashCode => prices.hashCode ^ fiatCurrency.hashCode;
}

class FiatPriceCubit extends Cubit<FiatPriceState> {
  FiatPriceCubit([AssetRepository assetRepository])
      : super(
          FiatPriceState(null, AppConstants.defaultCurrency),
        ) {
    _assetRepository = assetRepository ?? AssetRepository();
  }
  AssetRepository _assetRepository;

  Future<void> updateAll() async {
    final prices = await _assetRepository.getFiatPrices();
    final newState = FiatPriceState.fromState(
      FiatPriceState(prices, state.fiatCurrency),
    );
    emit(newState);
  }

  Future<void> setFiatCurrency(String fiatCurrency) async {
    emit(FiatPriceState(state.prices, fiatCurrency));
  }
}
