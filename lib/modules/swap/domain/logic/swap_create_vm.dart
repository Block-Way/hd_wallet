part of swap_domain_module;

abstract class SwapCreateVM
    implements Built<SwapCreateVM, SwapCreateVMBuilder> {
  factory SwapCreateVM([void Function(SwapCreateVMBuilder) updates]) =
      _$SwapCreateVM;
  SwapCreateVM._();

// Methods

  @BuiltValueField(compare: false)
  double Function({
    required String chain,
    required String symbol,
  }) get getCoinBalance;

  @BuiltValueField(compare: false)
  AssetCoin Function({
    required String chain,
    required String symbol,
  }) get getCoinInfo;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  @BuiltValueField(compare: false)
  List<MapEntry<SwapConfigCoin, SwapConfigCoin>> Function()
      get getEnabledTradePairs;

  @BuiltValueField(compare: false)
  Future<double> Function({
    required String chain,
    required String symbol,
  }) get getApproveBalance;

  @BuiltValueField(compare: false)
  Future<Transaction> Function({
    required String chain,
    required String symbol,
    required String fromAddress,
    required int chainPrecision,
    required String txId,
  }) get getTransactionInfo;

  @BuiltValueField(compare: false)
  Future<void> Function({
    AssetCoin outCoinInfo,
    SwapConfigCoin outCoinConfig,
    Future<WalletPrivateData> Function() onUnlockWallet,
    Future<bool> Function({
      required WalletTemplateData approveData,
      required double currentBalance,
      required double approveAmount,
      required bool needReset,
    })
        onConfirmSubmit,
    void Function(String) onSuccessTransaction,
  }) get doApproveSwap;

  @BuiltValueField(compare: false)
  Future<void> Function({
    required String amount,
    required AssetCoin inCoinInfo,
    required AssetCoin outCoinInfo,
    required SwapConfigCoin inCoinConfig,
    required SwapConfigCoin outCoinConfig,
    required Future<WalletPrivateData> Function() onUnlockWallet,
    required Future<bool> Function() onNoticeDoubleTransaction,
    required Future<bool> Function(SwapCreateParams) onConfirmSubmit,
    required void Function(String) onSuccessTransaction,
  }) get doSubmitSwap;

  static SwapCreateVM fromStore(Store<AppState> store) {
    return SwapCreateVM((viewModel) {
      viewModel
        ..doUnlockWallet = (password) {
          final completer = Completer<WalletPrivateData>();
          store.dispatch(WalletActionWalletUnlock(password, completer));
          return completer.future;
        }
        /*
        ..getEnabledTradePairs = () {
          final enabledTradePairs =
              store.state.swapState.config.enabledTradePairs ?? [];

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
        }*/
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
        }
        ..getApproveBalance = ({required chain, required symbol}) {
          final completer = Completer<double>();
          store.dispatch(
            SwapActionGetApproveBalance(
              chain: chain,
              symbol: symbol,
              completer: completer,
            ),
          );
          return completer.future;
        } /*
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
          required outCoinInfo,
          required outCoinConfig,
          required onUnlockWallet,
          required onConfirmSubmit,
          required onSuccessTransaction,
        }) {
          return store.dispatchAsync(SwapActionSwapApprove(
            outCoinInfo: outCoinInfo,
            outCoinConfig: outCoinConfig,
            onUnlockWallet: onUnlockWallet,
            onConfirmSubmit: onConfirmSubmit,
            onSuccessTransaction: onSuccessTransaction,
          ));
        }*/
        ..doSubmitSwap = ({
          required amount,
          required inCoinInfo,
          required outCoinInfo,
          required inCoinConfig,
          required outCoinConfig,
          required onNoticeDoubleTransaction,
          required onUnlockWallet,
          required onConfirmSubmit,
          required onSuccessTransaction,
        }) {
          return store.dispatchAsync(
            SwapActionSwapSubmit(
              inCoinInfo: inCoinInfo,
              outCoinInfo: outCoinInfo,
              inCoinConfig: inCoinConfig,
              outCoinConfig: outCoinConfig,
              amount: amount,
              onNoticeDoubleTransaction: onNoticeDoubleTransaction,
              onUnlockWallet: onUnlockWallet,
              onConfirmSubmit: onConfirmSubmit,
              onSuccessTransaction: onSuccessTransaction,
            ),
          );
        };
    });
  }
}
