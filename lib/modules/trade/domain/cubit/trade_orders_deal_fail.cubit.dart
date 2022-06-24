part of trade_domain_module;

class TradeOrdersDealFailCubit extends TradeOrdersCubit {
  TradeOrdersDealFailCubit([TradeRepository? tradeRepository])
      : super(tradeRepository ?? TradeRepository()) {
    _tradeRepository = tradeRepository ?? TradeRepository();
  }

  late TradeRepository _tradeRepository;

  @override
  Future<int> loadAll({
    required String walletId,
    required String tradePairId,
    required String tradeAddress,
    required String priceAddress,
    required int skip,
    required int take,
    required String tradeSide,
    required String status,
    required bool onlyCache,
  }) async {
    if (onlyCache == true) {
      return state.length;
    }

    final length = await refreshData(walletId, tradePairId);
    return length;
  }

  Future<int> refreshData(String walletId, [String? tradePairId]) async {
    final list = await _tradeRepository.getOrdersDealFail(
      walletId: walletId,
      tradePairId: tradePairId ?? '',
    );

    // 不显示 已处理的记录
    final record = await _tradeRepository.getTradeFaiOrderBroadcasts(walletId);
    final txIds = record.map((e) => e.txId).toList();
    list.removeWhere((e) => txIds.contains(e.txId));

    emit(list);
    return list.length;
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit([]);
    super.onError(error, stackTrace);
  }
}
