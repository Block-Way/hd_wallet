part of open_domain_module;

abstract class OpenWebviewVM
    implements Built<OpenWebviewVM, OpenWebviewVMBuilder> {
  factory OpenWebviewVM([void Function(OpenWebviewVMBuilder) updates]) =
      _$OpenWebviewVM;
  OpenWebviewVM._();

// Fields
  String get fiatCurrency;
  bool get hasWallet;
  @nullable
  Wallet get activeWallet;
  String get activeWalletId;
  WalletStatus get activeWalletStatus;

// Withdraw Methods
  @BuiltValueField(compare: false)
  Future<WalletWithdrawData> Function(
    WithdrawBeforeParams params,
    WalletWithdrawData previousData,
  ) get onWithdrawBefore;

  @BuiltValueField(compare: false)
  Future<String> Function(
    WithdrawSubmitParams params,
    WalletPrivateData walletData, [
    Future<bool> Function() onFinalCheck,
  ]) get submit;

  @BuiltValueField(compare: false)
  double Function({
    @required String chain,
    @required String symbol,
  }) get getCoinBalance;

  @BuiltValueField(compare: false)
  String Function({
    @required String chain,
    @required String symbol,
  }) get getCoinAddress;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

// Methods

  static OpenWebviewVM fromStore(Store<AppState> store) {
    return OpenWebviewVM(
      (viewModel) => viewModel
        ..fiatCurrency = store.state.commonState.fiatCurrency ?? ''
        ..hasWallet = store.state.walletState.hasWallet ?? false
        ..activeWallet = store.state.walletState.activeWallet
        ..activeWalletId = store.state.walletState.activeWalletId ?? ''
        ..activeWalletStatus = store.state.walletState.activeWalletStatus
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
        ..submit = (params, walletData, [onConfirmSubmit]) {
          final completer = Completer<String>();
          store.dispatch(WalletActionWithdrawSubmit(
            params: params,
            walletData: walletData,
            completer: completer,
            onConfirmSubmit: onConfirmSubmit,
          ));
          return completer.future;
        }
        ..getCoinAddress = ({chain, symbol}) {
          return VMWithWalletGetCoinInfoImplement.getCoinInfo(
            store,
            chain: chain,
            symbol: symbol,
          ).address;
        }
        ..getCoinBalance = ({chain, symbol}) {
          return VMWithAssetGetCoinBalanceImplement.getCoinBalance(
            store,
            chain: chain,
            symbol: symbol,
          );
        },
    );
  }
}
