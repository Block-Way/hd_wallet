part of trade_domain_module;

abstract class TradeOrdersCubit extends Cubit<List<TradeOrder>> {
  TradeOrdersCubit([TradeRepository? repository]) : super([]) {
    tradeRepository = repository ?? TradeRepository();
  }

  late TradeRepository tradeRepository;

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
  });
}
