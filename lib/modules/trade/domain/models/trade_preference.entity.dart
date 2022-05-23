part of trade_domain_module;

@HiveType(typeId: kHiveTypeTradePreference)
class TradePreference extends HiveObject {
  TradePreference() {
    tradePairSpan = {};
    tradePairResolution = {};
  }

  @HiveField(1)
  Map<String, String> tradePairSpan;

  @HiveField(2)
  Map<String, String> tradePairResolution;
}
