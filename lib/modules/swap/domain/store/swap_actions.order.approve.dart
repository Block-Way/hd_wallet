part of swap_domain_module;

class SwapActionSwapApprove extends _BaseAction {
  SwapActionSwapApprove({
    @required this.outCoinInfo,
    @required this.outCoinConfig,
    @required this.onConfirmSubmit,
    @required this.onUnlockWallet,
    @required this.onSuccessTransaction,
  });

  final AssetCoin outCoinInfo;
  final SwapConfigCoin outCoinConfig;
  final Future<WalletPrivateData> Function() onUnlockWallet;
  final Future<bool> Function({
    @required WalletTemplateData approveData,
    @required double currentBalance,
    @required double approveAmount,
    @required bool needReset,
  }) onConfirmSubmit;
  final void Function(String txId) onSuccessTransaction;

  @override
  Future<AppState> reduce() async {
    // Get balance again to double check
    final currentBalance = await SwapRepository().getApproveBalance(
      chain: outCoinInfo.chain,
      symbol: outCoinInfo.symbol,
      address: outCoinInfo.address,
      contract: outCoinInfo.contract,
      chainPrecision: outCoinInfo.chainPrecision,
    );

    // If I call this function and I have approve balance,
    // means that the balance was not enough, need to reset
    final approveNeedReset = currentBalance > 0;

    final approveAmount = approveNeedReset
        ? 0.0
        : AppConstants.isBeta
            ? 100.0
            : NumberUtil.multiply<double>(outCoinConfig.transferMax ?? 100, 2);

    final approveAmountInt = NumberUtil.getAmountAsInt(
      approveAmount,
      outCoinInfo.chainPrecision,
    );

    // TODO: need to check for ETH fee balance

    final transInfo = await SwapRepository().postApproveTransaction(
      chain: outCoinInfo.chain,
      symbol: outCoinInfo.symbol,
      address: outCoinInfo.address,
      contract: outCoinInfo.contract,
      amount: approveAmountInt,
    );
    final approveData = WalletTemplateData(
      chain: outCoinInfo.chain,
      symbol: outCoinInfo.symbol,
      templateHex: null, // No Hex for approve
      templateData: transInfo,
      templateAddress: outCoinInfo.address,
    );

    final canContinue = await onConfirmSubmit(
      approveData: approveData,
      currentBalance: currentBalance,
      approveAmount: approveAmount,
      needReset: approveNeedReset,
    );
    if (canContinue != true) {
      return null;
    }

    final walletData = await onUnlockWallet();
    if (walletData == null) {
      return null;
    }

    // ETH and TRX submit
    final submitTransaction = Completer<String>();

    dispatch(WalletActionSignAndSubmitRawTx(
      chain: outCoinInfo.chain,
      symbol: outCoinInfo.symbol,
      fromAddress: outCoinInfo.address,
      rawTx: approveData.rawTx,
      walletData: walletData,
      completer: submitTransaction,
      amount: approveAmount,
    ));
    final txId = await submitTransaction.future;

    dispatch(AssetActionAddTransaction(Transaction.fromRaw(
      txId: txId,
      chain: outCoinInfo.chain,
      symbol: outCoinInfo.chain,
      feeValue: approveData.feeValue,
      feeSymbol: outCoinInfo.chain,
      amount: approveAmount,
      toAddress: approveData.contract,
      fromAddress: outCoinInfo.address,
      type: TransactionType.approveCall,
    )));

    onSuccessTransaction(txId);

    return null;
  }

  @override
  Object wrapError(dynamic error) {
    return parseWalletError(error);
  }
}
