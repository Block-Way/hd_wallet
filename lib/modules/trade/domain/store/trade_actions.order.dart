part of trade_domain_module;

class TradeActionOrderAddPending extends _BaseAction {
  TradeActionOrderAddPending(this.order);
  final TradeOrder order;

  @override
  Future<AppState> reduce() async {
    final walletId = store.state.walletState.activeWalletId;

    final cachedOrders = await TradeRepository().getTradeOrdersFromCache(
      walletId: walletId,
    );

    cachedOrders.add(order);

    await TradeRepository().saveTradeOrdersToCache(
      walletId,
      cachedOrders,
    );

    return null;
  }
}

class TradeActionOrderAddCancelling extends _BaseAction {
  TradeActionOrderAddCancelling(
    this.order,
    this.cancelTxId,
  );
  final TradeOrder order;
  final String cancelTxId;

  @override
  Future<AppState> reduce() async {
    final walletId = store.state.walletState.activeWalletId;

    final cachedOrders = await TradeRepository().getTradeOrdersFromCache(
      walletId: walletId,
    );

    final cached = cachedOrders.firstWhere(
      (item) => item.txId == order.txId,
      orElse: () => null,
    );

    if (cached != null) {
      cached.status = TradeOrderStatus.cancelling;
      cached.cancelTxId = cancelTxId;

      await TradeRepository().saveTradeOrdersToCache(
        walletId,
        cachedOrders,
      );
    }

    return null;
  }
}

class TradeActionOrderDetail extends _BaseAction {
  TradeActionOrderDetail(
    this.txId,
    this.completer,
  );
  final String txId;
  final Completer<TradeOrderDetail> completer;

  @override
  Future<AppState> reduce() async {
    final walletId = store.state.walletState.activeWalletId;
    final res = await TradeRepository().getOrderDetail(
      txId: txId,
      walletId: walletId,
    );
    completer.complete(res);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class TradeActionGetApproveBalance extends _BaseAction {
  TradeActionGetApproveBalance({
    @required this.chain,
    @required this.symbol,
    @required this.completer,
  });
  final String chain;
  final String symbol;
  final Completer<double> completer;

  @override
  Future<AppState> reduce() async {
    final coinInfo = store.state.assetState.getCoinInfo(
      chain: chain,
      symbol: symbol,
    );
    final approveBalance = await WalletRepository().getDexApproveBalance(
      chain: coinInfo.chain,
      symbol: coinInfo.symbol,
      contract: coinInfo.contract,
      sellAddress: coinInfo.address,
      chainPrecision: coinInfo.chainPrecision,
    );
    completer.complete(approveBalance);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class TradeActionGetOrderBalance extends _BaseAction {
  TradeActionGetOrderBalance({
    @required this.order,
    @required this.completer,
    this.forceUpdate = false,
  });
  final TradeOrder order;
  final bool forceUpdate;
  final Completer<double> completer;

  @override
  Future<AppState> reduce() async {
    final coinInfo = store.state.assetState.getCoinInfo(
      chain: order.chain,
      symbol: fixUSDTSymbol(order.symbol),
    );

    double balance = order.withdrawAmount;

    if (balance != null && forceUpdate != true) {
      completer.complete(NumberUtil.getDouble(balance));
      return null;
    }

    if (order.isChainUseApiRawTx) {
      balance = await WalletRepository().getDexOrderBalance(
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
        primaryKey: order.templateHex,
        sellAddress: coinInfo.address,
        chainPrecision: coinInfo.chainPrecision,
      );
    } else {
      final completer = Completer<double>();
      store.dispatch(AssetActionGetCoinBalance(
        wallet: store.state.walletState.activeWallet,
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
        address: order.templateAddress,
        ignoreUnspent: true,
        completer: completer,
      ));
      balance = await completer.future;
    }

    order.withdrawAmount = balance;

    completer.complete(balance);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class TradeActionOrderCheckStatus extends _BaseAction {
  TradeActionOrderCheckStatus({
    @required this.order,
    @required this.completer,
  });
  final TradeOrder order;
  final Completer<TradeOrder> completer;

  @override
  Future<AppState> reduce() async {
    final txId = order.isCancelling ? order.cancelTxId : order.txId;

    final coinInfo = store.state.assetState.getCoinInfo(
      chain: order.chain,
      symbol: fixUSDTSymbol(order.symbol),
    );

    final getTransInfo = Completer<Transaction>();
    dispatch(AssetActionGetSingleTransaction(
      txId: txId,
      chain: coinInfo.chain,
      symbol: coinInfo.symbol,
      fromAddress: order.fromAddress,
      chainPrecision: coinInfo.chainPrecision,
      completer: getTransInfo,
    ));
    final transInfo = await getTransInfo.future;

    final walletId = store.state.walletState.activeWalletId;
    final cachedOrders = await TradeRepository().getTradeOrdersFromCache(
      walletId: walletId,
    );

    final cached = cachedOrders.firstWhere(
      (item) => item.txId == order.txId,
      orElse: () => null,
    );

    if (cached != null) {
      if (transInfo?.isFailed == true) {
        cached.status = TradeOrderStatus.failed;
      }

      // Always wait for order pending list return status
      // if (cached.status == TradeOrderStatus.confirming &&
      //     transInfo?.isConfirmed == true) {
      //   cached.status = TradeOrderStatus.pending;
      // }

      await TradeRepository().saveTradeOrdersToCache(
        walletId,
        cachedOrders,
      );
    }
    completer.complete(cached);

    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}
