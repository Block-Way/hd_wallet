part of asset_domain_module;

abstract class AssetDetailVM
    implements Built<AssetDetailVM, AssetDetailVMBuilder> {
  factory AssetDetailVM([void Function(AssetDetailVMBuilder) b]) =
      _$AssetDetailVM;
  AssetDetailVM._();

// Fields
  @nullable
  Wallet get activeWallet;

// Methods
  @BuiltValueField(compare: false)
  Future<void> Function(AssetCoin coin, bool isRefresh) get doLoadDetail;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  static AssetDetailVM fromStore(Store<AppState> store) {
    return AssetDetailVM((viewModel) => viewModel
      ..activeWallet = store.state.walletState.activeWallet
      ..doLoadDetail = (coin, isRefresh) {
        return store.dispatchFuture(AssetActionGetCoinBalance(
          wallet: store.state.walletState.activeWallet,
          chain: coin.chain,
          symbol: coin.symbol,
          address: coin.address,
          ignoreBalanceLock: isRefresh,
        ));
      }
      ..doUnlockWallet = (password) {
        final completer = Completer<WalletPrivateData>();
        store.dispatch(WalletActionWalletUnlock(password, completer));
        return completer.future;
      });
  }
}
