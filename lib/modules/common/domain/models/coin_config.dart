part of common_domain_module;

class CoinConfig {
  Map<String, int> displayPrecisions = {};
  Map<String, int> dealPrecisions = {};
  Map<String, double> transferMinQuotas = {};
  List<String> symbols = [];
  Map<String, ConfigCoinFee> feeLevels = {};

  void updateFromConfig(Config config) {
    config.coins.forEach((symbol, value) {
      symbols.add(symbol);
      displayPrecisions[symbol] = value.displayPrecision;
      transferMinQuotas['${value.chain}_${value.symbol}'] =
          value.transferMinQuota;
      feeLevels['${value.chain}_${value.symbol}'] = value.hdWalletFeeLevel;
    });
  }

  void updateFromDex(Map<String, int> dealPrecisions) {
    if (dealPrecisions.isNotEmpty) {
      this.dealPrecisions = dealPrecisions;
    }
  }

  /// Getters

  int getDealPrecision(String symbol) {
    return dealPrecisions[symbol] ?? 6;
  }

  int getDisplayPrecision(String symbol) {
    return displayPrecisions[symbol] ?? 8;
  }

  double getTransferMinQuota({String chain, String symbol}) {
    return transferMinQuotas['${chain}_$symbol'] ?? 0;
  }

  ConfigCoinFee getFeeLevel({String chain, String symbol}) {
    return feeLevels['${chain}_$symbol'];
  }
}
