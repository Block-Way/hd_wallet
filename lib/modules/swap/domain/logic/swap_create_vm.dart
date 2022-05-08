part of swap_domain_module;

abstract class SwapCreateVM
    implements Built<SwapCreateVM, SwapCreateVMBuilder> {
  factory SwapCreateVM([void Function(SwapCreateVMBuilder) updates]) =
      _$SwapCreateVM;
  SwapCreateVM._();

// Methods

  @BuiltValueField(compare: false)
  double Function({
    @required String chain,
    @required String symbol,
  }) get getCoinBalance;

  @BuiltValueField(compare: false)
  AssetCoin Function({
    @required String chain,
    @required String symbol,
  }) get getCoinInfo;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  @BuiltValueField(compare: false)
  List<MapEntry<SwapConfigCoin, SwapConfigCoin>> Function()
      get getEnabledTradePairs;

  @BuiltValueField(compare: false)
  Future<double> Function({
    @required String chain,
    @required String symbol,
  }) get getApproveBalance;

  @BuiltValueField(compare: false)
  Future<Transaction> Function({
    @required String chain,
    @required String symbol,
    @required String fromAddress,
    @required int chainPrecision,
    @required String txId,
  }) get getTransactionInfo;

  @BuiltValueField(compare: false)
  Future<void> Function({
    AssetCoin outCoinInfo,
    SwapConfigCoin outCoinConfig,
    Future<WalletPrivateData> Function() onUnlockWallet,
    Future<bool> Function({
      @required WalletTemplateData approveData,
      @required double currentBalance,
      @required double approveAmount,
      @required bool needReset,
    })
        onConfirmSubmit,
    void Function(String) onSuccessTransaction,
  }) get doApproveSwap;

  @BuiltValueField(compare: false)
  Future<void> Function({
    String amount,
    AssetCoin inCoinInfo,
    AssetCoin outCoinInfo,
    SwapConfigCoin inCoinConfig,
    SwapConfigCoin outCoinConfig,
    Future<WalletPrivateData> Function() onUnlockWallet,
    Future<bool> Function() onNoticeDoubleTransaction,
    Future<bool> Function(SwapCreateParams) onConfirmSubmit,
    void Function(String) onSuccessTransaction,
  }) get doSubmitSwap;

  static SwapCreateVM fromStore(Store<AppState> store) {
    return SwapCreateVM((viewModel) {
      viewModel
        ..doUnlockWallet = (password) {
          final completer = Completer<WalletPrivateData>();
          store.dispatch(WalletActionWalletUnlock(password, completer));
          return completer.future;
        }
        ..getEnabledTradePairs = () {
          final enabledTradePairs =
              store.state.swapState?.config?.enabledTradePairs ?? [];

          enabledTradePairs.retainWhere((item) {
            final fromCoin = store.state.assetState.getCoinInfo(
              chain: item.key.chain,
              symbol: item.key.symbol,
            );
            final toCoin = store.state.assetState.getCoinInfo(
              chain: item.value.chain,
              symbol: item.value.symbol,
            );
            return fromCoin?.address?.isNotEmpty == true &&
                toCoin?.address?.isNotEmpty == true;
          });
          return enabledTradePairs;
        }
        ..getCoinInfo = ({chain, symbol}) {
          return VMWithWalletGetCoinInfoImplement.getCoinInfo(
            store,
            chain: chain,
            symbol: symbol,
          );
        }
        ..getCoinBalance = ({chain, symbol}) {
          return VMWithAssetGetCoinBalanceImplement.getCoinBalance(
            store,
            chain: chain,
            symbol: symbol,
          );
        }
        ..getApproveBalance = ({chain, symbol}) {
          final completer = Completer<double>();
          store.dispatch(
            SwapActionGetApproveBalance(
              chain: chain,
              symbol: symbol,
              completer: completer,
            ),
          );
          return completer.future;
        }
        ..getTransactionInfo = ({
          chain,
          symbol,
          fromAddress,
          chainPrecision,
          txId,
        }) {
          final completer = Completer<Transaction>();
          store.dispatch(
            AssetActionGetSingleTransaction(
              txId: txId,
              chain: chain,
              symbol: symbol,
              fromAddress: fromAddress,
              chainPrecision: chainPrecision,
              completer: completer,
            ),
          );
          return completer.future;
        }
        ..doApproveSwap = ({
          outCoinInfo,
          outCoinConfig,
          onUnlockWallet,
          onConfirmSubmit,
          onSuccessTransaction,
        }) {
          return store.dispatchFuture(SwapActionSwapApprove(
            outCoinInfo: outCoinInfo,
            outCoinConfig: outCoinConfig,
            onUnlockWallet: onUnlockWallet,
            onConfirmSubmit: onConfirmSubmit,
            onSuccessTransaction: onSuccessTransaction,
          ));
        }
        ..doSubmitSwap = ({
          amount,
          inCoinInfo,
          outCoinInfo,
          inCoinConfig,
          outCoinConfig,
          onNoticeDoubleTransaction,
          onUnlockWallet,
          onConfirmSubmit,
          onSuccessTransaction,
        }) {
          return store.dispatchFuture(SwapActionSwapSubmit(
            inCoinInfo: inCoinInfo,
            outCoinInfo: outCoinInfo,
            inCoinConfig: inCoinConfig,
            outCoinConfig: outCoinConfig,
            amount: amount,
            onNoticeDoubleTransaction: onNoticeDoubleTransaction,
            onUnlockWallet: onUnlockWallet,
            onConfirmSubmit: onConfirmSubmit,
            onSuccessTransaction: onSuccessTransaction,
          ));
        };
    });
  }
}
