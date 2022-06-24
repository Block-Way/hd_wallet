part of wallet_domain_module;

@HiveType(typeId: kHiveTypeCoinInfo)
class CoinInfo extends HiveObject {
  CoinInfo({
    required this.chain,
    required this.symbol,
    required this.name,
    required this.fullName,
    required this.chainPrecision,
    required this.displayPrecision,
    this.contract = '',
    this.iconOnline,
    this.iconLocal,
    this.isEnabled,
    this.isFixed,
  });

  @HiveField(0)
  String chain;
  @HiveField(1)
  String symbol;

  /// Token contract or fork
  /// - ETH: Token contract
  @HiveField(2)
  String contract;

  @HiveField(3)
  String name;
  @HiveField(4)
  String fullName;

  @HiveField(5)
  String? iconOnline;
  @HiveField(6)
  String? iconLocal;

  @HiveField(7)
  int chainPrecision;
  @HiveField(8)
  int displayPrecision;

  @HiveField(10)
  bool? isFixed;

  @HiveField(11)
  bool? isEnabled;
}
