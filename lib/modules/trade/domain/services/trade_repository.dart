part of trade_domain_module;

class TradeRepository {
  factory TradeRepository([TradeApi? _api]) {
    _instance._api = _api ?? TradeApi();
    return _instance;
  }
  TradeRepository._internal();

  static final _instance = TradeRepository._internal();

  late TradeApi _api;
  late Map<String, int> kLineLimit;
  late LazyBox<List<dynamic>> _tradeOrders;
  late Box<TradePreference> _tradePreference;

  static const _tradeOrdersCacheKey = 'trade_orders_v1';
  static const _tradePreferenceCacheKey = 'trade_preference_v2';

  Future<void> initializeCache() async {
    _tradeOrders = await AppHiveCache.openLazyBox<List<dynamic>>(
      _tradeOrdersCacheKey,
    );

    _tradePreference = await AppHiveCache.openBox<TradePreference>(
      _tradePreferenceCacheKey,
    );
    if (_tradePreference.get(_tradePreferenceCacheKey) == null) {
      await _tradePreference.put(_tradePreferenceCacheKey, TradePreference());
    }
  }

  /// ***  Configs *** ///

  TradePreference getPreference() {
    final preferences = _tradePreference.get(_tradePreferenceCacheKey);
    preferences!.tradePairSpan = preferences.tradePairSpan;
    preferences.tradePairResolution = preferences.tradePairResolution;
    return preferences;
  }

  Future<TradeConfig?> getConfig() async {
    //final json = await _api.getConfig();
    final json = {'currency': [], 'coin_pair': {}, 'mqtt': []};
    return TradeConfig.fromJson(json);
  }

  /// ***  Info *** ///

  Future<List<TradeTicker>> getTradePairTickers({
    required String tradePairId,
    required String span,
    int count = 10,
  }) async {
    return [];
    /* 没有人买卖
    final json = await _api.getTradePairTickers(
      tradePairId: tradePairId,
      count: count,
      span: span,
    );
    final rawBids = json['BUY'] is List
        ? <String, String>{}
        : Map<String, String>.from(json['BUY'] as Map<String, dynamic>);

    final rawAsks = json['SALE'] is List
        ? <String, String>{}
        : Map<String, String>.from(json['SALE'] as Map<String, dynamic>);

    final bids = rawBids.entries.map((e) => TradeTicker.fromApi(
          tradePairId: tradePairId,
          tradeSideId: TradeSide.buy.index,
          price: e.key,
          amount: e.value,
        ));
    final asks = rawAsks.entries.map((e) => TradeTicker.fromApi(
          tradePairId: tradePairId,
          tradeSideId: TradeSide.sell.index,
          price: e.key,
          amount: e.value,
        ));

    return [...asks, ...bids];
    */
  }

  Future<List<TradeDeal>> getTradePairDeals({
    required String tradePairId,
    int count = 10,
  }) async {
    return [];
    /* 没有人买卖
    final json = await _api.getTradePairDeals(
      tradePairId: tradePairId,
      count: count,
    );
    return json
        .map(
          (e) => TradeDeal.fromApi(tradePairId, json: e),
        )
        .toList();
        */
  }

  Future<TradeInfo24h> getTradePairInfo24H({
    required String tradePairId,
  }) async {
    /* final json = await _api.getTradePairInfo24H(
      tradePairId: tradePairId,
    );*/
    return TradeInfo24h();
  }

  /// ***  Orders *** ///

  Future<List<TradeOrder>> getTradeOrdersFromCache({
    required String walletId,
    String? tradePairId,
    String tradeSide = 'all',
  }) async {
    return [];
    /*
    try {
      final list = await _tradeOrders.get(
        walletId,
        defaultValue: [],
      );
      final cachedOrders = list.cast<TradeOrder>();
      // Show data from cache while waiting to data from API

      if (tradePairId != null) {
        cachedOrders.retainWhere(
          (element) => element.tradePairId == tradePairId,
        );
      }

      if (tradeSide != 'all') {
        cachedOrders.retainWhere(
          (element) =>
              element.tradeSide ==
              (tradeSide == 'buy' ? TradeSide.buy : TradeSide.sell),
        );
      }

      cachedOrders.sort((a, b) {
        return b.displayTime - a.displayTime;
      });

      return cachedOrders;
    } catch (_) {
      return [];
    }*/
  }

  Future<void> clearTradeOrdersCache(
    String walletId,
  ) async {
    return;
  }

