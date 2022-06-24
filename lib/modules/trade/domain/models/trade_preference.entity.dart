part of trade_domain_module;

@HiveType(typeId: kHiveTypeTradePreference)
class TradePreference extends HiveObject {
  TradePreference() {
    tradePairSpan = {};
    tradePairResolution = {};
  }

  @HiveField(1)
  late Map<String, String> tradePairSpan;

  @HiveField(2)
  late Map<String, String> tradePairResolution;
}
