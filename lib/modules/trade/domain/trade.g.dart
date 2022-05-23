// GENERATED CODE - DO NOT MODIFY BY HAND

part of trade_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TradeConfig> _$tradeConfigSerializer = new _$TradeConfigSerializer();
Serializer<TradeConfigCoin> _$tradeConfigCoinSerializer =
    new _$TradeConfigCoinSerializer();
Serializer<TradeConfigPair> _$tradeConfigPairSerializer =
    new _$TradeConfigPairSerializer();
Serializer<TradeConfigPairItem> _$tradeConfigPairItemSerializer =
    new _$TradeConfigPairItemSerializer();
Serializer<TradeConfigPairItemInfo> _$tradeConfigPairItemInfoSerializer =
    new _$TradeConfigPairItemInfoSerializer();
Serializer<TradeMarket> _$tradeMarketSerializer = new _$TradeMarketSerializer();
Serializer<TradeDeal> _$tradeDealSerializer = new _$TradeDealSerializer();
Serializer<TradeOrderDetail> _$tradeOrderDetailSerializer =
    new _$TradeOrderDetailSerializer();
Serializer<TradeOrderDetailItem> _$tradeOrderDetailItemSerializer =
    new _$TradeOrderDetailItemSerializer();
Serializer<TradePair> _$tradePairSerializer = new _$TradePairSerializer();
Serializer<TradeInfo24h> _$tradeInfo24hSerializer =
    new _$TradeInfo24hSerializer();
Serializer<TradeTicker> _$tradeTickerSerializer = new _$TradeTickerSerializer();
Serializer<TradeState> _$tradeStateSerializer = new _$TradeStateSerializer();

class _$TradeConfigSerializer implements StructuredSerializer<TradeConfig> {
  @override
  final Iterable<Type> types = const [TradeConfig, _$TradeConfig];
  @override
  final String wireName = 'TradeConfig';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeConfig object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'currency',
      serializers.serialize(object.coins,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TradeConfigCoin)])),
      'coin_pair',
      serializers.serialize(object.tradePairs,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(TradeConfigPair)])),
      'mqtt',
      serializers.serialize(object.mqttHosts,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  TradeConfig deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currency':
          result.coins.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TradeConfigCoin)]))
              as BuiltList<Object>);
          break;
        case 'coin_pair':
          result.tradePairs.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(TradeConfigPair)
              ])));
          break;
        case 'mqtt':
          result.mqttHosts.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$TradeConfigCoinSerializer
    implements StructuredSerializer<TradeConfigCoin> {
  @override
  final Iterable<Type> types = const [TradeConfigCoin, _$TradeConfigCoin];
  @override
  final String wireName = 'TradeConfigCoin';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeConfigCoin object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'chain',
      serializers.serialize(object.chain,
          specifiedType: const FullType(String)),
      'currency',
      serializers.serialize(object.symbol,
          specifiedType: const FullType(String)),
      'default_fee',
      serializers.serialize(object.matchFee,
          specifiedType: const FullType(int)),
      'deal_precision',
      serializers.serialize(object.dealPrecision,
          specifiedType: const FullType(int)),
      'min_fee',
      serializers.serialize(object.networkFee,
          specifiedType: const FullType(double)),
      'min_height',
      serializers.serialize(object.minBlockHeight,
          specifiedType: const FullType(int)),
      'max_height',
      serializers.serialize(object.maxBlockHeight,
          specifiedType: const FullType(int)),
      'min_amount',
      serializers.serialize(object.minAmount,
          specifiedType: const FullType(double)),
      'max_amount',
      serializers.serialize(object.maxAmount,
          specifiedType: const FullType(double)),
    ];
    if (object.dealAddress != null) {
      result
        ..add('deal_address')
        ..add(serializers.serialize(object.dealAddress,
            specifiedType: const FullType(String)));
    }
    if (object.matchAddress != null) {
      result
        ..add('match_address')
        ..add(serializers.serialize(object.matchAddress,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TradeConfigCoin deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeConfigCoinBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'chain':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'deal_address':
          result.dealAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'match_address':
          result.matchAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'default_fee':
          result.matchFee = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'deal_precision':
          result.dealPrecision = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'min_fee':
          result.networkFee = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'min_height':
          result.minBlockHeight = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'max_height':
          result.maxBlockHeight = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'min_amount':
          result.minAmount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'max_amount':
          result.maxAmount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$TradeConfigPairSerializer
    implements StructuredSerializer<TradeConfigPair> {
  @override
  final Iterable<Type> types = const [TradeConfigPair, _$TradeConfigPair];
  @override
  final String wireName = 'TradeConfigPair';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeConfigPair object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.localizedName,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'list',
      serializers.serialize(object.pairs,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TradeConfigPairItem)])),
    ];

    return result;
  }

  @override
  TradeConfigPair deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeConfigPairBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.localizedName.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'list':
          result.pairs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TradeConfigPairItem)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$TradeConfigPairItemSerializer
    implements StructuredSerializer<TradeConfigPairItem> {
  @override
  final Iterable<Type> types = const [
    TradeConfigPairItem,
    _$TradeConfigPairItem
  ];
  @override
  final String wireName = 'TradeConfigPairItem';

  @override
  Iterable<Object> serialize(
      Serializers serializers, TradeConfigPairItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'speed',
      serializers.serialize(object.speed,
          specifiedType: const FullType(String)),
      'deep_span',
      serializers.serialize(object.spans,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'buy',
      serializers.serialize(object.price,
          specifiedType: const FullType(TradeConfigPairItemInfo)),
      'sell',
      serializers.serialize(object.trade,
          specifiedType: const FullType(TradeConfigPairItemInfo)),
    ];
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TradeConfigPairItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeConfigPairItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'speed':
          result.speed = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'deep_span':
          result.spans.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'buy':
          result.price.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TradeConfigPairItemInfo))
              as TradeConfigPairItemInfo);
          break;
        case 'sell':
          result.trade.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TradeConfigPairItemInfo))
              as TradeConfigPairItemInfo);
          break;
      }
    }

    return result.build();
  }
}

class _$TradeConfigPairItemInfoSerializer
    implements StructuredSerializer<TradeConfigPairItemInfo> {
  @override
  final Iterable<Type> types = const [
    TradeConfigPairItemInfo,
    _$TradeConfigPairItemInfo
  ];
  @override
  final String wireName = 'TradeConfigPairItemInfo';

  @override
  Iterable<Object> serialize(
      Serializers serializers, TradeConfigPairItemInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'chain',
      serializers.serialize(object.chain,
          specifiedType: const FullType(String)),
      'symbol',
      serializers.serialize(object.symbol,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TradeConfigPairItemInfo deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeConfigPairItemInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'chain':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TradeMarketSerializer implements StructuredSerializer<TradeMarket> {
  @override
  final Iterable<Type> types = const [TradeMarket, _$TradeMarket];
  @override
  final String wireName = 'TradeMarket';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeMarket object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'names',
      serializers.serialize(object.names,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
    ];

    return result;
  }

  @override
  TradeMarket deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeMarketBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'names':
          result.names.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
      }
    }

    return result.build();
  }
}

