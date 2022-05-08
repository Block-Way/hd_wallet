part of trade_domain_module;

class TradeDealsState {
  TradeDealsState({
    @required this.tradePair,
    @required this.data,
  });

  final TradePair tradePair;
  final List<TradeDeal> data;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is TradeDealsState &&
        o.tradePair == tradePair &&
        listEquals(o.data, data);
  }

  @override
  int get hashCode => tradePair.hashCode ^ data.hashCode;
}

class TradeDealsCubit extends Cubit<TradeDealsState> {
  TradeDealsCubit([TradeRepository tradeRepository])
      : super(TradeDealsState(
          tradePair: null,
          data: [],
        )) {
    _tradeRepository = tradeRepository ?? TradeRepository();
  }

  TradeRepository _tradeRepository;

  List<TradeDeal> byTradePair({
    @required List<TradeDeal> data,
    @required String tradePairId,
  }) =>
      data.where((element) => element.tradePairId == tradePairId).toList();

  // ▼▼▼▼▼▼ Update/Load Data ▼▼▼▼▼▼  //

  /// Update all newest from api
  Future<void> loadData(TradePair tradePair) async {
    if (state.tradePair?.id != tradePair?.id) {
      emit(TradeDealsState(
        tradePair: tradePair,
        data: [],
      ));
    }

    final deals = await _tradeRepository.getTradePairDeals(
      tradePairId: tradePair.id,
    );

    emit(TradeDealsState(
      tradePair: tradePair,
      data: deals,
    ));
  }

  void clearData() {
    emit(TradeDealsState(
      tradePair: null,
      data: [],
    ));
  }

  /// Reload current cubit data, using state last TradePair
  Future<void> reloadCurrent() {
    return loadData(state.tradePair);
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqtt({
    @required Map<String, dynamic> json,
  }) async {
    // TODO: wait api
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
