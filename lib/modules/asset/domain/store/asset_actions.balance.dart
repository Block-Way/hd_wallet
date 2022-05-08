part of asset_domain_module;

class AssetActionGetCoinBalance extends _BaseAction {
  AssetActionGetCoinBalance({
    @required this.wallet,
    @required this.chain,
    @required this.symbol,
    @required this.address,
    this.subtractFromBalance,
    this.ignoreUnspent = true,
    this.ignoreBalanceLock = false,
    this.completer,
  });

  final Wallet wallet;
  final String chain;
  final String symbol;
  final String address;
  final double subtractFromBalance;
  final bool ignoreUnspent;
  final bool ignoreBalanceLock;
  final Completer<double> completer;

  @override
  Future<AppState> reduce() async {
    final balanceInfo = wallet.getCoinBalanceInfo(
      chain: chain,
      symbol: symbol,
      address: address,
    );

    // By default always use cached balance
    final cachedBalance = balanceInfo?.balance ?? 0.0;
    var newBalance = balanceInfo?.balance ?? 0.0;
    var newUnconfirmed = balanceInfo?.unconfirmed ?? 0.0;

    if (address == null || address.isEmpty) {
      completer?.complete(newBalance);
      return null;
    }

    bool isFailed = false;
    try {
      // Avoid refresh balance too frequently
      if (ignoreBalanceLock == true ||
          !wallet.isCoinBalanceLocked(
            chain: chain,
            symbol: symbol,
            address: address,
          )) {
        final coinInfo = store.state.assetState.getCoinInfo(
          chain: chain,
          symbol: symbol,
        );
        final apiBalance = await AssetRepository().getCoinBalance(
          chain: chain,
          symbol: symbol,
          address: address,
          contract: coinInfo.contract,
        );

        // For ETH token, since we use etherscan the balance
        // is a Int using the chainPrecision
        if (chain == 'ETH' && symbol != 'ETH') {
          newBalance = NumberUtil.getIntAmountAsDouble(
            apiBalance['balance'],
            coinInfo.chainPrecision,
          );
        } else {
          newBalance = NumberUtil.getDouble(apiBalance['balance']);
          newUnconfirmed = NumberUtil.getDouble(apiBalance['unconfirmed']);
        }

        // Test refresh balance
        // if (kDebugMode) {
        //   newBalance = cachedBalance + 1;
        // }
      }
    } catch (_) {
      isFailed = true;
    }

    // After a withdraw, we refresh the balance but
    // - if the balance is not -1 (equal to zero)
    // - if the balance didn't change
    // We need to subtractFromBalance
    if (subtractFromBalance != null &&
        (newBalance == -1 || cachedBalance == newBalance)) {
      newBalance = NumberUtil.minus(cachedBalance, subtractFromBalance);
    }

    // If api return a negative balance,
    // use the provided balance or the cached one
    if (newBalance < 0) {
      newBalance = cachedBalance ?? 0.0;
    }

    // If balance still negative, use zero
    if (newBalance < 0) {
      newBalance = 0.0;
    }

    //** cache unspent **//
    if (ignoreUnspent != true) {
      var unspent = <Map<String, dynamic>>[];
      try {
        final utxosRequest = Completer<List<Map<String, dynamic>>>();
        dispatch(WalletActionGetUnspent(
          chain: chain,
          symbol: symbol,
          address: address,
          forceUpdate: newBalance != cachedBalance,
          completer: utxosRequest,
          balance: newBalance,
        ));
        unspent = await utxosRequest.future;
      } catch (_) {
        isFailed = true;
        unspent = null;
      }

      // If we have unspent and is a empty list, means we don't have any balance
      if (unspent != null && unspent.isEmpty) {
        newBalance = 0.0;
      }
    }

    wallet.updateCoinBalance(
      chain: chain,
      symbol: symbol,
      address: address,
      balance: newBalance,
      unconfirmed: newUnconfirmed,
    );

    if (isFailed == false) {
      wallet.lockUpdateCoinBalance(
        chain: chain,
        symbol: symbol,
        address: address,
        lookUntil: DateTime.now().add(Duration(seconds: 30)),
      );
    }

    GetIt.I<AssetBalanceCubit>().updateBalance(
      symbol: symbol,
      address: address,
      balance: newBalance,
      unconfirmed: newUnconfirmed,
    );

    await dispatchFuture(_AssetActionUpdateAssetCoinBalance(
      chain: chain,
      symbol: symbol,
      address: address,
      balance: newBalance,
      hasError: isFailed,
    ));

    completer?.complete(newBalance);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer?.completeError(error);
    return error;
  }
}

