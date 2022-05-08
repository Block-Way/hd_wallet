part of trade_domain_module;

class TradeActionOrderApprove extends _BaseAction {
  TradeActionOrderApprove({
    @required this.tradePair,
    @required this.tradeSide,
    @required this.onConfirmSubmit,
    @required this.onUnlockWallet,
    @required this.onSuccessTransaction,
  });

  final TradePair tradePair;
  final TradeSide tradeSide;
  final Future<bool> Function({
    @required WalletTemplateData approveData,
    @required double currentBalance,
    @required double approveAmount,
    @required bool needReset,
  }) onConfirmSubmit;
  final Future<WalletPrivateData> Function() onUnlockWallet;
  final void Function(String) onSuccessTransaction;

  @override
  Future<AppState> reduce() async {
    // Coin to use for creating templateData
    final sellCoinInfo = store.state.assetState.getCoinInfo(
      chain: tradePair.sideChain(tradeSide),
      symbol: tradePair.sideSymbol(tradeSide),
    );

    // Trade Coin Config for templateData
    final coinConfig = store.state.tradeState.getCoinConfig(
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.symbol,
    );

    // Get balance again to double check
    final currentBalance = await WalletRepository().getDexApproveBalance(
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.symbol,
      sellAddress: sellCoinInfo.address,
      contract: sellCoinInfo.contract,
      chainPrecision: sellCoinInfo.chainPrecision,
    );

    // If I call this function and I have approve balance,
    // means that the balance was not enough, need to reset
    final approveNeedReset = currentBalance > 0;

    final approveAmount = approveNeedReset
        ? 0.0
        : AppConstants.isBeta
            ? 100.0
            : NumberUtil.multiply<double>(coinConfig.maxAmount, 2);

    final approveAmountInt = NumberUtil.getAmountAsInt(
      approveAmount,
      sellCoinInfo.chainPrecision,
    );

    // TODO: need to check for ETH fee balance

    final transInfo = await WalletRepository().dexCreateApproveTransaction(
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.symbol,
      sellAmount: approveAmountInt,
      sellAddress: sellCoinInfo.address,
      sellContract: sellCoinInfo.contract,
    );
    final approveData = WalletTemplateData(
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.symbol,
      templateHex: null, // No Hex for approve
      templateData: transInfo,
      templateAddress: sellCoinInfo.address,
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
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.symbol,
      fromAddress: sellCoinInfo.address,
      rawTx: approveData.rawTx,
      walletData: walletData,
      completer: submitTransaction,
      amount: approveAmount,
    ));
    final txId = await submitTransaction.future;

    dispatch(AssetActionAddTransaction(Transaction.fromRaw(
      txId: txId,
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.chain,
      feeValue: approveData.feeValue,
      feeSymbol: sellCoinInfo.chain,
      amount: approveAmount,
      toAddress: approveData.contract,
      fromAddress: sellCoinInfo.address,
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
