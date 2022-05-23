part of wallet_domain_module;

@HiveType(typeId: kHiveTypeCoinAddress)
class CoinAddress extends HiveObject {
  CoinAddress({
    @required this.chain,
    @required this.symbol,
    @required this.address,
    @required this.publicKey,
    this.addressType,
    this.addressMemoOrTag,
    this.description,
  }) {
    createdAt = DateTime.now();
    addressType = addressType ?? 'general';
    description = description ?? '';
  }

  @HiveField(0)
  String chain;
  @HiveField(8)
  String symbol;

  /// Description for this address, like a user note
  @HiveField(5)
  String description;

  @HiveField(1)
  String address;

  /// Memo or Tag, for example for EOS or XRP
  @HiveField(3)
  String addressMemoOrTag;

  /// Type of add address
  /// Default to general, means chain default address
  /// - For BTC can be General or SegWit
  /// - For other coins can be ETH and Mainnet
  @HiveField(2)
  String addressType;

  @HiveField(4)
  String publicKey;

  @HiveField(6)
  DateTime createdAt;
  @HiveField(7)
  DateTime updatedAt;
}
