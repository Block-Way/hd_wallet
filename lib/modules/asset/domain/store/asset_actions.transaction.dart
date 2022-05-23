part of asset_domain_module;

class AssetActionAddTransaction extends _BaseAction {
  AssetActionAddTransaction(this.transaction);
  final Transaction transaction;

  @override
  Future<AppState> reduce() async {
    final allTransactions = await AssetRepository().getTransactionsFromCache(
      symbol: transaction.symbol,
      address: transaction.fromAddress,
    );

    allTransactions.insert(0, transaction);

    await AssetRepository().saveTransactionsToCache(
      symbol: transaction.symbol,
      address: transaction.fromAddress,
      transactions: allTransactions.toList(),
    );

    GetIt.I<AssetTransactionCubit>().updateList(allTransactions);

    return null;
  }
}

class AssetActionGetSingleTransaction extends _BaseAction {
  AssetActionGetSingleTransaction({
    @required this.chain,
    @required this.symbol,
    @required this.chainPrecision,
    @required this.txId,
    @required this.fromAddress,
    @required this.completer,
  });

  final String chain;
  final String symbol;
  final int chainPrecision;
  final String txId;
  final String fromAddress;
  final Completer<Transaction> completer;

  @override
  Future<AppState> reduce() async {
    final walletId = store.state.walletState.activeWalletId;

    bool isFailed = false;
    Transaction newTransaction;
    try {
      final json = await AssetRepository().getSingleTransaction(
        chain: chain,
        symbol: symbol,
        txId: txId,
        walletId: walletId,
      );
      newTransaction = Transaction.fromJson(
        chain: chain,
        symbol: symbol,
        json: json,
        chainPrecision: chainPrecision,
        fromAddress: fromAddress,
      );
    } catch (error) {
      final responseError = Request().getResponseError(error);
      if (responseError.message.contains('transaction info not found')) {
        isFailed = true;
      }
    }

    final coinInfo = store.state.assetState.getCoinInfo(
      chain: chain,
      symbol: symbol,
    );
    final cachedTransactions = await AssetRepository().getTransactionsFromCache(
      symbol: symbol,
      address: coinInfo.address,
    );
    for (final item in cachedTransactions) {
      if (item.txId == txId) {
        if (item.isConfirming) {
          item.failed = isFailed;
        }
        if (newTransaction?.confirmations != null) {
          item.confirmations = newTransaction.confirmations;
        }
        if (newTransaction?.fee != null && newTransaction.fee > 0) {
          item.fee = newTransaction.fee;
        }
        if (newTransaction?.failed != null) {
          item.failed = newTransaction.failed;
        }
      }
    }
    await AssetRepository().saveTransactionsToCache(
      symbol: symbol,
      address: coinInfo.address,
      transactions: cachedTransactions.toList(),
    );

    completer.complete(
      cachedTransactions.firstWhere(
        (element) => element.txId == txId,
        orElse: () => newTransaction,
      ),
    );

    GetIt.I<AssetTransactionCubit>().updateList(cachedTransactions);

    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}
