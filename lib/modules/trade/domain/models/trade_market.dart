part of trade_domain_module;

abstract class TradeMarket implements Built<TradeMarket, TradeMarketBuilder> {
// Constructors
  factory TradeMarket([Function(TradeMarketBuilder) b]) = _$TradeMarket;
  TradeMarket._();

  factory TradeMarket.fromConfig(String id, Map<String, String> names) =>
      TradeMarket(
        (b) => b
          ..id = id
          ..names.replace(names),
      );

  static Serializer<TradeMarket> get serializer => _$tradeMarketSerializer;

// Fields
  String get id;

  BuiltMap<String, String> get names;

  bool get isClosing => id == 'CLOSING';

  String nameByLang(String lang) => names[lang] ?? names['en'] ?? '-';
}