class _$TradeDealSerializer implements StructuredSerializer<TradeDeal> {
  @override
  final Iterable<Type> types = const [TradeDeal, _$TradeDeal];
  @override
  final String wireName = 'TradeDeal';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeDeal object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tradeSideId',
      serializers.serialize(object.tradeSideId,
          specifiedType: const FullType(int)),
      'tradePairId',
      serializers.serialize(object.tradePairId,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  TradeDeal deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeDealBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'tradeSideId':
          result.tradeSideId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tradePairId':
          result.tradePairId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$TradeOrderDetailSerializer
    implements StructuredSerializer<TradeOrderDetail> {
  @override
  final Iterable<Type> types = const [TradeOrderDetail, _$TradeOrderDetail];
  @override
  final String wireName = 'TradeOrderDetail';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeOrderDetail object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.total != null) {
      result
        ..add('min_amount')
        ..add(serializers.serialize(object.total,
            specifiedType: const FullType(String)));
    }
    if (object.matchList != null) {
      result
        ..add('match_list')
        ..add(serializers.serialize(object.matchList,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TradeOrderDetailItem)])));
    }
    if (object.exchangeList != null) {
      result
        ..add('exchange_list')
        ..add(serializers.serialize(object.exchangeList,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TradeOrderDetailItem)])));
    }
    return result;
  }

  @override
  TradeOrderDetail deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeOrderDetailBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'min_amount':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'match_list':
          result.matchList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TradeOrderDetailItem)]))
              as BuiltList<Object>);
          break;
        case 'exchange_list':
          result.exchangeList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TradeOrderDetailItem)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$TradeOrderDetailItemSerializer
    implements StructuredSerializer<TradeOrderDetailItem> {
  @override
  final Iterable<Type> types = const [
    TradeOrderDetailItem,
    _$TradeOrderDetailItem
  ];
  @override
  final String wireName = 'TradeOrderDetailItem';

  @override
  Iterable<Object> serialize(
      Serializers serializers, TradeOrderDetailItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.matchPrice != null) {
      result
        ..add('match_price')
        ..add(serializers.serialize(object.matchPrice,
            specifiedType: const FullType(String)));
    }
    if (object.amount != null) {
      result
        ..add('amount')
        ..add(serializers.serialize(object.amount,
            specifiedType: const FullType(String)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.fee != null) {
      result
        ..add('fee')
        ..add(serializers.serialize(object.fee,
            specifiedType: const FullType(String)));
    }
    if (object.txId != null) {
      result
        ..add('tx_id')
        ..add(serializers.serialize(object.txId,
            specifiedType: const FullType(String)));
    }
    if (object.matchId != null) {
      result
        ..add('template_match_address')
        ..add(serializers.serialize(object.matchId,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TradeOrderDetailItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeOrderDetailItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'match_price':
          result.matchPrice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fee':
          result.fee = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tx_id':
          result.txId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'template_match_address':
          result.matchId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TradePairSerializer implements StructuredSerializer<TradePair> {
  @override
  final Iterable<Type> types = const [TradePair, _$TradePair];
  @override
  final String wireName = 'TradePair';

  @override
  Iterable<Object> serialize(Serializers serializers, TradePair object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'speed',
      serializers.serialize(object.speed,
          specifiedType: const FullType(String)),
      'deep_span',
      serializers.serialize(object.spans,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'status',
      serializers.serialize(object.apiStatus,
          specifiedType: const FullType(String)),
      'marketId',
      serializers.serialize(object.marketId,
          specifiedType: const FullType(String)),
      'tradeName',
      serializers.serialize(object.tradeName,
          specifiedType: const FullType(String)),
      'tradeChain',
      serializers.serialize(object.tradeChain,
          specifiedType: const FullType(String)),
      'tradeSymbol',
      serializers.serialize(object.tradeSymbol,
          specifiedType: const FullType(String)),
      'priceName',
      serializers.serialize(object.priceName,
          specifiedType: const FullType(String)),
      'priceChain',
      serializers.serialize(object.priceChain,
          specifiedType: const FullType(String)),
      'priceSymbol',
      serializers.serialize(object.priceSymbol,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TradePair deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradePairBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'speed':
          result.speed = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'deep_span':
          result.spans.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'status':
          result.apiStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'marketId':
          result.marketId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tradeName':
          result.tradeName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tradeChain':
          result.tradeChain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tradeSymbol':
          result.tradeSymbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'priceName':
          result.priceName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'priceChain':
          result.priceChain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'priceSymbol':
          result.priceSymbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TradeInfo24hSerializer implements StructuredSerializer<TradeInfo24h> {
  @override
  final Iterable<Type> types = const [TradeInfo24h, _$TradeInfo24h];
  @override
  final String wireName = 'TradeInfo24h';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeInfo24h object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.high != null) {
      result
        ..add('high')
        ..add(serializers.serialize(object.high,
            specifiedType: const FullType(String)));
    }
    if (object.low != null) {
      result
        ..add('low')
        ..add(serializers.serialize(object.low,
            specifiedType: const FullType(String)));
    }
    if (object.vol != null) {
      result
        ..add('vol')
        ..add(serializers.serialize(object.vol,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  TradeInfo24h deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeInfo24hBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'high':
          result.high = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'low':
          result.low = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vol':
          result.vol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TradeTickerSerializer implements StructuredSerializer<TradeTicker> {
  @override
  final Iterable<Type> types = const [TradeTicker, _$TradeTicker];
  @override
  final String wireName = 'TradeTicker';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeTicker object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tradeSideId',
      serializers.serialize(object.tradeSideId,
          specifiedType: const FullType(int)),
      'tradePairId',
      serializers.serialize(object.tradePairId,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  TradeTicker deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeTickerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'tradeSideId':
          result.tradeSideId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tradePairId':
          result.tradePairId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$TradeStateSerializer implements StructuredSerializer<TradeState> {
  @override
  final Iterable<Type> types = const [TradeState, _$TradeState];
  @override
  final String wireName = 'TradeState';

  @override
  Iterable<Object> serialize(Serializers serializers, TradeState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tradeSide',
      serializers.serialize(object.tradeSide,
          specifiedType: const FullType(TradeSide)),
      'hideSlowTradePairTip',
      serializers.serialize(object.hideSlowTradePairTip,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    if (object.config != null) {
      result
        ..add('config')
        ..add(serializers.serialize(object.config,
            specifiedType: const FullType(TradeConfig)));
    }
    if (object.configState != null) {
      result
        ..add('configState')
        ..add(serializers.serialize(object.configState,
            specifiedType: const FullType(int)));
    }
    if (object.tradePair != null) {
      result
        ..add('tradePair')
        ..add(serializers.serialize(object.tradePair,
            specifiedType: const FullType(TradePair)));
    }
    if (object.currentOrderDetail != null) {
      result
        ..add('currentOrderDetail')
        ..add(serializers.serialize(object.currentOrderDetail,
            specifiedType: const FullType(TradeOrderDetail)));
    }
    return result;
  }

  @override
  TradeState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TradeStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'config':
          result.config.replace(serializers.deserialize(value,
              specifiedType: const FullType(TradeConfig)) as TradeConfig);
          break;
        case 'configState':
          result.configState = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tradePair':
          result.tradePair.replace(serializers.deserialize(value,
              specifiedType: const FullType(TradePair)) as TradePair);
          break;
        case 'tradeSide':
          result.tradeSide = serializers.deserialize(value,
              specifiedType: const FullType(TradeSide)) as TradeSide;
          break;
        case 'hideSlowTradePairTip':
          result.hideSlowTradePairTip.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'currentOrderDetail':
          result.currentOrderDetail.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TradeOrderDetail))
              as TradeOrderDetail);
          break;
      }
    }

    return result.build();
  }
}

class _$TradeOrderDetailVM extends TradeOrderDetailVM {
  @override
  final TradeOrderDetail currentOrderDetail;
  @override
  final Future<TradeOrderDetail> Function(String txId) getOrderDetail;
  @override
  final Future<double> Function(TradeOrder order) getOrderBalance;
  @override
  final Future<TradeOrder> Function(TradeOrder order) doOrderCheckStatus;

  factory _$TradeOrderDetailVM(
          [void Function(TradeOrderDetailVMBuilder) updates]) =>
      (new TradeOrderDetailVMBuilder()..update(updates)).build();

  _$TradeOrderDetailVM._(
      {this.currentOrderDetail,
      this.getOrderDetail,
      this.getOrderBalance,
      this.doOrderCheckStatus})
      : super._() {
    if (getOrderBalance == null) {
      throw new BuiltValueNullFieldError(
          'TradeOrderDetailVM', 'getOrderBalance');
    }
    if (doOrderCheckStatus == null) {
      throw new BuiltValueNullFieldError(
          'TradeOrderDetailVM', 'doOrderCheckStatus');
    }
  }

  @override
  TradeOrderDetailVM rebuild(
          void Function(TradeOrderDetailVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeOrderDetailVMBuilder toBuilder() =>
      new TradeOrderDetailVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeOrderDetailVM &&
        currentOrderDetail == other.currentOrderDetail;
  }

  @override
  int get hashCode {
    return $jf($jc(0, currentOrderDetail.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeOrderDetailVM')
          ..add('currentOrderDetail', currentOrderDetail)
          ..add('getOrderDetail', getOrderDetail)
          ..add('getOrderBalance', getOrderBalance)
          ..add('doOrderCheckStatus', doOrderCheckStatus))
        .toString();
  }
}

class TradeOrderDetailVMBuilder
    implements Builder<TradeOrderDetailVM, TradeOrderDetailVMBuilder> {
  _$TradeOrderDetailVM _$v;

  TradeOrderDetailBuilder _currentOrderDetail;
  TradeOrderDetailBuilder get currentOrderDetail =>
      _$this._currentOrderDetail ??= new TradeOrderDetailBuilder();
  set currentOrderDetail(TradeOrderDetailBuilder currentOrderDetail) =>
      _$this._currentOrderDetail = currentOrderDetail;

  Future<TradeOrderDetail> Function(String txId) _getOrderDetail;
  Future<TradeOrderDetail> Function(String txId) get getOrderDetail =>
      _$this._getOrderDetail;
  set getOrderDetail(
          Future<TradeOrderDetail> Function(String txId) getOrderDetail) =>
      _$this._getOrderDetail = getOrderDetail;

  Future<double> Function(TradeOrder order) _getOrderBalance;
  Future<double> Function(TradeOrder order) get getOrderBalance =>
      _$this._getOrderBalance;
  set getOrderBalance(
          Future<double> Function(TradeOrder order) getOrderBalance) =>
      _$this._getOrderBalance = getOrderBalance;

  Future<TradeOrder> Function(TradeOrder order) _doOrderCheckStatus;
  Future<TradeOrder> Function(TradeOrder order) get doOrderCheckStatus =>
      _$this._doOrderCheckStatus;
  set doOrderCheckStatus(
          Future<TradeOrder> Function(TradeOrder order) doOrderCheckStatus) =>
      _$this._doOrderCheckStatus = doOrderCheckStatus;

  TradeOrderDetailVMBuilder();

  TradeOrderDetailVMBuilder get _$this {
    if (_$v != null) {
      _currentOrderDetail = _$v.currentOrderDetail?.toBuilder();
      _getOrderDetail = _$v.getOrderDetail;
      _getOrderBalance = _$v.getOrderBalance;
      _doOrderCheckStatus = _$v.doOrderCheckStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeOrderDetailVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeOrderDetailVM;
  }

  @override
  void update(void Function(TradeOrderDetailVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeOrderDetailVM build() {
    _$TradeOrderDetailVM _$result;
    try {
      _$result = _$v ??
          new _$TradeOrderDetailVM._(
              currentOrderDetail: _currentOrderDetail?.build(),
              getOrderDetail: getOrderDetail,
              getOrderBalance: getOrderBalance,
              doOrderCheckStatus: doOrderCheckStatus);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currentOrderDetail';
        _currentOrderDetail?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeOrderDetailVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeOrderListVM extends TradeOrderListVM {
  @override
  final String walletId;
  @override
  final AssetCoin Function({@required String chain, @required String symbol})
      getCoinInfo;

  factory _$TradeOrderListVM(
          [void Function(TradeOrderListVMBuilder) updates]) =>
      (new TradeOrderListVMBuilder()..update(updates)).build();

  _$TradeOrderListVM._({this.walletId, this.getCoinInfo}) : super._() {
    if (walletId == null) {
      throw new BuiltValueNullFieldError('TradeOrderListVM', 'walletId');
    }
    if (getCoinInfo == null) {
      throw new BuiltValueNullFieldError('TradeOrderListVM', 'getCoinInfo');
    }
  }

  @override
  TradeOrderListVM rebuild(void Function(TradeOrderListVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeOrderListVMBuilder toBuilder() =>
      new TradeOrderListVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeOrderListVM && walletId == other.walletId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, walletId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeOrderListVM')
          ..add('walletId', walletId)
          ..add('getCoinInfo', getCoinInfo))
        .toString();
  }
}

class TradeOrderListVMBuilder
    implements Builder<TradeOrderListVM, TradeOrderListVMBuilder> {
  _$TradeOrderListVM _$v;

  String _walletId;
  String get walletId => _$this._walletId;
  set walletId(String walletId) => _$this._walletId = walletId;

  AssetCoin Function({@required String chain, @required String symbol})
      _getCoinInfo;
  AssetCoin Function({@required String chain, @required String symbol})
      get getCoinInfo => _$this._getCoinInfo;
  set getCoinInfo(
          AssetCoin Function({@required String chain, @required String symbol})
              getCoinInfo) =>
      _$this._getCoinInfo = getCoinInfo;

  TradeOrderListVMBuilder();

  TradeOrderListVMBuilder get _$this {
    if (_$v != null) {
      _walletId = _$v.walletId;
      _getCoinInfo = _$v.getCoinInfo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeOrderListVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeOrderListVM;
  }

  @override
  void update(void Function(TradeOrderListVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeOrderListVM build() {
    final _$result = _$v ??
        new _$TradeOrderListVM._(walletId: walletId, getCoinInfo: getCoinInfo);
    replace(_$result);
    return _$result;
  }
}

class _$TradeHomeVM extends TradeHomeVM {
  @override
  final bool hasWallet;
  @override
  final TradePair tradePair;
  @override
  final TradeSide tradeSide;
  @override
  final String fiatCurrency;
  @override
  final String activeWalletId;
  @override
  final AssetCoin priceCoinInfo;
  @override
  final AssetCoin tradeCoinInfo;
  @override
  final AssetCoin sideCoinInfo;
  @override
  final TradeConfigCoin sideCoinConfig;
  @override
  final BuiltList<TradePair> allTradePairs;
  @override
  final Future<void> Function(TradePair tradePair) doUpdateCoinBalance;
  @override
  final Future<double> Function(TradePair) getApproveBalance;
  @override
  final Future<void> Function(TradeSide tradeSide) doChangeTradeSide;
  @override
  final Future<void> Function(TradePair tradePair) doChangeTradePair;
  @override
  final Future<void> Function(TradePair tradePair) doSubscribeMqtt;
  @override
  final AssetCoin Function({@required String chain, @required String symbol})
      getCoinInfo;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;
  @override
  final Future<void> Function(
      {@required
          TradeSide tradeSide,
      @required
          TradePair tradePair,
      @required
          Future<bool> Function(
                  {@required WalletTemplateData approveData,
                  @required double currentBalance,
                  @required double approveAmount,
                  @required bool needReset})
              onConfirmSubmit,
      @required
          Future<WalletPrivateData> Function() onUnlockWallet,
      @required
          void Function(String) onSuccessTransaction}) doApproveOrder;
  @override
  final Future<void> Function(
      {@required TradeSide tradeSide,
      @required TradePair tradePair,
      @required String price,
      @required String amount,
      @required String total,
      @required Future<bool> Function(DexCreateOrderParams) onConfirmSubmit,
      @required Future<WalletPrivateData> Function() onUnlockWallet,
      @required void Function(String) onSuccessTransaction}) doCreateOrder;
  @override
  final Future<void> Function(
      {@required TradeOrder order,
      @required Future<bool> Function(double) onConfirmCancel,
      @required Future<WalletPrivateData> Function() onUnlockWallet,
      @required void Function(String) onSuccessTransaction}) doCancelOrder;
  @override
  final Future<Transaction> Function(
      {@required String chain,
      @required String symbol,
      @required String fromAddress,
      @required int chainPrecision,
      @required String txId}) getTransactionInfo;
  @override
  final bool Function(TradePair) needShowSlowTradePair;
  @override
  final void Function(TradePair) doHideSlowTradePair;
  @override
  final Future<double> Function(TradeOrder order) getOrderBalance;

  factory _$TradeHomeVM([void Function(TradeHomeVMBuilder) updates]) =>
      (new TradeHomeVMBuilder()..update(updates)).build();

  _$TradeHomeVM._(
      {this.hasWallet,
      this.tradePair,
      this.tradeSide,
      this.fiatCurrency,
      this.activeWalletId,
      this.priceCoinInfo,
      this.tradeCoinInfo,
      this.sideCoinInfo,
      this.sideCoinConfig,
      this.allTradePairs,
      this.doUpdateCoinBalance,
      this.getApproveBalance,
      this.doChangeTradeSide,
      this.doChangeTradePair,
      this.doSubscribeMqtt,
      this.getCoinInfo,
      this.doUnlockWallet,
      this.doApproveOrder,
      this.doCreateOrder,
      this.doCancelOrder,
      this.getTransactionInfo,
      this.needShowSlowTradePair,
      this.doHideSlowTradePair,
      this.getOrderBalance})
      : super._() {
    if (hasWallet == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'hasWallet');
    }
    if (tradePair == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'tradePair');
    }
    if (tradeSide == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'tradeSide');
    }
    if (fiatCurrency == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'fiatCurrency');
    }
    if (allTradePairs == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'allTradePairs');
    }
    if (doUpdateCoinBalance == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doUpdateCoinBalance');
    }
    if (getApproveBalance == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'getApproveBalance');
    }
    if (doChangeTradePair == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doChangeTradePair');
    }
    if (doSubscribeMqtt == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doSubscribeMqtt');
    }
    if (getCoinInfo == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'getCoinInfo');
    }
    if (doUnlockWallet == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doUnlockWallet');
    }
    if (doApproveOrder == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doApproveOrder');
    }
    if (doCreateOrder == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doCreateOrder');
    }
    if (doCancelOrder == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doCancelOrder');
    }
    if (getTransactionInfo == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'getTransactionInfo');
    }
    if (needShowSlowTradePair == null) {
      throw new BuiltValueNullFieldError(
          'TradeHomeVM', 'needShowSlowTradePair');
    }
    if (doHideSlowTradePair == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'doHideSlowTradePair');
    }
    if (getOrderBalance == null) {
      throw new BuiltValueNullFieldError('TradeHomeVM', 'getOrderBalance');
    }
  }

  @override
  TradeHomeVM rebuild(void Function(TradeHomeVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeHomeVMBuilder toBuilder() => new TradeHomeVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeHomeVM &&
        hasWallet == other.hasWallet &&
        tradePair == other.tradePair &&
        tradeSide == other.tradeSide &&
        fiatCurrency == other.fiatCurrency &&
        activeWalletId == other.activeWalletId &&
        priceCoinInfo == other.priceCoinInfo &&
        tradeCoinInfo == other.tradeCoinInfo &&
        sideCoinInfo == other.sideCoinInfo &&
        sideCoinConfig == other.sideCoinConfig &&
        allTradePairs == other.allTradePairs;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, hasWallet.hashCode),
                                        tradePair.hashCode),
                                    tradeSide.hashCode),
                                fiatCurrency.hashCode),
                            activeWalletId.hashCode),
                        priceCoinInfo.hashCode),
                    tradeCoinInfo.hashCode),
                sideCoinInfo.hashCode),
            sideCoinConfig.hashCode),
        allTradePairs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeHomeVM')
          ..add('hasWallet', hasWallet)
          ..add('tradePair', tradePair)
          ..add('tradeSide', tradeSide)
          ..add('fiatCurrency', fiatCurrency)
          ..add('activeWalletId', activeWalletId)
          ..add('priceCoinInfo', priceCoinInfo)
          ..add('tradeCoinInfo', tradeCoinInfo)
          ..add('sideCoinInfo', sideCoinInfo)
          ..add('sideCoinConfig', sideCoinConfig)
          ..add('allTradePairs', allTradePairs)
          ..add('doUpdateCoinBalance', doUpdateCoinBalance)
          ..add('getApproveBalance', getApproveBalance)
          ..add('doChangeTradeSide', doChangeTradeSide)
          ..add('doChangeTradePair', doChangeTradePair)
          ..add('doSubscribeMqtt', doSubscribeMqtt)
          ..add('getCoinInfo', getCoinInfo)
          ..add('doUnlockWallet', doUnlockWallet)
          ..add('doApproveOrder', doApproveOrder)
          ..add('doCreateOrder', doCreateOrder)
          ..add('doCancelOrder', doCancelOrder)
          ..add('getTransactionInfo', getTransactionInfo)
          ..add('needShowSlowTradePair', needShowSlowTradePair)
          ..add('doHideSlowTradePair', doHideSlowTradePair)
          ..add('getOrderBalance', getOrderBalance))
        .toString();
  }
}

class TradeHomeVMBuilder implements Builder<TradeHomeVM, TradeHomeVMBuilder> {
  _$TradeHomeVM _$v;

  bool _hasWallet;
  bool get hasWallet => _$this._hasWallet;
  set hasWallet(bool hasWallet) => _$this._hasWallet = hasWallet;

  TradePairBuilder _tradePair;
  TradePairBuilder get tradePair =>
      _$this._tradePair ??= new TradePairBuilder();
  set tradePair(TradePairBuilder tradePair) => _$this._tradePair = tradePair;

  TradeSide _tradeSide;
  TradeSide get tradeSide => _$this._tradeSide;
  set tradeSide(TradeSide tradeSide) => _$this._tradeSide = tradeSide;

  String _fiatCurrency;
  String get fiatCurrency => _$this._fiatCurrency;
  set fiatCurrency(String fiatCurrency) => _$this._fiatCurrency = fiatCurrency;

  String _activeWalletId;
  String get activeWalletId => _$this._activeWalletId;
  set activeWalletId(String activeWalletId) =>
      _$this._activeWalletId = activeWalletId;

  AssetCoinBuilder _priceCoinInfo;
  AssetCoinBuilder get priceCoinInfo =>
      _$this._priceCoinInfo ??= new AssetCoinBuilder();
  set priceCoinInfo(AssetCoinBuilder priceCoinInfo) =>
      _$this._priceCoinInfo = priceCoinInfo;

  AssetCoinBuilder _tradeCoinInfo;
  AssetCoinBuilder get tradeCoinInfo =>
      _$this._tradeCoinInfo ??= new AssetCoinBuilder();
  set tradeCoinInfo(AssetCoinBuilder tradeCoinInfo) =>
      _$this._tradeCoinInfo = tradeCoinInfo;

  AssetCoinBuilder _sideCoinInfo;
  AssetCoinBuilder get sideCoinInfo =>
      _$this._sideCoinInfo ??= new AssetCoinBuilder();
  set sideCoinInfo(AssetCoinBuilder sideCoinInfo) =>
      _$this._sideCoinInfo = sideCoinInfo;

  TradeConfigCoinBuilder _sideCoinConfig;
  TradeConfigCoinBuilder get sideCoinConfig =>
      _$this._sideCoinConfig ??= new TradeConfigCoinBuilder();
  set sideCoinConfig(TradeConfigCoinBuilder sideCoinConfig) =>
      _$this._sideCoinConfig = sideCoinConfig;

  ListBuilder<TradePair> _allTradePairs;
  ListBuilder<TradePair> get allTradePairs =>
      _$this._allTradePairs ??= new ListBuilder<TradePair>();
  set allTradePairs(ListBuilder<TradePair> allTradePairs) =>
      _$this._allTradePairs = allTradePairs;

  Future<void> Function(TradePair tradePair) _doUpdateCoinBalance;
  Future<void> Function(TradePair tradePair) get doUpdateCoinBalance =>
      _$this._doUpdateCoinBalance;
  set doUpdateCoinBalance(
          Future<void> Function(TradePair tradePair) doUpdateCoinBalance) =>
      _$this._doUpdateCoinBalance = doUpdateCoinBalance;

  Future<double> Function(TradePair) _getApproveBalance;
  Future<double> Function(TradePair) get getApproveBalance =>
      _$this._getApproveBalance;
  set getApproveBalance(Future<double> Function(TradePair) getApproveBalance) =>
      _$this._getApproveBalance = getApproveBalance;

  Future<void> Function(TradeSide tradeSide) _doChangeTradeSide;
  Future<void> Function(TradeSide tradeSide) get doChangeTradeSide =>
      _$this._doChangeTradeSide;
  set doChangeTradeSide(
          Future<void> Function(TradeSide tradeSide) doChangeTradeSide) =>
      _$this._doChangeTradeSide = doChangeTradeSide;

  Future<void> Function(TradePair tradePair) _doChangeTradePair;
  Future<void> Function(TradePair tradePair) get doChangeTradePair =>
      _$this._doChangeTradePair;
  set doChangeTradePair(
          Future<void> Function(TradePair tradePair) doChangeTradePair) =>
      _$this._doChangeTradePair = doChangeTradePair;

  Future<void> Function(TradePair tradePair) _doSubscribeMqtt;
  Future<void> Function(TradePair tradePair) get doSubscribeMqtt =>
      _$this._doSubscribeMqtt;
  set doSubscribeMqtt(
          Future<void> Function(TradePair tradePair) doSubscribeMqtt) =>
      _$this._doSubscribeMqtt = doSubscribeMqtt;

  AssetCoin Function({@required String chain, @required String symbol})
      _getCoinInfo;
  AssetCoin Function({@required String chain, @required String symbol})
      get getCoinInfo => _$this._getCoinInfo;
  set getCoinInfo(
          AssetCoin Function({@required String chain, @required String symbol})
              getCoinInfo) =>
      _$this._getCoinInfo = getCoinInfo;

  Future<WalletPrivateData> Function(String password) _doUnlockWallet;
  Future<WalletPrivateData> Function(String password) get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password) doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  Future<void> Function(
      {@required
          TradeSide tradeSide,
      @required
          TradePair tradePair,
      @required
          Future<bool> Function(
                  {@required WalletTemplateData approveData,
                  @required double currentBalance,
                  @required double approveAmount,
                  @required bool needReset})
              onConfirmSubmit,
      @required
          Future<WalletPrivateData> Function() onUnlockWallet,
      @required
          void Function(String) onSuccessTransaction}) _doApproveOrder;
  Future<void> Function(
      {@required
          TradeSide tradeSide,
      @required
          TradePair tradePair,
      @required
          Future<bool> Function(
                  {@required WalletTemplateData approveData,
                  @required double currentBalance,
                  @required double approveAmount,
                  @required bool needReset})
              onConfirmSubmit,
      @required
          Future<WalletPrivateData> Function() onUnlockWallet,
      @required
          void Function(String) onSuccessTransaction}) get doApproveOrder =>
      _$this._doApproveOrder;
  set doApproveOrder(
          Future<void> Function(
                  {@required
                      TradeSide tradeSide,
                  @required
                      TradePair tradePair,
                  @required
                      Future<bool> Function(
                              {@required WalletTemplateData approveData,
                              @required double currentBalance,
                              @required double approveAmount,
                              @required bool needReset})
                          onConfirmSubmit,
                  @required
                      Future<WalletPrivateData> Function() onUnlockWallet,
                  @required
                      void Function(String) onSuccessTransaction})
              doApproveOrder) =>
      _$this._doApproveOrder = doApproveOrder;

  Future<void> Function(
      {@required TradeSide tradeSide,
      @required TradePair tradePair,
      @required String price,
      @required String amount,
      @required String total,
      @required Future<bool> Function(DexCreateOrderParams) onConfirmSubmit,
      @required Future<WalletPrivateData> Function() onUnlockWallet,
      @required void Function(String) onSuccessTransaction}) _doCreateOrder;
  Future<void> Function(
          {@required TradeSide tradeSide,
          @required TradePair tradePair,
          @required String price,
          @required String amount,
          @required String total,
          @required Future<bool> Function(DexCreateOrderParams) onConfirmSubmit,
          @required Future<WalletPrivateData> Function() onUnlockWallet,
          @required void Function(String) onSuccessTransaction})
      get doCreateOrder => _$this._doCreateOrder;
  set doCreateOrder(
          Future<void> Function(
                  {@required
                      TradeSide tradeSide,
                  @required
                      TradePair tradePair,
                  @required
                      String price,
                  @required
                      String amount,
                  @required
                      String total,
                  @required
                      Future<bool> Function(DexCreateOrderParams)
                          onConfirmSubmit,
                  @required
                      Future<WalletPrivateData> Function() onUnlockWallet,
                  @required
                      void Function(String) onSuccessTransaction})
              doCreateOrder) =>
      _$this._doCreateOrder = doCreateOrder;

  Future<void> Function(
      {@required TradeOrder order,
      @required Future<bool> Function(double) onConfirmCancel,
      @required Future<WalletPrivateData> Function() onUnlockWallet,
      @required void Function(String) onSuccessTransaction}) _doCancelOrder;
  Future<void> Function(
          {@required TradeOrder order,
          @required Future<bool> Function(double) onConfirmCancel,
          @required Future<WalletPrivateData> Function() onUnlockWallet,
          @required void Function(String) onSuccessTransaction})
      get doCancelOrder => _$this._doCancelOrder;
  set doCancelOrder(
          Future<void> Function(
                  {@required TradeOrder order,
                  @required Future<bool> Function(double) onConfirmCancel,
                  @required Future<WalletPrivateData> Function() onUnlockWallet,
                  @required void Function(String) onSuccessTransaction})
              doCancelOrder) =>
      _$this._doCancelOrder = doCancelOrder;

  Future<Transaction> Function(
      {@required String chain,
      @required String symbol,
      @required String fromAddress,
      @required int chainPrecision,
      @required String txId}) _getTransactionInfo;
  Future<Transaction> Function(
          {@required String chain,
          @required String symbol,
          @required String fromAddress,
          @required int chainPrecision,
          @required String txId})
      get getTransactionInfo => _$this._getTransactionInfo;
  set getTransactionInfo(
          Future<Transaction> Function(
                  {@required String chain,
                  @required String symbol,
                  @required String fromAddress,
                  @required int chainPrecision,
                  @required String txId})
              getTransactionInfo) =>
      _$this._getTransactionInfo = getTransactionInfo;

  bool Function(TradePair) _needShowSlowTradePair;
  bool Function(TradePair) get needShowSlowTradePair =>
      _$this._needShowSlowTradePair;
  set needShowSlowTradePair(bool Function(TradePair) needShowSlowTradePair) =>
      _$this._needShowSlowTradePair = needShowSlowTradePair;

  void Function(TradePair) _doHideSlowTradePair;
  void Function(TradePair) get doHideSlowTradePair =>
      _$this._doHideSlowTradePair;
  set doHideSlowTradePair(void Function(TradePair) doHideSlowTradePair) =>
      _$this._doHideSlowTradePair = doHideSlowTradePair;

  Future<double> Function(TradeOrder order) _getOrderBalance;
  Future<double> Function(TradeOrder order) get getOrderBalance =>
      _$this._getOrderBalance;
  set getOrderBalance(
          Future<double> Function(TradeOrder order) getOrderBalance) =>
      _$this._getOrderBalance = getOrderBalance;

  TradeHomeVMBuilder();

  TradeHomeVMBuilder get _$this {
    if (_$v != null) {
      _hasWallet = _$v.hasWallet;
      _tradePair = _$v.tradePair?.toBuilder();
      _tradeSide = _$v.tradeSide;
      _fiatCurrency = _$v.fiatCurrency;
      _activeWalletId = _$v.activeWalletId;
      _priceCoinInfo = _$v.priceCoinInfo?.toBuilder();
      _tradeCoinInfo = _$v.tradeCoinInfo?.toBuilder();
      _sideCoinInfo = _$v.sideCoinInfo?.toBuilder();
      _sideCoinConfig = _$v.sideCoinConfig?.toBuilder();
      _allTradePairs = _$v.allTradePairs?.toBuilder();
      _doUpdateCoinBalance = _$v.doUpdateCoinBalance;
      _getApproveBalance = _$v.getApproveBalance;
      _doChangeTradeSide = _$v.doChangeTradeSide;
      _doChangeTradePair = _$v.doChangeTradePair;
      _doSubscribeMqtt = _$v.doSubscribeMqtt;
      _getCoinInfo = _$v.getCoinInfo;
      _doUnlockWallet = _$v.doUnlockWallet;
      _doApproveOrder = _$v.doApproveOrder;
      _doCreateOrder = _$v.doCreateOrder;
      _doCancelOrder = _$v.doCancelOrder;
      _getTransactionInfo = _$v.getTransactionInfo;
      _needShowSlowTradePair = _$v.needShowSlowTradePair;
      _doHideSlowTradePair = _$v.doHideSlowTradePair;
      _getOrderBalance = _$v.getOrderBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeHomeVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeHomeVM;
  }

  @override
  void update(void Function(TradeHomeVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeHomeVM build() {
    _$TradeHomeVM _$result;
    try {
      _$result = _$v ??
          new _$TradeHomeVM._(
              hasWallet: hasWallet,
              tradePair: tradePair.build(),
              tradeSide: tradeSide,
              fiatCurrency: fiatCurrency,
              activeWalletId: activeWalletId,
              priceCoinInfo: _priceCoinInfo?.build(),
              tradeCoinInfo: _tradeCoinInfo?.build(),
              sideCoinInfo: _sideCoinInfo?.build(),
              sideCoinConfig: _sideCoinConfig?.build(),
              allTradePairs: allTradePairs.build(),
              doUpdateCoinBalance: doUpdateCoinBalance,
              getApproveBalance: getApproveBalance,
              doChangeTradeSide: doChangeTradeSide,
              doChangeTradePair: doChangeTradePair,
              doSubscribeMqtt: doSubscribeMqtt,
              getCoinInfo: getCoinInfo,
              doUnlockWallet: doUnlockWallet,
              doApproveOrder: doApproveOrder,
              doCreateOrder: doCreateOrder,
              doCancelOrder: doCancelOrder,
              getTransactionInfo: getTransactionInfo,
              needShowSlowTradePair: needShowSlowTradePair,
              doHideSlowTradePair: doHideSlowTradePair,
              getOrderBalance: getOrderBalance);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tradePair';
        tradePair.build();

        _$failedField = 'priceCoinInfo';
        _priceCoinInfo?.build();
        _$failedField = 'tradeCoinInfo';
        _tradeCoinInfo?.build();
        _$failedField = 'sideCoinInfo';
        _sideCoinInfo?.build();
        _$failedField = 'sideCoinConfig';
        _sideCoinConfig?.build();
        _$failedField = 'allTradePairs';
        allTradePairs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeHomeVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradePairVM extends TradePairVM {
  @override
  final BuiltList<TradePair> allTradePairs;
  @override
  final BuiltList<TradeMarket> allTradeMarkets;
  @override
  final String fiatCurrency;
  @override
  final TradePair tradePair;
  @override
  final void Function() doLoadTradePair;

  factory _$TradePairVM([void Function(TradePairVMBuilder) updates]) =>
      (new TradePairVMBuilder()..update(updates)).build();

  _$TradePairVM._(
      {this.allTradePairs,
      this.allTradeMarkets,
      this.fiatCurrency,
      this.tradePair,
      this.doLoadTradePair})
      : super._() {
    if (allTradePairs == null) {
      throw new BuiltValueNullFieldError('TradePairVM', 'allTradePairs');
    }
    if (allTradeMarkets == null) {
      throw new BuiltValueNullFieldError('TradePairVM', 'allTradeMarkets');
    }
    if (fiatCurrency == null) {
      throw new BuiltValueNullFieldError('TradePairVM', 'fiatCurrency');
    }
    if (tradePair == null) {
      throw new BuiltValueNullFieldError('TradePairVM', 'tradePair');
    }
    if (doLoadTradePair == null) {
      throw new BuiltValueNullFieldError('TradePairVM', 'doLoadTradePair');
    }
  }

  @override
  TradePairVM rebuild(void Function(TradePairVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradePairVMBuilder toBuilder() => new TradePairVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradePairVM &&
        allTradePairs == other.allTradePairs &&
        allTradeMarkets == other.allTradeMarkets &&
        fiatCurrency == other.fiatCurrency &&
        tradePair == other.tradePair;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, allTradePairs.hashCode), allTradeMarkets.hashCode),
            fiatCurrency.hashCode),
        tradePair.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradePairVM')
          ..add('allTradePairs', allTradePairs)
          ..add('allTradeMarkets', allTradeMarkets)
          ..add('fiatCurrency', fiatCurrency)
          ..add('tradePair', tradePair)
          ..add('doLoadTradePair', doLoadTradePair))
        .toString();
  }
}

class TradePairVMBuilder implements Builder<TradePairVM, TradePairVMBuilder> {
  _$TradePairVM _$v;

  ListBuilder<TradePair> _allTradePairs;
  ListBuilder<TradePair> get allTradePairs =>
      _$this._allTradePairs ??= new ListBuilder<TradePair>();
  set allTradePairs(ListBuilder<TradePair> allTradePairs) =>
      _$this._allTradePairs = allTradePairs;

  ListBuilder<TradeMarket> _allTradeMarkets;
  ListBuilder<TradeMarket> get allTradeMarkets =>
      _$this._allTradeMarkets ??= new ListBuilder<TradeMarket>();
  set allTradeMarkets(ListBuilder<TradeMarket> allTradeMarkets) =>
      _$this._allTradeMarkets = allTradeMarkets;

  String _fiatCurrency;
  String get fiatCurrency => _$this._fiatCurrency;
  set fiatCurrency(String fiatCurrency) => _$this._fiatCurrency = fiatCurrency;

  TradePairBuilder _tradePair;
  TradePairBuilder get tradePair =>
      _$this._tradePair ??= new TradePairBuilder();
  set tradePair(TradePairBuilder tradePair) => _$this._tradePair = tradePair;

  void Function() _doLoadTradePair;
  void Function() get doLoadTradePair => _$this._doLoadTradePair;
  set doLoadTradePair(void Function() doLoadTradePair) =>
      _$this._doLoadTradePair = doLoadTradePair;

  TradePairVMBuilder();

  TradePairVMBuilder get _$this {
    if (_$v != null) {
      _allTradePairs = _$v.allTradePairs?.toBuilder();
      _allTradeMarkets = _$v.allTradeMarkets?.toBuilder();
      _fiatCurrency = _$v.fiatCurrency;
      _tradePair = _$v.tradePair?.toBuilder();
      _doLoadTradePair = _$v.doLoadTradePair;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradePairVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradePairVM;
  }

  @override
  void update(void Function(TradePairVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradePairVM build() {
    _$TradePairVM _$result;
    try {
      _$result = _$v ??
          new _$TradePairVM._(
              allTradePairs: allTradePairs.build(),
              allTradeMarkets: allTradeMarkets.build(),
              fiatCurrency: fiatCurrency,
              tradePair: tradePair.build(),
              doLoadTradePair: doLoadTradePair);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'allTradePairs';
        allTradePairs.build();
        _$failedField = 'allTradeMarkets';
        allTradeMarkets.build();

        _$failedField = 'tradePair';
        tradePair.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradePairVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeConfig extends TradeConfig {
  @override
  final BuiltList<TradeConfigCoin> coins;
  @override
  final BuiltMap<String, TradeConfigPair> tradePairs;
  @override
  final BuiltList<String> mqttHosts;

  factory _$TradeConfig([void Function(TradeConfigBuilder) updates]) =>
      (new TradeConfigBuilder()..update(updates)).build();

  _$TradeConfig._({this.coins, this.tradePairs, this.mqttHosts}) : super._() {
    if (coins == null) {
      throw new BuiltValueNullFieldError('TradeConfig', 'coins');
    }
    if (tradePairs == null) {
      throw new BuiltValueNullFieldError('TradeConfig', 'tradePairs');
    }
    if (mqttHosts == null) {
      throw new BuiltValueNullFieldError('TradeConfig', 'mqttHosts');
    }
  }

  @override
  TradeConfig rebuild(void Function(TradeConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeConfigBuilder toBuilder() => new TradeConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeConfig &&
        coins == other.coins &&
        tradePairs == other.tradePairs &&
        mqttHosts == other.mqttHosts;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, coins.hashCode), tradePairs.hashCode), mqttHosts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeConfig')
          ..add('coins', coins)
          ..add('tradePairs', tradePairs)
          ..add('mqttHosts', mqttHosts))
        .toString();
  }
}

class TradeConfigBuilder implements Builder<TradeConfig, TradeConfigBuilder> {
  _$TradeConfig _$v;

  ListBuilder<TradeConfigCoin> _coins;
  ListBuilder<TradeConfigCoin> get coins =>
      _$this._coins ??= new ListBuilder<TradeConfigCoin>();
  set coins(ListBuilder<TradeConfigCoin> coins) => _$this._coins = coins;

  MapBuilder<String, TradeConfigPair> _tradePairs;
  MapBuilder<String, TradeConfigPair> get tradePairs =>
      _$this._tradePairs ??= new MapBuilder<String, TradeConfigPair>();
  set tradePairs(MapBuilder<String, TradeConfigPair> tradePairs) =>
      _$this._tradePairs = tradePairs;

  ListBuilder<String> _mqttHosts;
  ListBuilder<String> get mqttHosts =>
      _$this._mqttHosts ??= new ListBuilder<String>();
  set mqttHosts(ListBuilder<String> mqttHosts) => _$this._mqttHosts = mqttHosts;

  TradeConfigBuilder();

  TradeConfigBuilder get _$this {
    if (_$v != null) {
      _coins = _$v.coins?.toBuilder();
      _tradePairs = _$v.tradePairs?.toBuilder();
      _mqttHosts = _$v.mqttHosts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeConfig;
  }

  @override
  void update(void Function(TradeConfigBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeConfig build() {
    _$TradeConfig _$result;
    try {
      _$result = _$v ??
          new _$TradeConfig._(
              coins: coins.build(),
              tradePairs: tradePairs.build(),
              mqttHosts: mqttHosts.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'coins';
        coins.build();
        _$failedField = 'tradePairs';
        tradePairs.build();
        _$failedField = 'mqttHosts';
        mqttHosts.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeConfig', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeConfigCoin extends TradeConfigCoin {
  @override
  final String chain;
  @override
  final String symbol;
  @override
  final String dealAddress;
  @override
  final String matchAddress;
  @override
  final int matchFee;
  @override
  final int dealPrecision;
  @override
  final double networkFee;
  @override
  final int minBlockHeight;
  @override
  final int maxBlockHeight;
  @override
  final double minAmount;
  @override
  final double maxAmount;

  factory _$TradeConfigCoin([void Function(TradeConfigCoinBuilder) updates]) =>
      (new TradeConfigCoinBuilder()..update(updates)).build();

  _$TradeConfigCoin._(
      {this.chain,
      this.symbol,
      this.dealAddress,
      this.matchAddress,
      this.matchFee,
      this.dealPrecision,
      this.networkFee,
      this.minBlockHeight,
      this.maxBlockHeight,
      this.minAmount,
      this.maxAmount})
      : super._() {
    if (chain == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'chain');
    }
    if (symbol == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'symbol');
    }
    if (matchFee == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'matchFee');
    }
    if (dealPrecision == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'dealPrecision');
    }
    if (networkFee == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'networkFee');
    }
    if (minBlockHeight == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'minBlockHeight');
    }
    if (maxBlockHeight == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'maxBlockHeight');
    }
    if (minAmount == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'minAmount');
    }
    if (maxAmount == null) {
      throw new BuiltValueNullFieldError('TradeConfigCoin', 'maxAmount');
    }
  }

  @override
  TradeConfigCoin rebuild(void Function(TradeConfigCoinBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeConfigCoinBuilder toBuilder() =>
      new TradeConfigCoinBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeConfigCoin &&
        chain == other.chain &&
        symbol == other.symbol &&
        dealAddress == other.dealAddress &&
        matchAddress == other.matchAddress &&
        matchFee == other.matchFee &&
        dealPrecision == other.dealPrecision &&
        networkFee == other.networkFee &&
        minBlockHeight == other.minBlockHeight &&
        maxBlockHeight == other.maxBlockHeight &&
        minAmount == other.minAmount &&
        maxAmount == other.maxAmount;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, chain.hashCode),
                                            symbol.hashCode),
                                        dealAddress.hashCode),
                                    matchAddress.hashCode),
                                matchFee.hashCode),
                            dealPrecision.hashCode),
                        networkFee.hashCode),
                    minBlockHeight.hashCode),
                maxBlockHeight.hashCode),
            minAmount.hashCode),
        maxAmount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeConfigCoin')
          ..add('chain', chain)
          ..add('symbol', symbol)
          ..add('dealAddress', dealAddress)
          ..add('matchAddress', matchAddress)
          ..add('matchFee', matchFee)
          ..add('dealPrecision', dealPrecision)
          ..add('networkFee', networkFee)
          ..add('minBlockHeight', minBlockHeight)
          ..add('maxBlockHeight', maxBlockHeight)
          ..add('minAmount', minAmount)
          ..add('maxAmount', maxAmount))
        .toString();
  }
}

