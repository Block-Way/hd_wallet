part of trade_domain_module;

class TradeActionOrderCreate extends _BaseAction {
  TradeActionOrderCreate({
    @required this.tradePair,
    @required this.tradeSide,
    @required this.price,
    @required this.amount,
    @required this.total,
    @required this.onConfirmSubmit,
    @required this.onUnlockWallet,
    @required this.onSuccessTransaction,
  });

  final TradePair tradePair;
  final TradeSide tradeSide;
  final double price;
  final double amount;
  final double total;
  final Future<bool> Function(DexCreateOrderParams) onConfirmSubmit;
  final Future<WalletPrivateData> Function() onUnlockWallet;
  final void Function(String txId) onSuccessTransaction;

  @override
  Future<AppState> reduce() async {
    // Coin to use for creating templateData
    final sellCoinInfo = store.state.assetState.getCoinInfo(
      chain: tradePair.sideChain(tradeSide),
      symbol: tradePair.sideSymbol(tradeSide),
    );
    final buyCoinInfo = store.state.assetState.getCoinInfo(
      chain: tradePair.buySideChain(tradeSide),
      symbol: tradePair.buySideSymbol(tradeSide),
    );
    // Trade Coin Config for templateData
    final coinConfig = store.state.tradeState.getCoinConfig(
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.symbol,
    );

    if (coinConfig == null ||
        coinConfig.matchAddress == null ||
        coinConfig.matchAddress.isEmpty ||
        coinConfig.dealAddress == null ||
        coinConfig.dealAddress.isEmpty) {
      throw TradeParamsMissingError();
    }

    if (buyCoinInfo.address == null || buyCoinInfo.address.isEmpty) {
      throw TradeAddressEmptyError(buyCoinInfo.name);
    }

    if (sellCoinInfo.address == null || sellCoinInfo.address.isEmpty) {
      throw TradeAddressEmptyError(sellCoinInfo.name);
    }

    final params = DexCreateOrderParams(
      tradePairId: tradePair.id,
      isBuy: tradeSide == TradeSide.buy,
      chain: sellCoinInfo.chain,
      symbol: sellCoinInfo.symbol,
      price: price,
      amount: amount,
      total: total,
      sellAddress: sellCoinInfo.address,
      sellContract: sellCoinInfo.contract,
      sellChainPrecision: sellCoinInfo.chainPrecision,
      buyAddress: buyCoinInfo.address,
      buyContract: buyCoinInfo.contract,
      buyChainPrecision: buyCoinInfo.chainPrecision,
      currentHeight: 0, // NOTE: currentHeight is added on the server side
      minBlockHeight: coinConfig.minBlockHeight,
      maxBlockHeight: coinConfig.maxBlockHeight,
      matchFee: coinConfig.matchFee,
      dealAddress: coinConfig.dealAddress,
      matchAddress: coinConfig.matchAddress,
      withdrawData: null,
    );

    if (params.isChainUseApiRawTx) {
      final approveBalance = await WalletRepository().getDexApproveBalance(
        chain: sellCoinInfo.chain,
        symbol: sellCoinInfo.symbol,
        sellAddress: sellCoinInfo.address,
        contract: sellCoinInfo.contract,
        chainPrecision: sellCoinInfo.chainPrecision,
      );
      if (NumberUtil.isGreater(params.payAmount, approveBalance)) {
        throw TradeApproveBalanceLowError();
      }
    }

    final templateRequest = Completer<WalletTemplateData>();
    dispatch(WalletActionCreateDexOrderTemplate(
      params,
      templateRequest,
    ));
    params.templateData = await templateRequest.future;

    if (params.isChainUseApiRawTx) {
      final fee = WalletWithdrawFeeData(
        feeRate: params.templateData.trxSun.toString(),
        feeValue: params.templateData.feeValue,
        feeUnit: params.chain,
        feeSymbol: params.chain,
        gasLimit: params.templateData.gasLimit,
        gasPrice: params.templateData.gasPrice,
      );
      params.withdrawData = WalletWithdrawData(
        chain: params.chain,
        symbol: params.symbol,
        toAddress: params.sellAddress,
        fromAddress: params.sellAddress,
        fee: fee,
        feeDefault: fee,
        utxos: [],
        contract: params.sellContract,
      );
    } else {
      final utxosRequest = Completer<List<Map<String, dynamic>>>();
      dispatch(WalletActionGetUnspent(
        chain: params.chain,
        symbol: params.symbol,
        address: params.sellAddress,
        completer: utxosRequest,
        balance: sellCoinInfo.balance,
      ));
      final utxos = await utxosRequest.future;
      final fee = WalletWithdrawFeeData(
        feeRate: coinConfig.networkFee.toString(),
        feeValue: coinConfig.networkFee,
        feeUnit: params.symbol,
        feeSymbol: params.symbol,
      );
      params.withdrawData = WalletWithdrawData(
        chain: params.chain,
        symbol: params.symbol,
        toAddress: params.sellAddress,
        fromAddress: params.sellAddress,
        fee: fee,
        feeDefault: fee,
        utxos: utxos,
        contract: params.sellContract,
      );
    }

    // if (params.withdrawData.isDoubleTransaction == true) {
    //   final canContinue = await onNoticeDoubleTransaction();
    //   if (canContinue != true) {
    //     return null;
    //   }
    // }

    final canContinue = await onConfirmSubmit(params);
    if (canContinue != true) {
      return null;
    }

    final walletData = await onUnlockWallet();
    if (walletData == null) {
      return null;
    }

    String txId = '';
    if (params.isChainUseApiRawTx) {
      final submitTransaction = Completer<String>();
      // ETH and TRX submit
      dispatch(WalletActionSignAndSubmitRawTx(
        chain: params.chain,
        symbol: params.symbol,
        fromAddress: params.sellAddress,
        rawTx: params.templateData.rawTx,
        walletData: walletData,
        completer: submitTransaction,
        amount: params.payAmount,
      ));
      txId = await submitTransaction.future;
      dispatch(AssetActionAddTransaction(Transaction.fromRaw(
        txId: txId,
        chain: params.chain,
        symbol: params.symbol,
        feeValue: params.withdrawData.fee.feeValue,
        feeSymbol: params.chain,
        amount: params.payAmount,
        toAddress: params.templateData.contract,
        fromAddress: params.sellAddress,
        type: TransactionType.withdraw,
      )));
    } else {
      final submitTransaction = Completer<String>();
      // Withdraw action will broadcast and add transaction to cache
      dispatch(WalletActionWithdrawSubmit(
        params: WithdrawSubmitParams(
          withdrawData: params.withdrawData,
          amount: params.isBuy ? params.total : params.amount,
          chainPrecision: params.sellChainPrecision,
          toAddress: params.templateData.templateAddress,
          txTemplateData: params.templateData.templateHex,
        ),
        walletData: walletData,
        completer: submitTransaction,
      ));
      txId = await submitTransaction.future;
    }

    await dispatchFuture(TradeActionOrderAddPending(TradeOrder.fromSubmit(
      params: params,
      result: params.templateData,
      txId: txId,
    )));

    onSuccessTransaction(txId);

    return null;
  }

  @override
  Object wrapError(dynamic error) {
    return parseWalletError(error);
  }
}
