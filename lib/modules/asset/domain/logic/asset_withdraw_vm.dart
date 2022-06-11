part of asset_domain_module;

abstract class AssetWithdrawVM
    with VMWithWalletWithdraw
    implements Built<AssetWithdrawVM, AssetWithdrawVMBuilder> {
  factory AssetWithdrawVM([void Function(AssetWithdrawVMBuilder) updates]) =
      _$AssetWithdrawVM;
  AssetWithdrawVM._();

// Fields

  bool get hideDepositShowcase;
  bool get hideWithdrawShowcase;

// Withdraw Methods
  @override
  @BuiltValueField(compare: false)
  Future<WalletWithdrawData> Function(
    WithdrawBeforeParams params,
    WalletWithdrawData previousData,
  ) get onWithdrawBefore;

  @override
  @BuiltValueField(compare: false)
  Future<String> Function(
    WithdrawSubmitParams params,
    WalletPrivateData walletData, [
    Future<bool> Function() onFinalCheck,
  ]) get submit;

  @override
  @BuiltValueField(compare: false)
  double Function({
    required String chain,
    required String symbol,
  }) get getCoinBalance;

  @override
  @BuiltValueField(compare: false)
  AssetCoin Function({
    required String chain,
    required String symbol,
  }) get getCoinInfo;

  @override
  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

// Methods

  static AssetWithdrawVM fromStore(Store<AppState> store) {
    return AssetWithdrawVM(
      (viewModel) => viewModel
        ..hideDepositShowcase = store.state.assetState.hideDepositShowcase
        ..hideWithdrawShowcase = store.state.assetState.hideWithdrawShowcase
        ..onWithdrawBefore = (params, previousData) {
          final completer = Completer<WalletWithdrawData>();
          store.dispatch(WalletActionWithdrawBefore(
            params: params,
            completer: completer,
            previousData: previousData,
          ));
          return completer.future;
        }
        ..doUnlockWallet = (password) {
          final completer = Completer<WalletPrivateData>();
          store.dispatch(WalletActionWalletUnlock(password, completer));
          return completer.future;
        }
        ..submit =
            (params, walletData, [Future<bool> Function()? onConfirmSubmit]) {
          final completer = Completer<String>();
          store.dispatch(WalletActionWithdrawSubmit(
            params: params,
            walletData: walletData,
            completer: completer,
            onConfirmSubmit: onConfirmSubmit!,
          ));
          return completer.future;
        }
        ..getCoinInfo = ({required chain, required symbol}) {
          return VMWithWalletGetCoinInfoImplement.getCoinInfo(
            store,
            chain: chain,
            symbol: symbol,
          );
        }
        ..getCoinBalance = ({required chain, required symbol}) {
          return VMWithAssetGetCoinBalanceImplement.getCoinBalance(
            store,
            chain: chain,
            symbol: symbol,
          );
        },
    );
  }
}