  Future<List<TradeOrder>> getOrdersAll({
    required String tradePairId,
    required String recordType,
    required String type,
    required String tradeSide,
    required String tradeAddress,
    required String priceAddress,
    required String walletId,
    int skip = 0,
    int take = 10,
    String? orderBy,
  }) async {
    return [];
    /*
    // failed order 不从接口请求，只从cache
    final onlyFailOrder = type == 'failed';
    final isHistory = type == 'history';

    final List<Map<String, dynamic>> emptyList = [];

    final json = onlyFailOrder
        ? emptyList
        : await _api.getOrdersAll(
            type: type,
            recordType: recordType,
            tradeSide: tradeSide,
            tradePairId: tradePairId == 'all' ? 'ALL' : tradePairId,
            tradePairAddress:
                tradeAddress == 'all' ? 'ALL' : '$tradeAddress-$priceAddress',
            skip: skip,
            take: take,
            walletId: walletId,
            orderBy: orderBy != null && orderBy.isNotEmpty
                ? '?order_by=$orderBy'
                : '',
          );

    // Get cached orders
    final cachedOrders = await getTradeOrdersFromCache(
      walletId: walletId,
    );

    if (onlyFailOrder) {
      cachedOrders
          .retainWhere((item) => item.status == TradeOrderStatus.failed);
      return cachedOrders;
    }

    final apiOrders = json
        .map((item) => TradeOrder.fromApi(
              cached: cachedOrders.firstWhere(
                (element) => element.txId == item['tx'],
                orElse: () => null,
              ),
              json: item,
            ))
        .toList();

    // Update local cached
    final ids = apiOrders.map((e) => e.txId).toSet();
    cachedOrders.retainWhere((x) => !ids.contains(x.txId ?? ''));
    cachedOrders.addAll(apiOrders);

    await saveTradeOrdersToCache(
      walletId,
      cachedOrders,
    );

    // 历史记录 全部
    if (isHistory) {
      cachedOrders
          .retainWhere((item) => item.status == TradeOrderStatus.failed);
      apiOrders.addAll(cachedOrders);
      apiOrders
          .sort((a, b) => (b.displayTime ?? 0).compareTo(a.displayTime ?? 0));
    }

    return apiOrders;
    */
  }

  Future<List<TradeOrder>> getOrdersDealFail({
    required String tradePairId,
    required String walletId,
  }) async {
    return [];
    /*
    final json = await _api.getOrdersDealFail(
      walletId: walletId,
      tradePairId: tradePairId,
    );
    final list = json.map((e) => TradeOrder.fromDealFailApi(e)).toList();
    return list;
    */
  }

  Future<void> saveTradeOrdersToCache(
    String walletId,
    List<TradeOrder> tradeOrders,
  ) async {
    return;
    /*
    await _tradeOrders.put(
      walletId,
      tradeOrders,
    );*/
  }

  Future<TradeOrderDetail> getOrderDetail({
    required String txId,
    required String walletId,
  }) async {
    /*
    final json = await _api.getOrderDetail(
      walletId: walletId,
      txId: txId,
    );*/
    return TradeOrderDetail();
  }

  /// Return order info (like status, new data) from TxId
  Future<TradeOrder> getTradeOrderInfo({
    required String txId,
    required String walletId,
  }) async {
    return TradeOrder();
    /*
    final json = await _api.getOrderDetail(
      walletId: walletId,
      txId: txId,
    );

    final cachedOrders = await getTradeOrdersFromCache(
      walletId: walletId,
    );

    return TradeOrder.fromApi(
      cached: cachedOrders.firstWhere(
        (element) => element.txId == json['tx'],
        orElse: () => null,
      ),
      json: json,
    );*/
  }

  Future<WalletTemplateData?> getOrderTemplateInfo({
    required String chain,
    required int chainPrecision,
    required String templateAddress,
    required String walletId,
  }) async {
    return null;
    /*
    final json = await _api.getOrderTemplateInfo(
      address: templateAddress,
      walletId: walletId,
    );
    return WalletTemplateData(
      chain: chain,
      symbol: chain,
      templateHex: json['template_hex'].toString(),
      templateData: json,
      templateAddress: templateAddress,
    );*/
  }

  Future<List<BroadcastTxInfo>> getTradeFaiOrderBroadcasts(
    String walletId,
  ) async {
    return [];
    /*
    final allBroadcasts = await WalletRepository().getBroadcastsFromCache(
      walletId,
    );

    return allBroadcasts
        .where((item) => item.type == BroadcastTxType.tradeFailOrder
            // item.isSubmitted == false, 记录里的都不显示
            )
        .toList();
        */
  }

  Future<List<String>> getOrderCancelledIds({
    String? txId,
    String? walletId,
  }) async {
    return [];
    /*
    return _api.getOrderCancelledIds(
      walletId: walletId,
      txId: txId,
    );*/
  }

