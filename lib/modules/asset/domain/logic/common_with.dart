part of asset_domain_module;

abstract class VMWithWalletWithdraw {
  @BuiltValueField(compare: false)
  Future<WalletWithdrawData> Function(
    WithdrawBeforeParams params,
    WalletWithdrawData previousData,
  ) get onWithdrawBefore;

  @BuiltValueField(compare: false)
  Future<String> Function(
    WithdrawSubmitParams params,
    WalletPrivateData walletData, [
    Future<bool> Function() onConfirmSubmit,
  ]) get submit;

  @BuiltValueField(compare: false)
  double Function({required String chain, required String symbol})
      get getCoinBalance;

  @BuiltValueField(compare: false)
  AssetCoin Function({required String chain, required String symbol})
      get getCoinInfo;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;
}

class VMWithWalletGetCoinInfoImplement {
  static AssetCoin getCoinInfo(
    Store<AppState> store, {
    required String chain,
    required String symbol,
  }) {
    return store.state.assetState.getCoinInfo(
      chain: chain,
      symbol: symbol,
    );
  }
}
