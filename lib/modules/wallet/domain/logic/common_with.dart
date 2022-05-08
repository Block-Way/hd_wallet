part of wallet_domain_module;

class VMWithAssetGetCoinBalanceImplement {
  static double getCoinBalance(
    Store<AppState> store, {
    String chain,
    String symbol,
  }) {
    return store.state.walletState.activeWallet.getCoinBalance(
      chain: chain,
      symbol: symbol,
    );
  }
}