class TradeConfigCoinBuilder
    implements Builder<TradeConfigCoin, TradeConfigCoinBuilder> {
  _$TradeConfigCoin _$v;

  String _chain;
  String get chain => _$this._chain;
  set chain(String chain) => _$this._chain = chain;

  String _symbol;
  String get symbol => _$this._symbol;
  set symbol(String symbol) => _$this._symbol = symbol;

  String _dealAddress;
  String get dealAddress => _$this._dealAddress;
  set dealAddress(String dealAddress) => _$this._dealAddress = dealAddress;

  String _matchAddress;
  String get matchAddress => _$this._matchAddress;
  set matchAddress(String matchAddress) => _$this._matchAddress = matchAddress;

  int _matchFee;
  int get matchFee => _$this._matchFee;
  set matchFee(int matchFee) => _$this._matchFee = matchFee;

  int _dealPrecision;
  int get dealPrecision => _$this._dealPrecision;
  set dealPrecision(int dealPrecision) => _$this._dealPrecision = dealPrecision;

  double _networkFee;
  double get networkFee => _$this._networkFee;
  set networkFee(double networkFee) => _$this._networkFee = networkFee;

  int _minBlockHeight;
  int get minBlockHeight => _$this._minBlockHeight;
  set minBlockHeight(int minBlockHeight) =>
      _$this._minBlockHeight = minBlockHeight;

  int _maxBlockHeight;
  int get maxBlockHeight => _$this._maxBlockHeight;
  set maxBlockHeight(int maxBlockHeight) =>
      _$this._maxBlockHeight = maxBlockHeight;

  double _minAmount;
  double get minAmount => _$this._minAmount;
  set minAmount(double minAmount) => _$this._minAmount = minAmount;

  double _maxAmount;
  double get maxAmount => _$this._maxAmount;
  set maxAmount(double maxAmount) => _$this._maxAmount = maxAmount;

  TradeConfigCoinBuilder();

  TradeConfigCoinBuilder get _$this {
    if (_$v != null) {
      _chain = _$v.chain;
      _symbol = _$v.symbol;
      _dealAddress = _$v.dealAddress;
      _matchAddress = _$v.matchAddress;
      _matchFee = _$v.matchFee;
      _dealPrecision = _$v.dealPrecision;
      _networkFee = _$v.networkFee;
      _minBlockHeight = _$v.minBlockHeight;
      _maxBlockHeight = _$v.maxBlockHeight;
      _minAmount = _$v.minAmount;
      _maxAmount = _$v.maxAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeConfigCoin other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeConfigCoin;
  }

  @override
  void update(void Function(TradeConfigCoinBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeConfigCoin build() {
    final _$result = _$v ??
        new _$TradeConfigCoin._(
            chain: chain,
            symbol: symbol,
            dealAddress: dealAddress,
            matchAddress: matchAddress,
            matchFee: matchFee,
            dealPrecision: dealPrecision,
            networkFee: networkFee,
            minBlockHeight: minBlockHeight,
            maxBlockHeight: maxBlockHeight,
            minAmount: minAmount,
            maxAmount: maxAmount);
    replace(_$result);
    return _$result;
  }
}

class _$TradeConfigPair extends TradeConfigPair {
  @override
  final BuiltMap<String, String> localizedName;
  @override
  final BuiltList<TradeConfigPairItem> pairs;

  factory _$TradeConfigPair([void Function(TradeConfigPairBuilder) updates]) =>
      (new TradeConfigPairBuilder()..update(updates)).build();

  _$TradeConfigPair._({this.localizedName, this.pairs}) : super._() {
    if (localizedName == null) {
      throw new BuiltValueNullFieldError('TradeConfigPair', 'localizedName');
    }
    if (pairs == null) {
      throw new BuiltValueNullFieldError('TradeConfigPair', 'pairs');
    }
  }

  @override
  TradeConfigPair rebuild(void Function(TradeConfigPairBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeConfigPairBuilder toBuilder() =>
      new TradeConfigPairBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeConfigPair &&
        localizedName == other.localizedName &&
        pairs == other.pairs;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, localizedName.hashCode), pairs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeConfigPair')
          ..add('localizedName', localizedName)
          ..add('pairs', pairs))
        .toString();
  }
}

class TradeConfigPairBuilder
    implements Builder<TradeConfigPair, TradeConfigPairBuilder> {
  _$TradeConfigPair _$v;

  MapBuilder<String, String> _localizedName;
  MapBuilder<String, String> get localizedName =>
      _$this._localizedName ??= new MapBuilder<String, String>();
  set localizedName(MapBuilder<String, String> localizedName) =>
      _$this._localizedName = localizedName;

  ListBuilder<TradeConfigPairItem> _pairs;
  ListBuilder<TradeConfigPairItem> get pairs =>
      _$this._pairs ??= new ListBuilder<TradeConfigPairItem>();
  set pairs(ListBuilder<TradeConfigPairItem> pairs) => _$this._pairs = pairs;

  TradeConfigPairBuilder();

  TradeConfigPairBuilder get _$this {
    if (_$v != null) {
      _localizedName = _$v.localizedName?.toBuilder();
      _pairs = _$v.pairs?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeConfigPair other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeConfigPair;
  }

  @override
  void update(void Function(TradeConfigPairBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeConfigPair build() {
    _$TradeConfigPair _$result;
    try {
      _$result = _$v ??
          new _$TradeConfigPair._(
              localizedName: localizedName.build(), pairs: pairs.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'localizedName';
        localizedName.build();
        _$failedField = 'pairs';
        pairs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeConfigPair', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeConfigPairItem extends TradeConfigPairItem {
  @override
  final String id;
  @override
  final String name;
  @override
  final String speed;
  @override
  final BuiltList<String> spans;
  @override
  final String status;
  @override
  final TradeConfigPairItemInfo price;
  @override
  final TradeConfigPairItemInfo trade;

  factory _$TradeConfigPairItem(
          [void Function(TradeConfigPairItemBuilder) updates]) =>
      (new TradeConfigPairItemBuilder()..update(updates)).build();

  _$TradeConfigPairItem._(
      {this.id,
      this.name,
      this.speed,
      this.spans,
      this.status,
      this.price,
      this.trade})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItem', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItem', 'name');
    }
    if (speed == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItem', 'speed');
    }
    if (spans == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItem', 'spans');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItem', 'price');
    }
    if (trade == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItem', 'trade');
    }
  }

  @override
  TradeConfigPairItem rebuild(
          void Function(TradeConfigPairItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeConfigPairItemBuilder toBuilder() =>
      new TradeConfigPairItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeConfigPairItem &&
        id == other.id &&
        name == other.name &&
        speed == other.speed &&
        spans == other.spans &&
        status == other.status &&
        price == other.price &&
        trade == other.trade;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), name.hashCode),
                        speed.hashCode),
                    spans.hashCode),
                status.hashCode),
            price.hashCode),
        trade.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeConfigPairItem')
          ..add('id', id)
          ..add('name', name)
          ..add('speed', speed)
          ..add('spans', spans)
          ..add('status', status)
          ..add('price', price)
          ..add('trade', trade))
        .toString();
  }
}