  Future<void> postOrderDealFail({
    required String txId,
    required String template,
    required String walletId,
  }) async {
    /*
    return _api.postOrderDealFail(
      txId: txId,
      template: template,
      walletId: walletId,
    );*/
  }

  /// ***  Chart *** ///

  Future<List<KLineEntity>> getChartKLine(
    ResolutionItem? resolution,
    String? tradePairId,
    int? precision,
  ) async {
    return [];
    /*
    if (kLineLimit == null || kLineLimit.isEmpty) {
      final json = await _api.getKLineLimit();
      kLineLimit = json.cast<String, int>();
    }

    final chartRawData = await TradeApi().getKLineData(
      resolution: resolution.id,
      tradePairId: tradePairId,
      limit: kLineLimit[resolution.key],
    );

    final data = chartRawData.map((item) {
      return {
        'id': item['_id'],
        'count': item['count'],
        'amount': item['amount'],
        'vol': item['vol'],
        'high': NumberUtil.getIntAmountAsDouble(item['high'], precision),
        'open': NumberUtil.getIntAmountAsDouble(item['open'], precision),
        'close': NumberUtil.getIntAmountAsDouble(item['close'], precision),
        'low': NumberUtil.getIntAmountAsDouble(item['low'], precision),
      };
    }).toList();

    final chartData = data
        .map((item) => KLineEntity.fromJson(item))
        .toList()
        .cast<KLineEntity>();
    chartData.sort((a, b) => a.id.compareTo(b.id));
    DataUtil.calculate(chartData);

    return chartData;
    */
  }

  Future<Map<String, List<DepthEntity>>> getChartDepths({
    required String tradePairId,
  }) async {
    return {};
    /*
    final result = await _api.getTradePairTickers(
      tradePairId: tradePairId,
      count: 100,
      span: '0.000001',
    );

    try {
      final rawBids = result['BUY'] is List
          ? <String, String>{}
          : Map<String, String>.from(result['BUY'] as Map<String, dynamic>);

      final rawAsks = result['SALE'] is List
          ? <String, String>{}
          : Map<String, String>.from(result['SALE'] as Map<String, dynamic>);

      final bids = rawBids.entries
          .map((e) => DepthEntity(
              NumberUtil.getDouble(e.key), NumberUtil.getDouble(e.value)))
          .toList();
      final asks = rawAsks.entries
          .map((e) => DepthEntity(
              NumberUtil.getDouble(e.key), NumberUtil.getDouble(e.value)))
          .toList();

      List<DepthEntity> _bids = <DepthEntity>[];
      List<DepthEntity> _asks = <DepthEntity>[];
      double amount = 0.0;
      bids?.sort((left, right) => left.price.compareTo(right.price));
      //倒序循环 //累加买入委托量
      for (final item in bids.reversed) {
        amount = NumberUtil.plus<double>(amount, item.amount);
        item.amount = amount;
        _bids.insert(0, item);
      }

      amount = 0.0;
      asks?.sort((left, right) => left.price.compareTo(right.price));
      //循环 //累加买入委托量
      if (asks.isNotEmpty) {
        for (final item in asks) {
          amount = NumberUtil.plus<double>(amount, item.amount);
          item.amount = amount;
          _asks.add(item);
        }
      }

      // 处理数据
      if (_bids.isEmpty && _asks.isEmpty) {
        _bids = [DepthEntity(0, 0)];
        _asks = [DepthEntity(0, 0)];
      }

      if (_bids.isEmpty && _asks.isNotEmpty) {
        _bids = [
          DepthEntity(NumberUtil.minus<double>(_asks.first.price, 0.1), 0)
        ];
      }

      if (_asks.isEmpty && _bids.isNotEmpty) {
        _asks = [
          DepthEntity(NumberUtil.plus<double>(_bids.last.price, 0.1), 0)
        ];
      }

      final centerPrice =
          NumberUtil.plus<double>(_bids.last.price, _asks.first.price) / 2;

      if (centerPrice != _bids.last.price && centerPrice != _asks.first.price) {
        _bids = [
          ..._bids,
          DepthEntity(NumberUtil.plus<double>(_bids.last.price, 0.01), 0),
          DepthEntity(centerPrice, 0)
        ];
        _asks = [
          DepthEntity(centerPrice, 0),
          DepthEntity(NumberUtil.minus<double>(_asks.first.price, 0.01), 0),
          ..._asks
        ];
      }

      return {'bids': _bids, 'asks': _asks};
    } catch (error) {
      return {'bids': [], 'asks': []};
    }
    */
  }
}
