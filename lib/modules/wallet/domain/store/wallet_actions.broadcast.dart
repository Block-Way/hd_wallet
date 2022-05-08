part of wallet_domain_module;

class WalletActionGetBroadcastsFailed extends _BaseAction {
  WalletActionGetBroadcastsFailed({
    @required this.type,
    @required this.completer,
  });

  final BroadcastTxType type;
  final Completer<List<BroadcastTxInfo>> completer;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;
    final allBroadcasts = await WalletRepository().getBroadcastsFromCache(
      walletId,
    );

    completer.complete(
      allBroadcasts
          .where((item) => item.type == type && item.isSubmitted == false)
          .toList(),
    );

    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class WalletActionAddBroadcastTx extends _BaseAction {
  WalletActionAddBroadcastTx({
    @required this.txId,
    @required this.type,
    @required this.chain,
    @required this.symbol,
    @required this.apiParams,
  });

  final String txId;
  final BroadcastTxType type;
  final String chain;
  final String symbol;
  final String apiParams;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;
    final allBroadcasts = await WalletRepository().getBroadcastsFromCache(
      walletId,
    );

    if (allBroadcasts
        .where((item) => item.txId == txId && item.type == type)
        .isEmpty) {
      // Add new
      allBroadcasts.add(BroadcastTxInfo(
        txId: txId,
        type: type,
        chain: chain,
        symbol: symbol,
        apiParams: apiParams,
      ));
    }

    await WalletRepository().saveBroadcastsToCache(
      walletId,
      allBroadcasts.toList(),
    );

    return null;
  }
}

class WalletActionDoneBroadcastTx extends _BaseAction {
  WalletActionDoneBroadcastTx({
    @required this.type,
    @required this.txId,
  });

  final String txId;
  final BroadcastTxType type;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;
    final allBroadcasts = await WalletRepository().getBroadcastsFromCache(
      walletId,
    );

    final newItem = allBroadcasts.firstWhere(
      (item) => item.txId == txId && item.type == type,
      orElse: () => null,
    );

    if (newItem != null) {
      newItem.isSubmitted = true;
    }

    await WalletRepository().saveBroadcastsToCache(
      walletId,
      allBroadcasts
          .replaceFirstWhere(
              (item) => item.txId == txId && item.type == type, newItem)
          .toList(),
    );

    return null;
  }
}
