part of wallet_domain_module;

class VMWithAssetGetCoinBalanceImplement {
  static double getCoinBalance(
    Store<AppState> store, {
    required String chain,
    required String symbol,
  }) {
    return store.state.walletState.activeWallet?.getCoinBalance(
          chain: chain,
          symbol: symbol,
        ) ??
        0;
  }
}
