part of trade_domain_module;

class TradeChartKLineState {
  TradeChartKLineState({
    required this.resolution,
    required this.tradePairId,
    required this.data,
  });
  final ResolutionItem resolution;
  final String tradePairId;
  final List<KLineEntity> data;
}

class TradeChartKLineCubit extends Cubit<TradeChartKLineState> {
  TradeChartKLineCubit([TradeRepository? tradeRepository])
      : super(
          TradeChartKLineState(
            data: [],
            resolution: ResolutionItem(),
            tradePairId: '',
          ),
        ) {
    _tradeRepository = tradeRepository ?? TradeRepository();
  }

  late TradeRepository _tradeRepository;

  // ▼▼▼▼▼▼ Utility ▼▼▼▼▼▼  //
  /*
  Stream<List<KLineEntity>> byTradePair(String tradePairId) => map(
        (event) => event.data,
      );
  */
  ResolutionItem getResolution(String tradePairId) {
    final preference = _tradeRepository.getPreference();
    final resolution = preference.tradePairResolution.containsKey(tradePairId)
        ? kChartResolutions.firstWhere(
            (e) => e.id == preference.tradePairResolution[tradePairId],
            orElse: () => kChartResolutions.first,
          )
        : kChartResolutions.first;
    return resolution;
  }

  Future<void> changeResolution(ResolutionItem resolution) async {
    /*
    final preference = _tradeRepository.getPreference();
    preference.tradePairResolution.update(
      state.tradePairId,
      (_) => resolution.id,
      ifAbsent: () => resolution.id,
    );
    await preference.save();
    emit(TradeChartKLineState(
      data: [],
      resolution: resolution,
      tradePairId: state.tradePairId,
    ));*/
  }

  // ▼▼▼▼▼▼ Update/Load Data ▼▼▼▼▼▼  //

  Future<void> loadData({
    required String tradePairId,
    required ResolutionItem resolution,
    StreamController<bool>? chartLoadingStream,
    bool? isMqtt,
  }) async {
    chartLoadingStream?.add(true);
    try {
      if (state.tradePairId != tradePairId) {
        emit(TradeChartKLineState(
          data: [],
          resolution: resolution,
          tradePairId: tradePairId,
        ));
      }

      final data = await _tradeRepository.getChartKLine(
        resolution,
        tradePairId,
        10,
      );
      if (isMqtt == true) {
        final existingIds = state.data.map((e) => e.id).toList();
        final remoteData = data;
        remoteData.retainWhere((element) => !existingIds.contains(element.id));
        if (remoteData.isNotEmpty) {
          state.data.addAll(remoteData);
          state.data.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
          emit(state);
        }
      } else {
        emit(TradeChartKLineState(
          data: data,
          resolution: resolution,
          tradePairId: tradePairId,
        ));
      }

      if (chartLoadingStream?.isClosed == false) {
        chartLoadingStream?.add(false);
      }
    } catch (e) {
      if (chartLoadingStream?.isClosed == false) {
        chartLoadingStream?.add(false);
      }
      rethrow;
    }
  }

  void clearData() {
    emit(TradeChartKLineState(
      data: [],
      resolution: ResolutionItem(),
      tradePairId: '',
    ));
  }

  /// Reload current cubit data, using state last TradePair
  Future<void> reloadCurrent() {
    return loadData(
      resolution: state.resolution,
      tradePairId: state.tradePairId,
      isMqtt: true,
    );
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqtt({
    required Map<String, dynamic> json,
  }) async {
    // TODO: wait api
  }
}
