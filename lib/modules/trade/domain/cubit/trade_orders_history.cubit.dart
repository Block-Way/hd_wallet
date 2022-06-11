part of trade_domain_module;

class TradeOrdersHistoryCubit extends TradeOrdersCubit {
  TradeOrdersHistoryCubit([TradeRepository? tradeRepository])
      : super(tradeRepository) {
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
      if (skip == 0) {
        emit([]);
      }
      return state.length;
    }

    final apiOrders = await _tradeRepository.getOrdersAll(
      skip: skip,
      take: take,
      type: status,
      walletId: walletId,
      tradeSide: tradeSide,
      recordType: 'record',
      tradePairId: tradePairId,
      tradeAddress: tradeAddress,
      priceAddress: priceAddress,
    );
    final result = skip > 0 ? [...state, ...apiOrders] : [...apiOrders];

    emit(result);

    return result.length;
  }
}
