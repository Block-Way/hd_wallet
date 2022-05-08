part of trade_domain_module;

class TradeTickersState {
  TradeTickersState({
    @required this.span,
    @required this.tradePair,
    @required this.tickers,
  });

  final String span;
  final TradePair tradePair;
  final List<TradeTicker> tickers;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is TradeTickersState &&
        o.span == span &&
        o.tradePair == tradePair &&
        listEquals(o.tickers, tickers);
  }

  @override
  int get hashCode => tradePair.hashCode ^ tickers.hashCode ^ span.hashCode;
}

class TradeTickersCubit extends Cubit<TradeTickersState> {
  TradeTickersCubit([TradeRepository tradeRepository])
      : super(TradeTickersState(
          tickers: [],
          tradePair: null,
          span: '0',
        )) {
    _tradeRepository = tradeRepository ?? TradeRepository();
  }

  TradeRepository _tradeRepository;

  String get latestBuyPrice {
    final tickers = state.tickers
        .where((element) => element.tradeSideId == TradeSide.buy.index)
        .toList();
    tickers.sort((a, b) => b.price.compareTo(a.price));
    return tickers.isNotEmpty ? tickers.first.price?.toString() ?? '' : '';
  }

  String get latestSellPrice {
    final tickers = state.tickers
        .where((element) => element.tradeSideId == TradeSide.sell.index)
        .toList();
    tickers.sort((a, b) => a.price.compareTo(b.price));
    return tickers.isNotEmpty ? tickers.first.price?.toString() ?? '' : '';
  }

  MapEntry<double, List<TradeTicker>> byTradePair(
    String tradePairId,
    int tradeSideId,
  ) {
    // Calculate max amount
    double maxAmount = 0;
    final amountList = state.tickers.map((e) => e.amount).toList();
    if (amountList.length > 1) {
      maxAmount = NumberUtil.plus<double>(
        amountList.reduce(math.min),
        amountList.reduce(math.max),
      );
    }
    final list = state.tickers
        .where(
          (element) =>
              element.tradeSideId == tradeSideId &&
              element.tradePairId == tradePairId &&
              element.amount > 0,
        )
        .toList();
    list.sort(
      (a, b) => tradeSideId == TradeSide.buy.index
          ? b.price.compareTo(a.price)
          : a.price.compareTo(b.price),
    );
    return MapEntry(maxAmount, list);
  }

  // ▼▼▼▼▼▼ Utility ▼▼▼▼▼▼  //

  String getSpan(TradePair tradePair) {
    final preference = _tradeRepository.getPreference();
    final span = preference.tradePairSpan.containsKey(tradePair.id)
        ? preference.tradePairSpan[tradePair.id]
        : tradePair.spans.isEmpty
            ? '0'
            : tradePair.spans.first;
    return span;
  }

  Future<void> changeSpan(String span) async {
    final preference = _tradeRepository.getPreference();
    preference.tradePairSpan.update(
      state.tradePair.id,
      (_) => span,
      ifAbsent: () => span,
    );
    await preference.save();
    return loadData(state.tradePair);
  }

  // ▼▼▼▼▼▼ Update/Load Data ▼▼▼▼▼▼  //

  /// Update all tickers from api
  Future<void> loadData(TradePair tradePair) async {
    final span = getSpan(tradePair);
    if (state.tradePair?.id != tradePair?.id) {
      emit(TradeTickersState(
        tickers: [],
        tradePair: tradePair,
        span: span,
      ));
    }

    final tickers = await _tradeRepository.getTradePairTickers(
      tradePairId: tradePair.id,
      span: span,
    );

    emit(TradeTickersState(
      tickers: tickers,
      tradePair: tradePair,
      span: span,
    ));
  }

  void clearData() {
    emit(TradeTickersState(
      tickers: [],
      tradePair: null,
      span: state.span,
    ));
  }

  /// Reload current cubit data, using state last TradePair
  Future<void> reloadCurrent() {
    return loadData(state.tradePair);
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqttAmount({
    @required String tradePairId,
    @required Map<String, dynamic> json,
  }) async {
    if (tradePairId != state.tradePair?.id) {
      return;
    }

    final newTicker = TradeTicker.fromMqtt(json: json, span: state.span);

    final duplicateIndex = state.tickers.indexWhere(
      (element) =>
          NumberUtil.getDouble(element.price) ==
              NumberUtil.getDouble(newTicker.price) &&
          element.tradeSideId == newTicker.tradeSideId,
    );

    if (duplicateIndex != -1) {
      state.tickers.replaceRange(
        duplicateIndex,
        duplicateIndex + 1,
        [
          state.tickers[duplicateIndex].rebuild(
            (a) =>
                a..amount = NumberUtil.plus<double>(a.amount, newTicker.amount),
          )
        ],
      );
      emit(TradeTickersState(
        tickers: state.tickers,
        tradePair: state.tradePair,
        span: state.span,
      ));
    } else {
      emit(TradeTickersState(
        tickers: [...state.tickers, newTicker],
        tradePair: state.tradePair,
        span: state.span,
      ));
    }
  }

  /// When a price change, we need to remove a
  /// certain amount from the depth amount
  Future<void> updateFromMqttPrice({
    @required TradePair tradePair,
    @required Map<String, dynamic> json,
  }) async {
    if (tradePair == null || state.tradePair?.id != tradePair?.id) {
      return;
    }

    dev.log('[UpdateFromPriceMqtt]: $json');

    final buyPrice = NumberUtil.getIntAmountAsDouble(
      json['buy_order_price'],
      10,
    );
    final buyAmount = NumberUtil.getDouble(json['buy_deep']);
    final sellPrice = NumberUtil.getIntAmountAsDouble(
      json['sale_order_price'],
      10,
    );
    final sellAmount = NumberUtil.getDouble(json['sale_deep']);

    final buyIndex = state.tickers.indexWhere((element) =>
        NumberUtil.getDouble(element.price) == buyPrice &&
        element.tradeSideId == TradeSide.buy.index);

    if (buyIndex != -1) {
      state.tickers.replaceRange(
        buyIndex,
        buyIndex + 1,
        [
          state.tickers[buyIndex].rebuild(
            (a) => a..amount = NumberUtil.minus<double>(a.amount, buyAmount),
          )
        ],
      );
    }

    final sellIndex = state.tickers.indexWhere((element) =>
        NumberUtil.getDouble(element.price) == sellPrice &&
        element.tradeSideId == TradeSide.sell.index);

    if (sellIndex != -1) {
      state.tickers.replaceRange(
        sellIndex,
        sellIndex + 1,
        [
          state.tickers[sellIndex].rebuild(
            (a) => a..amount = NumberUtil.minus<double>(a.amount, sellAmount),
          )
        ],
      );
    }

    emit(TradeTickersState(
      tickers: state.tickers,
      tradePair: state.tradePair,
      span: state.span,
    ));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
