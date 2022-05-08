part of trade_domain_module;

class TradeOrdersPendingCubit extends TradeOrdersCubit {
  TradeOrdersPendingCubit([TradeRepository tradeRepository])
      : super(tradeRepository);

  // ▼▼▼▼▼▼ Update/Load Data ▼▼▼▼▼▼  //

  Future<void> loadPendingOrdersFromCache({
    @required String walletId,
    @required String tradePairId,
  }) async {
    // First emit cached orders
    final cachedOrders = await tradeRepository.getTradeOrdersFromCache(
      walletId: walletId,
      tradePairId: tradePairId,
    );
    cachedOrders.retainWhere(
      (element) => element.isHistory == false,
    );

    emit(cachedOrders);
  }

  Future<void> loadData({
    @required String walletId,
    @required String tradePairId,
    @required String tradeAddress,
    @required String priceAddress,
  }) async {
    if (walletId == null || walletId.isEmpty) {
      return;
    }

    // First emit cached orders
    await loadPendingOrdersFromCache(
      walletId: walletId,
      tradePairId: tradePairId,
    );

    await tradeRepository.getOrdersAll(
      recordType: 'record_for_home',
      walletId: walletId,
      type: TradeOrderApiStatus.all,
      tradePairId: tradePairId,
      tradeAddress: tradeAddress ?? 'all',
      priceAddress: priceAddress ?? 'all',
      take: 50,
      tradeSide: 'all',
      orderBy: 'latest_deal',
    );

    final cachedAndApiOrders = await tradeRepository.getTradeOrdersFromCache(
      walletId: walletId,
    );
    cachedAndApiOrders.retainWhere(
      (element) =>
          element.tradePairId == tradePairId && element.isHistory == false,
    );
    emit(cachedAndApiOrders);
  }

  @override
  Future<int> loadAll({
    @required String walletId,
    @required String tradePairId,
    @required String tradeAddress,
    @required String priceAddress,
    @required int skip,
    @required int take,
    @required String tradeSide,
    @required String status,
    @required bool onlyCache,
  }) async {
    if (walletId == null || walletId.isEmpty) {
      return 0;
    }

    // First emit cached orders
    final cachedOrders = await tradeRepository.getTradeOrdersFromCache(
      walletId: walletId,
      tradeSide: tradeSide,
      tradePairId: tradePairId,
    );

    if (onlyCache == true) {
      if (skip == 0) {
        cachedOrders.retainWhere((e) => e.isHistory == false);
        emit(cachedOrders);
      }
      return cachedOrders.length;
    }

    if (skip == 0) {
      // Check and remove cancelling orders
      final cancellingTxid = cachedOrders
          .where((element) => element.isCancelling)
          .toList()
          .map((e) => e.txId)
          .join(',');

      if (cancellingTxid != '') {
        final cancelledTxIdList = await tradeRepository.getOrderCancelledIds(
          walletId: walletId,
          txId: cancellingTxid,
        );
        for (final item in cancelledTxIdList) {
          cachedOrders.removeWhere((element) {
            return element.txId == item;
          });
        }
        await tradeRepository.saveTradeOrdersToCache(
          walletId,
          cachedOrders,
        );
        emit(cachedOrders);
      }
    }

    final apiOrders = await tradeRepository.getOrdersAll(
      recordType: 'record',
      walletId: walletId,
      type: TradeOrderApiStatus.pending,
      tradePairId: tradePairId ?? 'all',
      tradeAddress: tradeAddress ?? 'all',
      priceAddress: priceAddress ?? 'all',
      skip: skip,
      take: take,
      tradeSide: tradeSide,
    );

    List<TradeOrder> result = [];

    final newCacheOrders = await tradeRepository.getTradeOrdersFromCache(
      walletId: walletId,
      tradePairId: tradePairId,
      tradeSide: tradeSide,
    );
    cachedOrders.retainWhere((e) => e.isHistory == false);

    if (skip == 0) {
      // If first page add the local confirming and cancelling items
      result = apiOrders +
          newCacheOrders
              .where((element) => element.isConfirming || element.isCancelling)
              .toList();
    } else {
      // For load more page use state + api result
      result = state + apiOrders;
    }

    result.sort((a, b) {
      return b.displayTime - a.displayTime;
    });

    final ids = result.map((e) => e.txId).toSet();
    result.retainWhere((x) => ids.remove(x.txId ?? ''));

    emit(result);

    return apiOrders.length;
  }

  void clearData() {
    emit([]);
  }

  /// Add/Update a ticker from mqtt
  Future<void> updateFromMqtt({
    @required String txId,
    @required String tradePairId,
    @required String walletId,
  }) async {
    // if (tradePairId != state.tradePair?.id) {
    //   return;
    // }

    if (walletId == null || walletId.isEmpty) {
      return;
    }

    final cachedOrders = await tradeRepository.getTradeOrdersFromCache(
      walletId: walletId,
    );

    final localOrderIndex = cachedOrders.indexWhere(
      (element) => element.txId == txId,
    );

    if (localOrderIndex != -1) {
      final newOrder = await tradeRepository.getTradeOrderInfo(
        txId: txId,
        walletId: walletId,
      );
      cachedOrders.replaceRange(
        localOrderIndex,
        localOrderIndex + 1,
        [newOrder],
      );
      await tradeRepository.saveTradeOrdersToCache(walletId, cachedOrders);

      final stateOrderIndex = state.indexWhere(
        (element) => element.txId == txId,
      );
      if (stateOrderIndex != -1) {
        state.replaceRange(
          stateOrderIndex,
          stateOrderIndex + 1,
          [newOrder],
        );

        state.retainWhere((element) => !element.isHistory);

        emit([...state]);
      }
    }
  }
}
