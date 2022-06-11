part of trade_domain_module;

abstract class TradeConfig implements Built<TradeConfig, TradeConfigBuilder> {
  // Constructors
  factory TradeConfig([Function(TradeConfigBuilder) b]) = _$TradeConfig;
  TradeConfig._();

  static Serializer<TradeConfig> get serializer => _$tradeConfigSerializer;

// Serializers
  static TradeConfig? fromJson(Map<String, dynamic> json) {
    return deserialize<TradeConfig>(json);
  }

// Fields

  @BuiltValueField(wireName: 'currency')
  BuiltList<TradeConfigCoin> get coins;

  @BuiltValueField(wireName: 'coin_pair')
  BuiltMap<String, TradeConfigPair> get tradePairs;

  @BuiltValueField(wireName: 'mqtt')
  BuiltList<String> get mqttHosts;

  MapEntry<String, int> get randomMqttHost {
    final random = math.Random();
    final randomIndex = random.nextInt(mqttHosts.length);
    final hostData = mqttHosts[randomIndex].split(':');
    if (hostData.length != 2) {
      //return null;
    }
    return MapEntry(hostData.first, NumberUtil.getInt(hostData.last));
  }

  List<TradePair> get allTradePairs {
    final allPairs = <TradePair>[];

    for (final market in tradePairs.entries) {
      for (final pair in market.value.pairs) {
        final status = TradePair.mapTradePairStatus(pair.status ?? '');
        // 关闭的，不显示了
        if (status != TradePairStatus.close) {
          allPairs.add(
            TradePair.fromConfig(
              speed: pair.speed,
              spans: pair.spans.toList(),
              pairId: pair.id,
              pairName: pair.name,
              marketId:
                  status == TradePairStatus.closing ? 'CLOSING' : market.key,
              priceChain: pair.price.chain,
              priceSymbol: pair.price.symbol,
              tradeChain: pair.trade.chain,
              tradeSymbol: pair.trade.symbol,
              apiStatus: pair.status ?? '',
            ),
          );
        }
      }
    }
    return allPairs;
  }

  List<TradeMarket?> get allTradeMarkets {
    final markets = tradePairs.entries
        .map((market) {
          final hasPairs =
              allTradePairs.indexWhere((pair) => pair.marketId == market.key) !=
                  -1;
          if (hasPairs) {
            return TradeMarket.fromConfig(
              market.key,
              market.value.localizedName.asMap(),
            );
          }
          return null;
        })
        .where((element) => element != null)
        .toList();

    final fixedSort = ['USDT-HAH', 'USDT-ERC20', 'USDT-TRC20'];

    markets.sort((a, b) {
      if (fixedSort.indexOf(a!.id) > fixedSort.indexOf(b!.id)) {
        return 1;
      }
      if (fixedSort.indexOf(a.id) < fixedSort.indexOf(b.id)) {
        return -1;
      }
      return a.id.compareTo(b.id);
    });

    if (allTradePairs.indexWhere((pair) => pair.marketId == 'CLOSING') != -1) {
      markets.add(TradeMarket.fromConfig('CLOSING', {}));
    }
    return markets;
  }
}
