part of common_domain_module;

abstract class ConfigOtc implements Built<ConfigOtc, ConfigOtcBuilder> {
// Constructors
  factory ConfigOtc([Function(ConfigOtcBuilder) b]) = _$ConfigOtc;
  ConfigOtc._();

  static Serializer<ConfigOtc> get serializer => _$configOtcSerializer;

// Fields
  @nullable
  bool get enable;

  @nullable
  @BuiltValueField(wireName: 'max_ads')
  int get maxAds;

  @nullable
  @BuiltValueField(wireName: 'trade_pair')
  BuiltMap<String, BuiltList<String>> get tradePairs;

  @nullable
  @BuiltValueField(wireName: 'deposit_fee')
  String get depositAmount;

  @nullable
  @BuiltValueField(wireName: 'deposit_currency')
  String get depositCurrency;

  @BuiltValueField(wireName: 'system_otc_address')
  BuiltMap<String, String> get systemOtcAddress;

  @BuiltValueField(wireName: 'system_deposit_address')
  String get systemDepositAddress;

  @nullable
  List<String> get tradeCoins => tradePairs.keys.toList();
}
