part of asset_domain_module;

// AssetModel
abstract class AssetAddress
    implements Built<AssetAddress, AssetAddressBuilder> {
  factory AssetAddress([Function(AssetAddressBuilder) b]) = _$AssetAddress;
  AssetAddress._();

  // Constructors
  factory AssetAddress.fromLocal({
    String walletName,
    String address,
    String chain,
    String symbol,
  }) {
    return AssetAddress().rebuild((e) => e
      ..address = address
      ..chain = chain
      ..symbol = symbol
      ..comments = walletName
      ..isLocal = true);
  }

  factory AssetAddress.fromAdd({
    String id,
    String address,
    String comments,
  }) {
    return AssetAddress().rebuild((e) => e
      ..id = id
      ..address = address
      ..comments = comments);
  }

  static Serializer<AssetAddress> get serializer => _$assetAddressSerializer;

// Fields
  @nullable
  String get id;

  @nullable
  String get address;

  @nullable
  String get chain;

  @nullable
  String get comments;

  @nullable
  @BuiltValueField(wireName: 'currency')
  String get symbol;

  @nullable
  bool get isLocal;
}
