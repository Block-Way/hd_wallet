part of admission_domain_module;

abstract class AdmissionCreateVM
    with VMWithWalletWithdraw
    implements Built<AdmissionCreateVM, AdmissionCreateVMBuilder> {
  factory AdmissionCreateVM([void Function(AdmissionCreateVMBuilder) updates]) =
      _$AdmissionCreateVM;
  AdmissionCreateVM._();

// Fields
  @nullable
  String get walletId;

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
    Future<bool> Function() onConfirmSubmit,
  ]) get submit;

  @BuiltValueField(compare: false)
  Future<void> Function({
    AssetCoin coinInfo,
    String toAddress,
    String txData,
    String amount,
    Future<WalletPrivateData> Function() onUnlockWallet,
    void Function(String txId) onSuccessTransaction,
    Future<bool> Function(WalletWithdrawData withdrawData) onConfirmParams,
    Future<bool> Function() onConfirmSubmit,
  }) get doSubmitAdmission;

  @override
  @BuiltValueField(compare: false)
  double Function({
    @required String chain,
    @required String symbol,
  }) get getCoinBalance;

  @override
  @BuiltValueField(compare: false)
  AssetCoin Function({
    @required String chain,
    @required String symbol,
  }) get getCoinInfo;

  @BuiltValueField(compare: false)
  AssetCoin Function(
    String fork,
  ) get getCoinInfoByFork;

  @override
  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  static AdmissionCreateVM fromStore(Store<AppState> store) {
    return AdmissionCreateVM((viewModel) => viewModel
      ..walletId = store.state.walletState.activeWalletId
      ..onWithdrawBefore = (params, previousData) {
        final completer = Completer<WalletWithdrawData>();
        store.dispatch(WalletActionWithdrawBefore(
          params: params,
          completer: completer,
          previousData: previousData,
        ));
        return completer.future;
      }
      ..submit = (_, __, [___]) {
        return Future.value('');
      }
      ..doUnlockWallet = (password) {
        final completer = Completer<WalletPrivateData>();
        store.dispatch(WalletActionWalletUnlock(password, completer));
        return completer.future;
      }
      ..doSubmitAdmission = ({
        coinInfo,
        toAddress,
        txData,
        amount,
        onUnlockWallet,
        onSuccessTransaction,
        onConfirmParams,
        onConfirmSubmit,
      }) {
        return store.dispatchFuture(AdmissionActionCreateSubmit(
          coinInfo: coinInfo,
          toAddress: toAddress,
          txData: txData,
          amount: amount,
          onUnlockWallet: onUnlockWallet,
          onSuccessTransaction: onSuccessTransaction,
          onConfirmParams: onConfirmParams,
          onConfirmSubmit: onConfirmSubmit,
        ));
      }
      ..getCoinInfo = ({chain, symbol}) {
        return VMWithWalletGetCoinInfoImplement.getCoinInfo(
          store,
          chain: chain,
          symbol: symbol,
        );
      }
      ..getCoinInfoByFork = (fork) {
        final coins = store.state.assetState.coins;
        final coin =
            coins.firstWhere((e) => e.contract == fork, orElse: () => null);

        return coin;
      }
      ..getCoinBalance = ({chain, symbol}) {
        return VMWithAssetGetCoinBalanceImplement.getCoinBalance(
          store,
          chain: chain,
          symbol: symbol,
        );
      });
  }
}