class TradeConfigPairItemBuilder
    implements Builder<TradeConfigPairItem, TradeConfigPairItemBuilder> {
  _$TradeConfigPairItem _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _speed;
  String get speed => _$this._speed;
  set speed(String speed) => _$this._speed = speed;

  ListBuilder<String> _spans;
  ListBuilder<String> get spans => _$this._spans ??= new ListBuilder<String>();
  set spans(ListBuilder<String> spans) => _$this._spans = spans;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  TradeConfigPairItemInfoBuilder _price;
  TradeConfigPairItemInfoBuilder get price =>
      _$this._price ??= new TradeConfigPairItemInfoBuilder();
  set price(TradeConfigPairItemInfoBuilder price) => _$this._price = price;

  TradeConfigPairItemInfoBuilder _trade;
  TradeConfigPairItemInfoBuilder get trade =>
      _$this._trade ??= new TradeConfigPairItemInfoBuilder();
  set trade(TradeConfigPairItemInfoBuilder trade) => _$this._trade = trade;

  TradeConfigPairItemBuilder();

  TradeConfigPairItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _speed = _$v.speed;
      _spans = _$v.spans?.toBuilder();
      _status = _$v.status;
      _price = _$v.price?.toBuilder();
      _trade = _$v.trade?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeConfigPairItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeConfigPairItem;
  }

  @override
  void update(void Function(TradeConfigPairItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeConfigPairItem build() {
    _$TradeConfigPairItem _$result;
    try {
      _$result = _$v ??
          new _$TradeConfigPairItem._(
              id: id,
              name: name,
              speed: speed,
              spans: spans.build(),
              status: status,
              price: price.build(),
              trade: trade.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'spans';
        spans.build();

        _$failedField = 'price';
        price.build();
        _$failedField = 'trade';
        trade.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeConfigPairItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeConfigPairItemInfo extends TradeConfigPairItemInfo {
  @override
  final String chain;
  @override
  final String symbol;

  factory _$TradeConfigPairItemInfo(
          [void Function(TradeConfigPairItemInfoBuilder) updates]) =>
      (new TradeConfigPairItemInfoBuilder()..update(updates)).build();

  _$TradeConfigPairItemInfo._({this.chain, this.symbol}) : super._() {
    if (chain == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItemInfo', 'chain');
    }
    if (symbol == null) {
      throw new BuiltValueNullFieldError('TradeConfigPairItemInfo', 'symbol');
    }
  }

  @override
  TradeConfigPairItemInfo rebuild(
          void Function(TradeConfigPairItemInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeConfigPairItemInfoBuilder toBuilder() =>
      new TradeConfigPairItemInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeConfigPairItemInfo &&
        chain == other.chain &&
        symbol == other.symbol;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, chain.hashCode), symbol.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeConfigPairItemInfo')
          ..add('chain', chain)
          ..add('symbol', symbol))
        .toString();
  }
}

class TradeConfigPairItemInfoBuilder
    implements
        Builder<TradeConfigPairItemInfo, TradeConfigPairItemInfoBuilder> {
  _$TradeConfigPairItemInfo _$v;

  String _chain;
  String get chain => _$this._chain;
  set chain(String chain) => _$this._chain = chain;

  String _symbol;
  String get symbol => _$this._symbol;
  set symbol(String symbol) => _$this._symbol = symbol;

  TradeConfigPairItemInfoBuilder();

  TradeConfigPairItemInfoBuilder get _$this {
    if (_$v != null) {
      _chain = _$v.chain;
      _symbol = _$v.symbol;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeConfigPairItemInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeConfigPairItemInfo;
  }

  @override
  void update(void Function(TradeConfigPairItemInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeConfigPairItemInfo build() {
    final _$result =
        _$v ?? new _$TradeConfigPairItemInfo._(chain: chain, symbol: symbol);
    replace(_$result);
    return _$result;
  }
}

class _$TradeMarket extends TradeMarket {
  @override
  final String id;
  @override
  final BuiltMap<String, String> names;

  factory _$TradeMarket([void Function(TradeMarketBuilder) updates]) =>
      (new TradeMarketBuilder()..update(updates)).build();

  _$TradeMarket._({this.id, this.names}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TradeMarket', 'id');
    }
    if (names == null) {
      throw new BuiltValueNullFieldError('TradeMarket', 'names');
    }
  }

  @override
  TradeMarket rebuild(void Function(TradeMarketBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeMarketBuilder toBuilder() => new TradeMarketBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeMarket && id == other.id && names == other.names;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), names.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeMarket')
          ..add('id', id)
          ..add('names', names))
        .toString();
  }
}

class TradeMarketBuilder implements Builder<TradeMarket, TradeMarketBuilder> {
  _$TradeMarket _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  MapBuilder<String, String> _names;
  MapBuilder<String, String> get names =>
      _$this._names ??= new MapBuilder<String, String>();
  set names(MapBuilder<String, String> names) => _$this._names = names;

  TradeMarketBuilder();

  TradeMarketBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _names = _$v.names?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeMarket other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeMarket;
  }

  @override
  void update(void Function(TradeMarketBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeMarket build() {
    _$TradeMarket _$result;
    try {
      _$result = _$v ?? new _$TradeMarket._(id: id, names: names.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'names';
        names.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeMarket', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeDeal extends TradeDeal {
  @override
  final int tradeSideId;
  @override
  final String tradePairId;
  @override
  final String price;
  @override
  final String amount;
  @override
  final int createdAt;

  factory _$TradeDeal([void Function(TradeDealBuilder) updates]) =>
      (new TradeDealBuilder()..update(updates)).build();

  _$TradeDeal._(
      {this.tradeSideId,
      this.tradePairId,
      this.price,
      this.amount,
      this.createdAt})
      : super._() {
    if (tradeSideId == null) {
      throw new BuiltValueNullFieldError('TradeDeal', 'tradeSideId');
    }
    if (tradePairId == null) {
      throw new BuiltValueNullFieldError('TradeDeal', 'tradePairId');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('TradeDeal', 'price');
    }
    if (amount == null) {
      throw new BuiltValueNullFieldError('TradeDeal', 'amount');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('TradeDeal', 'createdAt');
    }
  }

  @override
  TradeDeal rebuild(void Function(TradeDealBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeDealBuilder toBuilder() => new TradeDealBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeDeal &&
        tradeSideId == other.tradeSideId &&
        tradePairId == other.tradePairId &&
        price == other.price &&
        amount == other.amount &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, tradeSideId.hashCode), tradePairId.hashCode),
                price.hashCode),
            amount.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeDeal')
          ..add('tradeSideId', tradeSideId)
          ..add('tradePairId', tradePairId)
          ..add('price', price)
          ..add('amount', amount)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class TradeDealBuilder implements Builder<TradeDeal, TradeDealBuilder> {
  _$TradeDeal _$v;

  int _tradeSideId;
  int get tradeSideId => _$this._tradeSideId;
  set tradeSideId(int tradeSideId) => _$this._tradeSideId = tradeSideId;

  String _tradePairId;
  String get tradePairId => _$this._tradePairId;
  set tradePairId(String tradePairId) => _$this._tradePairId = tradePairId;

  String _price;
  String get price => _$this._price;
  set price(String price) => _$this._price = price;

  String _amount;
  String get amount => _$this._amount;
  set amount(String amount) => _$this._amount = amount;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  TradeDealBuilder();

  TradeDealBuilder get _$this {
    if (_$v != null) {
      _tradeSideId = _$v.tradeSideId;
      _tradePairId = _$v.tradePairId;
      _price = _$v.price;
      _amount = _$v.amount;
      _createdAt = _$v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeDeal other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeDeal;
  }

  @override
  void update(void Function(TradeDealBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeDeal build() {
    final _$result = _$v ??
        new _$TradeDeal._(
            tradeSideId: tradeSideId,
            tradePairId: tradePairId,
            price: price,
            amount: amount,
            createdAt: createdAt);
    replace(_$result);
    return _$result;
  }
}

class _$TradeOrderDetail extends TradeOrderDetail {
  @override
  final String total;
  @override
  final BuiltList<TradeOrderDetailItem> matchList;
  @override
  final BuiltList<TradeOrderDetailItem> exchangeList;

  factory _$TradeOrderDetail(
          [void Function(TradeOrderDetailBuilder) updates]) =>
      (new TradeOrderDetailBuilder()..update(updates)).build();

  _$TradeOrderDetail._({this.total, this.matchList, this.exchangeList})
      : super._();

  @override
  TradeOrderDetail rebuild(void Function(TradeOrderDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeOrderDetailBuilder toBuilder() =>
      new TradeOrderDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeOrderDetail &&
        total == other.total &&
        matchList == other.matchList &&
        exchangeList == other.exchangeList;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, total.hashCode), matchList.hashCode),
        exchangeList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeOrderDetail')
          ..add('total', total)
          ..add('matchList', matchList)
          ..add('exchangeList', exchangeList))
        .toString();
  }
}

class TradeOrderDetailBuilder
    implements Builder<TradeOrderDetail, TradeOrderDetailBuilder> {
  _$TradeOrderDetail _$v;

  String _total;
  String get total => _$this._total;
  set total(String total) => _$this._total = total;

  ListBuilder<TradeOrderDetailItem> _matchList;
  ListBuilder<TradeOrderDetailItem> get matchList =>
      _$this._matchList ??= new ListBuilder<TradeOrderDetailItem>();
  set matchList(ListBuilder<TradeOrderDetailItem> matchList) =>
      _$this._matchList = matchList;

  ListBuilder<TradeOrderDetailItem> _exchangeList;
  ListBuilder<TradeOrderDetailItem> get exchangeList =>
      _$this._exchangeList ??= new ListBuilder<TradeOrderDetailItem>();
  set exchangeList(ListBuilder<TradeOrderDetailItem> exchangeList) =>
      _$this._exchangeList = exchangeList;

  TradeOrderDetailBuilder();

  TradeOrderDetailBuilder get _$this {
    if (_$v != null) {
      _total = _$v.total;
      _matchList = _$v.matchList?.toBuilder();
      _exchangeList = _$v.exchangeList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeOrderDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeOrderDetail;
  }

  @override
  void update(void Function(TradeOrderDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeOrderDetail build() {
    _$TradeOrderDetail _$result;
    try {
      _$result = _$v ??
          new _$TradeOrderDetail._(
              total: total,
              matchList: _matchList?.build(),
              exchangeList: _exchangeList?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'matchList';
        _matchList?.build();
        _$failedField = 'exchangeList';
        _exchangeList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeOrderDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeOrderDetailItem extends TradeOrderDetailItem {
  @override
  final String matchPrice;
  @override
  final String amount;
  @override
  final int createdAt;
  @override
  final String fee;
  @override
  final String txId;
  @override
  final String matchId;

  factory _$TradeOrderDetailItem(
          [void Function(TradeOrderDetailItemBuilder) updates]) =>
      (new TradeOrderDetailItemBuilder()..update(updates)).build();

  _$TradeOrderDetailItem._(
      {this.matchPrice,
      this.amount,
      this.createdAt,
      this.fee,
      this.txId,
      this.matchId})
      : super._();

  @override
  TradeOrderDetailItem rebuild(
          void Function(TradeOrderDetailItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeOrderDetailItemBuilder toBuilder() =>
      new TradeOrderDetailItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeOrderDetailItem &&
        matchPrice == other.matchPrice &&
        amount == other.amount &&
        createdAt == other.createdAt &&
        fee == other.fee &&
        txId == other.txId &&
        matchId == other.matchId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, matchPrice.hashCode), amount.hashCode),
                    createdAt.hashCode),
                fee.hashCode),
            txId.hashCode),
        matchId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeOrderDetailItem')
          ..add('matchPrice', matchPrice)
          ..add('amount', amount)
          ..add('createdAt', createdAt)
          ..add('fee', fee)
          ..add('txId', txId)
          ..add('matchId', matchId))
        .toString();
  }
}

class TradeOrderDetailItemBuilder
    implements Builder<TradeOrderDetailItem, TradeOrderDetailItemBuilder> {
  _$TradeOrderDetailItem _$v;

  String _matchPrice;
  String get matchPrice => _$this._matchPrice;
  set matchPrice(String matchPrice) => _$this._matchPrice = matchPrice;

  String _amount;
  String get amount => _$this._amount;
  set amount(String amount) => _$this._amount = amount;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  String _fee;
  String get fee => _$this._fee;
  set fee(String fee) => _$this._fee = fee;

  String _txId;
  String get txId => _$this._txId;
  set txId(String txId) => _$this._txId = txId;

  String _matchId;
  String get matchId => _$this._matchId;
  set matchId(String matchId) => _$this._matchId = matchId;

  TradeOrderDetailItemBuilder();

  TradeOrderDetailItemBuilder get _$this {
    if (_$v != null) {
      _matchPrice = _$v.matchPrice;
      _amount = _$v.amount;
      _createdAt = _$v.createdAt;
      _fee = _$v.fee;
      _txId = _$v.txId;
      _matchId = _$v.matchId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeOrderDetailItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeOrderDetailItem;
  }

  @override
  void update(void Function(TradeOrderDetailItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeOrderDetailItem build() {
    final _$result = _$v ??
        new _$TradeOrderDetailItem._(
            matchPrice: matchPrice,
            amount: amount,
            createdAt: createdAt,
            fee: fee,
            txId: txId,
            matchId: matchId);
    replace(_$result);
    return _$result;
  }
}

class _$TradePair extends TradePair {
  @override
  final String id;
  @override
  final String name;
  @override
  final String speed;
  @override
  final BuiltList<String> spans;
  @override
  final String apiStatus;
  @override
  final String marketId;
  @override
  final String tradeName;
  @override
  final String tradeChain;
  @override
  final String tradeSymbol;
  @override
  final String priceName;
  @override
  final String priceChain;
  @override
  final String priceSymbol;

  factory _$TradePair([void Function(TradePairBuilder) updates]) =>
      (new TradePairBuilder()..update(updates)).build();

  _$TradePair._(
      {this.id,
      this.name,
      this.speed,
      this.spans,
      this.apiStatus,
      this.marketId,
      this.tradeName,
      this.tradeChain,
      this.tradeSymbol,
      this.priceName,
      this.priceChain,
      this.priceSymbol})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TradePair', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TradePair', 'name');
    }
    if (speed == null) {
      throw new BuiltValueNullFieldError('TradePair', 'speed');
    }
    if (spans == null) {
      throw new BuiltValueNullFieldError('TradePair', 'spans');
    }
    if (apiStatus == null) {
      throw new BuiltValueNullFieldError('TradePair', 'apiStatus');
    }
    if (marketId == null) {
      throw new BuiltValueNullFieldError('TradePair', 'marketId');
    }
    if (tradeName == null) {
      throw new BuiltValueNullFieldError('TradePair', 'tradeName');
    }
    if (tradeChain == null) {
      throw new BuiltValueNullFieldError('TradePair', 'tradeChain');
    }
    if (tradeSymbol == null) {
      throw new BuiltValueNullFieldError('TradePair', 'tradeSymbol');
    }
    if (priceName == null) {
      throw new BuiltValueNullFieldError('TradePair', 'priceName');
    }
    if (priceChain == null) {
      throw new BuiltValueNullFieldError('TradePair', 'priceChain');
    }
    if (priceSymbol == null) {
      throw new BuiltValueNullFieldError('TradePair', 'priceSymbol');
    }
  }

  @override
  TradePair rebuild(void Function(TradePairBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradePairBuilder toBuilder() => new TradePairBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradePair &&
        id == other.id &&
        name == other.name &&
        speed == other.speed &&
        spans == other.spans &&
        apiStatus == other.apiStatus &&
        marketId == other.marketId &&
        tradeName == other.tradeName &&
        tradeChain == other.tradeChain &&
        tradeSymbol == other.tradeSymbol &&
        priceName == other.priceName &&
        priceChain == other.priceChain &&
        priceSymbol == other.priceSymbol;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, id.hashCode),
                                                name.hashCode),
                                            speed.hashCode),
                                        spans.hashCode),
                                    apiStatus.hashCode),
                                marketId.hashCode),
                            tradeName.hashCode),
                        tradeChain.hashCode),
                    tradeSymbol.hashCode),
                priceName.hashCode),
            priceChain.hashCode),
        priceSymbol.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradePair')
          ..add('id', id)
          ..add('name', name)
          ..add('speed', speed)
          ..add('spans', spans)
          ..add('apiStatus', apiStatus)
          ..add('marketId', marketId)
          ..add('tradeName', tradeName)
          ..add('tradeChain', tradeChain)
          ..add('tradeSymbol', tradeSymbol)
          ..add('priceName', priceName)
          ..add('priceChain', priceChain)
          ..add('priceSymbol', priceSymbol))
        .toString();
  }
}

class TradePairBuilder implements Builder<TradePair, TradePairBuilder> {
  _$TradePair _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _speed;
  String get speed => _$this._speed;
  set speed(String speed) => _$this._speed = speed;

  ListBuilder<String> _spans;
  ListBuilder<String> get spans => _$this._spans ??= new ListBuilder<String>();
  set spans(ListBuilder<String> spans) => _$this._spans = spans;

  String _apiStatus;
  String get apiStatus => _$this._apiStatus;
  set apiStatus(String apiStatus) => _$this._apiStatus = apiStatus;

  String _marketId;
  String get marketId => _$this._marketId;
  set marketId(String marketId) => _$this._marketId = marketId;

  String _tradeName;
  String get tradeName => _$this._tradeName;
  set tradeName(String tradeName) => _$this._tradeName = tradeName;

  String _tradeChain;
  String get tradeChain => _$this._tradeChain;
  set tradeChain(String tradeChain) => _$this._tradeChain = tradeChain;

  String _tradeSymbol;
  String get tradeSymbol => _$this._tradeSymbol;
  set tradeSymbol(String tradeSymbol) => _$this._tradeSymbol = tradeSymbol;

  String _priceName;
  String get priceName => _$this._priceName;
  set priceName(String priceName) => _$this._priceName = priceName;

  String _priceChain;
  String get priceChain => _$this._priceChain;
  set priceChain(String priceChain) => _$this._priceChain = priceChain;

  String _priceSymbol;
  String get priceSymbol => _$this._priceSymbol;
  set priceSymbol(String priceSymbol) => _$this._priceSymbol = priceSymbol;

  TradePairBuilder();

  TradePairBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _speed = _$v.speed;
      _spans = _$v.spans?.toBuilder();
      _apiStatus = _$v.apiStatus;
      _marketId = _$v.marketId;
      _tradeName = _$v.tradeName;
      _tradeChain = _$v.tradeChain;
      _tradeSymbol = _$v.tradeSymbol;
      _priceName = _$v.priceName;
      _priceChain = _$v.priceChain;
      _priceSymbol = _$v.priceSymbol;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradePair other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradePair;
  }

  @override
  void update(void Function(TradePairBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradePair build() {
    _$TradePair _$result;
    try {
      _$result = _$v ??
          new _$TradePair._(
              id: id,
              name: name,
              speed: speed,
              spans: spans.build(),
              apiStatus: apiStatus,
              marketId: marketId,
              tradeName: tradeName,
              tradeChain: tradeChain,
              tradeSymbol: tradeSymbol,
              priceName: priceName,
              priceChain: priceChain,
              priceSymbol: priceSymbol);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'spans';
        spans.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradePair', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TradeInfo24h extends TradeInfo24h {
  @override
  final String high;
  @override
  final String low;
  @override
  final String vol;

  factory _$TradeInfo24h([void Function(TradeInfo24hBuilder) updates]) =>
      (new TradeInfo24hBuilder()..update(updates)).build();

  _$TradeInfo24h._({this.high, this.low, this.vol}) : super._();

  @override
  TradeInfo24h rebuild(void Function(TradeInfo24hBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeInfo24hBuilder toBuilder() => new TradeInfo24hBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeInfo24h &&
        high == other.high &&
        low == other.low &&
        vol == other.vol;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, high.hashCode), low.hashCode), vol.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeInfo24h')
          ..add('high', high)
          ..add('low', low)
          ..add('vol', vol))
        .toString();
  }
}

class TradeInfo24hBuilder
    implements Builder<TradeInfo24h, TradeInfo24hBuilder> {
  _$TradeInfo24h _$v;

  String _high;
  String get high => _$this._high;
  set high(String high) => _$this._high = high;

  String _low;
  String get low => _$this._low;
  set low(String low) => _$this._low = low;

  String _vol;
  String get vol => _$this._vol;
  set vol(String vol) => _$this._vol = vol;

  TradeInfo24hBuilder();

  TradeInfo24hBuilder get _$this {
    if (_$v != null) {
      _high = _$v.high;
      _low = _$v.low;
      _vol = _$v.vol;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeInfo24h other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeInfo24h;
  }

  @override
  void update(void Function(TradeInfo24hBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeInfo24h build() {
    final _$result =
        _$v ?? new _$TradeInfo24h._(high: high, low: low, vol: vol);
    replace(_$result);
    return _$result;
  }
}

class _$TradeTicker extends TradeTicker {
  @override
  final int tradeSideId;
  @override
  final String tradePairId;
  @override
  final String price;
  @override
  final double amount;

  factory _$TradeTicker([void Function(TradeTickerBuilder) updates]) =>
      (new TradeTickerBuilder()..update(updates)).build();

  _$TradeTicker._({this.tradeSideId, this.tradePairId, this.price, this.amount})
      : super._() {
    if (tradeSideId == null) {
      throw new BuiltValueNullFieldError('TradeTicker', 'tradeSideId');
    }
    if (tradePairId == null) {
      throw new BuiltValueNullFieldError('TradeTicker', 'tradePairId');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('TradeTicker', 'price');
    }
    if (amount == null) {
      throw new BuiltValueNullFieldError('TradeTicker', 'amount');
    }
  }

  @override
  TradeTicker rebuild(void Function(TradeTickerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeTickerBuilder toBuilder() => new TradeTickerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeTicker &&
        tradeSideId == other.tradeSideId &&
        tradePairId == other.tradePairId &&
        price == other.price &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, tradeSideId.hashCode), tradePairId.hashCode),
            price.hashCode),
        amount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeTicker')
          ..add('tradeSideId', tradeSideId)
          ..add('tradePairId', tradePairId)
          ..add('price', price)
          ..add('amount', amount))
        .toString();
  }
}

class TradeTickerBuilder implements Builder<TradeTicker, TradeTickerBuilder> {
  _$TradeTicker _$v;

  int _tradeSideId;
  int get tradeSideId => _$this._tradeSideId;
  set tradeSideId(int tradeSideId) => _$this._tradeSideId = tradeSideId;

  String _tradePairId;
  String get tradePairId => _$this._tradePairId;
  set tradePairId(String tradePairId) => _$this._tradePairId = tradePairId;

  String _price;
  String get price => _$this._price;
  set price(String price) => _$this._price = price;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  TradeTickerBuilder();

  TradeTickerBuilder get _$this {
    if (_$v != null) {
      _tradeSideId = _$v.tradeSideId;
      _tradePairId = _$v.tradePairId;
      _price = _$v.price;
      _amount = _$v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeTicker other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeTicker;
  }

  @override
  void update(void Function(TradeTickerBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeTicker build() {
    final _$result = _$v ??
        new _$TradeTicker._(
            tradeSideId: tradeSideId,
            tradePairId: tradePairId,
            price: price,
            amount: amount);
    replace(_$result);
    return _$result;
  }
}

class _$TradeState extends TradeState {
  @override
  final TradeConfig config;
  @override
  final int configState;
  @override
  final TradePair tradePair;
  @override
  final TradeSide tradeSide;
  @override
  final BuiltList<String> hideSlowTradePairTip;
  @override
  final TradeOrderDetail currentOrderDetail;

  factory _$TradeState([void Function(TradeStateBuilder) updates]) =>
      (new TradeStateBuilder()..update(updates)).build();

  _$TradeState._(
      {this.config,
      this.configState,
      this.tradePair,
      this.tradeSide,
      this.hideSlowTradePairTip,
      this.currentOrderDetail})
      : super._() {
    if (tradeSide == null) {
      throw new BuiltValueNullFieldError('TradeState', 'tradeSide');
    }
    if (hideSlowTradePairTip == null) {
      throw new BuiltValueNullFieldError('TradeState', 'hideSlowTradePairTip');
    }
  }

  @override
  TradeState rebuild(void Function(TradeStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeStateBuilder toBuilder() => new TradeStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeState &&
        config == other.config &&
        configState == other.configState &&
        tradePair == other.tradePair &&
        tradeSide == other.tradeSide &&
        hideSlowTradePairTip == other.hideSlowTradePairTip &&
        currentOrderDetail == other.currentOrderDetail;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, config.hashCode), configState.hashCode),
                    tradePair.hashCode),
                tradeSide.hashCode),
            hideSlowTradePairTip.hashCode),
        currentOrderDetail.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TradeState')
          ..add('config', config)
          ..add('configState', configState)
          ..add('tradePair', tradePair)
          ..add('tradeSide', tradeSide)
          ..add('hideSlowTradePairTip', hideSlowTradePairTip)
          ..add('currentOrderDetail', currentOrderDetail))
        .toString();
  }
}

