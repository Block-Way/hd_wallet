part of wallet_domain_module;

@HiveType(typeId: kHiveTypeCoinBalance)
class CoinBalance extends HiveObject {
  CoinBalance({
    @required this.chain,
    @required this.symbol,
    this.balance = 0,
    this.unconfirmed = 0,
  }) {
    createdAt = DateTime.now();
  }

  @HiveField(0)
  String chain;
  @HiveField(1)
  String symbol;
  @HiveField(2)
  double balance;
  @HiveField(3)
  double unconfirmed;
  @HiveField(4)
  DateTime createdAt;
  @HiveField(5)
  DateTime updatedAt;
  @HiveField(6)
  DateTime lockUntil;
}
