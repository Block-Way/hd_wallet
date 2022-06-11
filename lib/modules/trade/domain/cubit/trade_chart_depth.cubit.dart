part of trade_domain_module;

class TradeChartDepthState {
  TradeChartDepthState({
    required this.tradePair,
    required this.bids,
    required this.asks,
  });
  final TradePair tradePair;
  final List<DepthEntity> bids;
  final List<DepthEntity> asks;
}

class TradeChartDepthCubit extends Cubit<TradeChartDepthState> {
  TradeChartDepthCubit([TradeRepository? tradeRepository])
      : super(
          TradeChartDepthState(
            tradePair: TradePair(),
            bids: [],
            asks: [],
          ),
        ) {
    _tradeRepository = tradeRepository ?? TradeRepository();
  }

  late TradeRepository _tradeRepository;
  /*
  Stream<Map<String, List<DepthEntity>>> byTradePair(String tradePairId) =>
      map((event) => {
            'bids': 0,
            'asks': 0,
          });
  */
  // ▼▼▼▼▼▼ Update/Load Data ▼▼▼▼▼▼  //

  Future<void> loadData({
    required TradePair tradePair,
    StreamController<bool>? chartLoadingStream,
  }) async {
    chartLoadingStream?.add(true);
    try {
      if (state.tradePair.id != tradePair.id) {
        emit(
          TradeChartDepthState(
            tradePair: tradePair,
            bids: [],
            asks: [],
          ),
        );
      }

      final data =
          await _tradeRepository.getChartDepths(tradePairId: tradePair.id);

      emit(
        TradeChartDepthState(
          tradePair: TradePair(),
          bids: [],
          asks: [],
        ),
      );
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
    emit(
      TradeChartDepthState(
        tradePair: TradePair(),
        bids: [],
        asks: [],
      ),
    );
  }

  /// Reload current cubit data, using state last TradePair
  Future<void> reloadCurrent() {
    return loadData(
      tradePair: state.tradePair,
    );
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqtt({
    required Map<String, dynamic> json,
  }) async {
    // TODO: wait api
  }
}
