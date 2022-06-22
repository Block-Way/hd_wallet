part of asset_domain_module;

abstract class AssetPrice implements Built<AssetPrice, AssetPriceBuilder> {
// Constructors
  factory AssetPrice([Function(AssetPriceBuilder) b]) = _$AssetPrice;
  AssetPrice._();

  factory AssetPrice.fromJson(Map<String, dynamic> json) {
    return deserialize<AssetPrice>(json)!;
  }

  factory AssetPrice.fromPrice({
    required String tradePairId,
    required int precision,
    required double price,
    required double price24h,
  }) =>
      AssetPrice(
        (b) => b
          ..tradePairId = tradePairId
          ..precision = precision
          ..price = price
          ..price24h = price24h,
      );

  factory AssetPrice.fromApi({
    required String tradePairId,
    required int precision,
    required Map<String, dynamic> json,
  }) =>
      AssetPrice(
        (b) => b
          ..tradePairId = tradePairId
          ..precision = precision
          ..price = NumberUtil.getDouble(json['price'])
          ..price24h = NumberUtil.getDouble(json['day_before_price']),
      );

  static Serializer<AssetPrice> get serializer => _$assetPriceSerializer;

// Fields
  String get tradePairId;

  int get precision;

  double get price;

  double get price24h;

// Getters

  String get tradeSymbol => tradePairId.split('/').first;

  String get priceSymbol => tradePairId.split('/').last;

  String get displayPrice => NumberUtil.truncateDecimal(price, precision);

  double get change => (price <= 0 || price24h <= 0)
      ? 0
      : NumberUtil.getDoubleByTwo(price - price24h, price24h);
}