class TradeStateBuilder implements Builder<TradeState, TradeStateBuilder> {
  _$TradeState _$v;

  TradeConfigBuilder _config;
  TradeConfigBuilder get config => _$this._config ??= new TradeConfigBuilder();
  set config(TradeConfigBuilder config) => _$this._config = config;

  int _configState;
  int get configState => _$this._configState;
  set configState(int configState) => _$this._configState = configState;

  TradePairBuilder _tradePair;
  TradePairBuilder get tradePair =>
      _$this._tradePair ??= new TradePairBuilder();
  set tradePair(TradePairBuilder tradePair) => _$this._tradePair = tradePair;

  TradeSide _tradeSide;
  TradeSide get tradeSide => _$this._tradeSide;
  set tradeSide(TradeSide tradeSide) => _$this._tradeSide = tradeSide;

  ListBuilder<String> _hideSlowTradePairTip;
  ListBuilder<String> get hideSlowTradePairTip =>
      _$this._hideSlowTradePairTip ??= new ListBuilder<String>();
  set hideSlowTradePairTip(ListBuilder<String> hideSlowTradePairTip) =>
      _$this._hideSlowTradePairTip = hideSlowTradePairTip;

  TradeOrderDetailBuilder _currentOrderDetail;
  TradeOrderDetailBuilder get currentOrderDetail =>
      _$this._currentOrderDetail ??= new TradeOrderDetailBuilder();
  set currentOrderDetail(TradeOrderDetailBuilder currentOrderDetail) =>
      _$this._currentOrderDetail = currentOrderDetail;

