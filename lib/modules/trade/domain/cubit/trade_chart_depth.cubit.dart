part of trade_domain_module;

class TradeChartDepthState {
  TradeChartDepthState({
    @required this.tradePair,
    @required this.bids,
    @required this.asks,
  });
  final TradePair tradePair;
  final List<DepthEntity> bids;
  final List<DepthEntity> asks;
}

class TradeChartDepthCubit extends Cubit<TradeChartDepthState> {
  TradeChartDepthCubit([TradeRepository tradeRepository])
      : super(TradeChartDepthState(
          tradePair: null,
          bids: [],
          asks: [],
        )) {
    _tradeRepository = tradeRepository ?? TradeRepository();
  }

  TradeRepository _tradeRepository;

  Stream<Map<String, List<DepthEntity>>> byTradePair(String tradePairId) =>
      map((event) => {
            'bids': event.bids,
            'asks': event.asks,
          });

  // ▼▼▼▼▼▼ Update/Load Data ▼▼▼▼▼▼  //

  Future<void> loadData({
    @required TradePair tradePair,
    StreamController<bool> chartLoadingStream,
  }) async {
    chartLoadingStream?.add(true);
    try {
      if (state.tradePair?.id != tradePair?.id) {
        emit(TradeChartDepthState(
          tradePair: tradePair,
          bids: [],
          asks: [],
        ));
      }

      final data =
          await _tradeRepository.getChartDepths(tradePairId: tradePair.id);

      emit(TradeChartDepthState(
        tradePair: null,
        bids: data['bids'],
        asks: data['asks'],
      ));
      if (chartLoadingStream?.isClosed == false) {
        chartLoadingStream?.add(false);
      }
    } catch (e) {
      if (chartLoadingStream?.isClosed == false) {
        chartLoadingStream?.add(false);
      }
    }
  }

  void clearData() {
    emit(TradeChartDepthState(
      tradePair: null,
      bids: [],
      asks: [],
    ));
  }

  /// Reload current cubit data, using state last TradePair
  Future<void> reloadCurrent() {
    return loadData(
      tradePair: state.tradePair,
    );
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqtt({
    @required Map<String, dynamic> json,
  }) async {
    // TODO: wait api
  }
}
