part of trade_domain_module;

class TradeInfo24hState {
  TradeInfo24hState({
    required this.tradePair,
    required this.data,
  });

  final TradePair tradePair;
  final TradeInfo24h data;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is TradeInfo24hState && o.tradePair == tradePair && o.data == data;
  }

  @override
  int get hashCode => tradePair.hashCode ^ data.hashCode;
}

class TradeInfo24hCubit extends Cubit<TradeInfo24hState> {
  TradeInfo24hCubit([TradeRepository? tradeRepository])
      : super(TradeInfo24hState(
          tradePair: TradePair(),
          data: TradeInfo24h(),
        )) {
    _tradeRepository = tradeRepository ?? TradeRepository();
  }

  late TradeRepository _tradeRepository;

  // ▼▼▼▼▼▼ Update/Load Data ▼▼▼▼▼▼  //

  Future<void> loadData(TradePair tradePair) async {
    if (state.tradePair.id != tradePair.id) {
      emit(
        TradeInfo24hState(
          tradePair: tradePair,
          data: TradeInfo24h(),
        ),
      );
    }

    final data = await _tradeRepository.getTradePairInfo24H(
      tradePairId: tradePair.id,
    );

    emit(TradeInfo24hState(
      tradePair: tradePair,
      data: data,
    ));
  }

  void clearData() {
    emit(TradeInfo24hState(
      tradePair: TradePair(),
      data: TradeInfo24h(),
    ));
  }

  /// Reload current cubit data, using state last TradePair
  Future<void> reloadCurrent() {
    return loadData(state.tradePair);
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqtt({
    required Map<String, dynamic> json,
  }) async {
    // TODO: wait api
  }
}