  TradeStateBuilder();

  TradeStateBuilder get _$this {
    if (_$v != null) {
      _config = _$v.config?.toBuilder();
      _configState = _$v.configState;
      _tradePair = _$v.tradePair?.toBuilder();
      _tradeSide = _$v.tradeSide;
      _hideSlowTradePairTip = _$v.hideSlowTradePairTip?.toBuilder();
      _currentOrderDetail = _$v.currentOrderDetail?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TradeState;
  }

  @override
  void update(void Function(TradeStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TradeState build() {
    _$TradeState _$result;
    try {
      _$result = _$v ??
          new _$TradeState._(
              config: _config?.build(),
              configState: configState,
              tradePair: _tradePair?.build(),
              tradeSide: tradeSide,
              hideSlowTradePairTip: hideSlowTradePairTip.build(),
              currentOrderDetail: _currentOrderDetail?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();

        _$failedField = 'tradePair';
        _tradePair?.build();

        _$failedField = 'hideSlowTradePairTip';
        hideSlowTradePairTip.build();
        _$failedField = 'currentOrderDetail';
        _currentOrderDetail?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TradeState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TradeOrderStatusAdapter extends TypeAdapter<TradeOrderStatus> {
  @override
  final int typeId = 31;

  @override
  TradeOrderStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TradeOrderStatus.confirming;
      case 1:
        return TradeOrderStatus.pending;
      case 2:
        return TradeOrderStatus.traded;
      case 3:
        return TradeOrderStatus.partialCancel;
      case 4:
        return TradeOrderStatus.cancelled;
      case 5:
        return TradeOrderStatus.dusts;
      case 6:
        return TradeOrderStatus.cancelling;
      case 7:
        return TradeOrderStatus.failed;
      case 8:
        return TradeOrderStatus.matchFailed;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, TradeOrderStatus obj) {
    switch (obj) {
      case TradeOrderStatus.confirming:
        writer.writeByte(0);
        break;
      case TradeOrderStatus.pending:
        writer.writeByte(1);
        break;
      case TradeOrderStatus.traded:
        writer.writeByte(2);
        break;
      case TradeOrderStatus.partialCancel:
        writer.writeByte(3);
        break;
      case TradeOrderStatus.cancelled:
        writer.writeByte(4);
        break;
      case TradeOrderStatus.dusts:
        writer.writeByte(5);
        break;
      case TradeOrderStatus.cancelling:
        writer.writeByte(6);
        break;
      case TradeOrderStatus.failed:
        writer.writeByte(7);
        break;
      case TradeOrderStatus.matchFailed:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradeOrderStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TradeOrderAdapter extends TypeAdapter<TradeOrder> {
  @override
  final int typeId = 30;

  @override
  TradeOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TradeOrder()
      ..txId = fields[0] as String
      ..chain = fields[1] as String
      ..symbol = fields[2] as String
      ..priceSymbol = fields[3] as String
      ..tradeSymbol = fields[4] as String
      ..tradeSideId = fields[5] as int
      ..tradePairId = fields[6] as String
      ..confirmations = fields[7] as int
      ..validHeight = fields[8] as int
      ..currentHeight = fields[9] as int
      ..submitAt = fields[10] as int
      ..confirmedAt = fields[11] as int
      ..tradedAt = fields[12] as int
      ..cancelAt = fields[13] as int
      ..cancelTxId = fields[14] as String
      ..templateAddress = fields[15] as String
      ..templateHex = fields[16] as String
      ..fromAddress = fields[17] as String
      ..matchAddress = fields[18] as String
      ..dealAddress = fields[19] as String
      ..price = fields[20] as double
      ..avgPrice = fields[21] as double
      ..remaining = fields[22] as double
      ..amount = fields[23] as double
      ..filled = fields[24] as double
      ..total = fields[25] as double
      ..dealAmount = fields[26] as double
      ..withdrawAmount = fields[30] as double
      ..networkFee = fields[27] as double
      ..matchFee = fields[28] as int
      ..feeSymbol = fields[29] as String
      ..status = fields[40] as TradeOrderStatus
      ..type = fields[41] as String;
  }

  @override
  void write(BinaryWriter writer, TradeOrder obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.txId)
      ..writeByte(1)
      ..write(obj.chain)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.priceSymbol)
      ..writeByte(4)
      ..write(obj.tradeSymbol)
      ..writeByte(5)
      ..write(obj.tradeSideId)
      ..writeByte(6)
      ..write(obj.tradePairId)
      ..writeByte(7)
      ..write(obj.confirmations)
      ..writeByte(8)
      ..write(obj.validHeight)
      ..writeByte(9)
      ..write(obj.currentHeight)
      ..writeByte(10)
      ..write(obj.submitAt)
      ..writeByte(11)
      ..write(obj.confirmedAt)
      ..writeByte(12)
      ..write(obj.tradedAt)
      ..writeByte(13)
      ..write(obj.cancelAt)
      ..writeByte(14)
      ..write(obj.cancelTxId)
      ..writeByte(15)
      ..write(obj.templateAddress)
      ..writeByte(16)
      ..write(obj.templateHex)
      ..writeByte(17)
      ..write(obj.fromAddress)
      ..writeByte(18)
      ..write(obj.matchAddress)
      ..writeByte(19)
      ..write(obj.dealAddress)
      ..writeByte(20)
      ..write(obj.price)
      ..writeByte(21)
      ..write(obj.avgPrice)
      ..writeByte(22)
      ..write(obj.remaining)
      ..writeByte(23)
      ..write(obj.amount)
      ..writeByte(24)
      ..write(obj.filled)
      ..writeByte(25)
      ..write(obj.total)
      ..writeByte(26)
      ..write(obj.dealAmount)
      ..writeByte(30)
      ..write(obj.withdrawAmount)
      ..writeByte(27)
      ..write(obj.networkFee)
      ..writeByte(28)
      ..write(obj.matchFee)
      ..writeByte(29)
      ..write(obj.feeSymbol)
      ..writeByte(40)
      ..write(obj.status)
      ..writeByte(41)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradeOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TradePreferenceAdapter extends TypeAdapter<TradePreference> {
  @override
  final int typeId = 32;

  @override
  TradePreference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TradePreference()
      ..tradePairSpan = (fields[1] as Map)?.cast<String, String>()
      ..tradePairResolution = (fields[2] as Map)?.cast<String, String>();
  }

  @override
  void write(BinaryWriter writer, TradePreference obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.tradePairSpan)
      ..writeByte(2)
      ..write(obj.tradePairResolution);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradePreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
