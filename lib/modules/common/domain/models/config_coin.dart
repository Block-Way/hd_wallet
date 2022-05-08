part of common_domain_module;

abstract class ConfigCoin implements Built<ConfigCoin, ConfigCoinBuilder> {
// Constructors
  factory ConfigCoin([Function(ConfigCoinBuilder) b]) = _$ConfigCoin;
  ConfigCoin._();

  static Serializer<ConfigCoin> get serializer => _$configCoinSerializer;

// Fields
  @BuiltValueField(wireName: 'api_name')
  String get symbol;

  @BuiltValueField(wireName: 'net_type')
  String get chain;

  @BuiltValueField(wireName: 'english_name')
  String get name;

  @BuiltValueField(wireName: 'full_name')
  String get fullName;

  @BuiltValueField(wireName: 'icon_url')
  String get icon;

  @nullable
  @BuiltValueField(wireName: 'anchor')
  String get contract;

  @BuiltValueField(wireName: 'transfer_fee')
  double get transferFee;

  @nullable
  @BuiltValueField(wireName: 'chain_precision')
  int get chainPrecision;

  @BuiltValueField(wireName: 'display_precision')
  int get displayPrecision;

  @nullable
  @BuiltValueField(wireName: 'transfer_min_quota')
  double get transferMinQuota;

  @nullable
  @BuiltValueField(wireName: 'defi_reward')
  bool get defiReward;

  @nullable
  @BuiltValueField(wireName: 'hd_wallet_fee_level')
  ConfigCoinFee get hdWalletFeeLevel;

  bool get canInvitation => defiReward == true;

  String get iconUrl => AppConfig().getImageUrlFor(icon);
}
