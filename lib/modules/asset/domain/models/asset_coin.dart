part of asset_domain_module;

// AssetModel
abstract class AssetCoin implements Built<AssetCoin, AssetCoinBuilder> {
// Constructors
  factory AssetCoin([Function(AssetCoinBuilder) b]) = _$AssetCoin;
  AssetCoin._();

  factory AssetCoin.fromJson(Map<String, dynamic> json) {
    return deserialize<AssetCoin>(json);
  }

  static Serializer<AssetCoin> get serializer => _$assetCoinSerializer;

// Fields
  @nullable
  String get name;

  @nullable
  String get fullName;

  @nullable
  String get chain;

  @nullable
  String get symbol;

  @nullable
  String get address;

  @nullable
  String get iconOnline;

  @nullable
  String get iconLocal;

  @nullable
  int get chainPrecision;

  @nullable
  int get displayPrecision;

  @nullable
  double get balance;

  @nullable
  double get balanceUnconfirmed;

  @nullable
  bool get balanceUpdateFailed;

  @nullable
  bool get isEnabled;

  @nullable
  bool get isFixed;

  @nullable
  String get contract;

  String get id => '$chain:$symbol';

  String get iconUrl => iconOnline == null || iconOnline.startsWith('assets')
      ? iconOnline
      : AppConfig().getImageUrlFor(iconOnline);

  String get displayBalance => NumberUtil.truncateDecimal<String>(balance);

  String get displayName => name ?? symbol;

  String get displayFullName => fullName ?? '';

  /// Display the given amount using this Coin displayPrecision
  String displayAmountWithPrecision(dynamic amount) =>
      NumberUtil.truncateDecimal<String>(amount, displayPrecision);
}