class AssetActionResetCoinBalance extends _BaseAction {
  AssetActionResetCoinBalance({
    @required this.wallet,
    @required this.chain,
    @required this.symbol,
    @required this.address,
  });

  final Wallet wallet;
  final String chain;
  final String symbol;
  final String address;

  @override
  AppState reduce() {
    const newBalance = 0.0;

    wallet.updateCoinBalance(
      chain: chain,
      symbol: symbol,
      address: address,
      balance: newBalance,
      unconfirmed: newBalance,
    );

    GetIt.I<AssetBalanceCubit>().updateBalance(
      symbol: symbol,
      address: address,
      balance: newBalance,
      unconfirmed: newBalance,
    );

    dispatch(
      _AssetActionUpdateAssetCoinBalance(
        chain: chain,
        symbol: symbol,
        address: address,
        balance: newBalance,
        hasError: false,
      ),
    );

    return null;
  }
}

class _AssetActionUpdateAssetCoinBalance extends _BaseAction {
  _AssetActionUpdateAssetCoinBalance({
    this.chain,
    this.symbol,
    this.address,
    this.balance,
    this.hasError,
  });

  final String chain;
  final String symbol;
  final String address;
  final double balance;
  final bool hasError;

  @override
  AppState reduce() {
    final coins = state.assetState.coins.map(
        (e) => e.chain == chain && e.symbol == symbol && e.address == address
            ? e.rebuild(
                (u) => u
                  ..balance = balance
                  ..balanceUpdateFailed = hasError,
              )
            : e);

    return state.rebuild(
      (a) => a..assetState.coins.replace(coins),
    );
  }
}

class _AssetActionUpdateBalancesBefore extends _BaseAction {
  _AssetActionUpdateBalancesBefore();

  @override
  AppState reduce() {
    return state.rebuild(
      (a) => a..assetState.isBalanceUpdating = true,
    );
  }
}

class _AssetActionUpdateBalancesAfter extends _BaseAction {
  _AssetActionUpdateBalancesAfter();

  @override
  AppState reduce() {
    return state.rebuild(
      (a) => a..assetState.isBalanceUpdating = false,
    );
  }
}

class AssetActionUpdateWalletBalances extends _BaseAction {
  AssetActionUpdateWalletBalances({
    @required this.wallet,
    this.skipFrequentUpdate = false,
  });

  final Wallet wallet;
  final bool skipFrequentUpdate;

  @override
  void before() {
    dispatch(_AssetActionUpdateBalancesBefore());
  }

  @override
  Future<AppState> reduce() async {
    if (wallet == null) {
      return null;
    }

    for (final coin in state.assetState.coins) {
      final balanceInfo = wallet.getCoinBalanceInfo(
        chain: coin.chain,
        symbol: coin.symbol,
        address: coin.address,
      );
      if (skipFrequentUpdate == true &&
          balanceInfo?.updatedAt != null &&
          DateTime.now().difference(balanceInfo.updatedAt).inMinutes < 5) {
        await Future.delayed(Duration(milliseconds: 200));
      } else {
        await dispatchFuture(
          AssetActionGetCoinBalance(
            wallet: wallet,
            chain: coin.chain,
            symbol: coin.symbol,
            address: coin.address,
          ),
        );
      }
    }
    return null;
  }

  @override
  void after() {
    dispatch(_AssetActionUpdateBalancesAfter());
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}
