part of asset_domain_module;

@HiveType(typeId: kHiveTypePrices)
class Prices extends HiveObject {
  Prices() {
    coinPrices = {};
    fiatPrices = {};
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
    coinUpdatedAt = DateTime.now();
    fiatUpdatedAt = DateTime.now();
  }

  /// USD price of a coin
  /// Example: BTC => 10000.00
  @HiveField(0)
  Map<String, double> coinPrices;

  /// Exchange rate between USD and other fiat currencies
  /// Example: USDCNY => 7.00
  @HiveField(1)
  Map<String, double> fiatPrices;

  @HiveField(2)
  DateTime createdAt;
  @HiveField(3)
  DateTime updatedAt;
  @HiveField(4)
  DateTime coinUpdatedAt;
  @HiveField(5)
  DateTime fiatUpdatedAt;
}
