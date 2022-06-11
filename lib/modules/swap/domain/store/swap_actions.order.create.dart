part of swap_domain_module;

class SwapCreateParams {
  SwapCreateParams({
    required this.amount,
    required this.outCoinInfo,
    required this.inCoinInfo,
    required this.outCoinConfig,
    required this.inCoinConfig,
  });

  final double amount;
  final AssetCoin outCoinInfo;
  final AssetCoin inCoinInfo;
  final SwapConfigCoin outCoinConfig;
  final SwapConfigCoin inCoinConfig;
  WalletTemplateData? templateData;

  /// If true, this chain used API to create Order transaction RawTx
  bool get isChainUseApiRawTx => ['ETH', 'TRX'].contains(outCoinInfo.chain);
}

class SwapActionSwapSubmit extends _BaseAction {
  SwapActionSwapSubmit({
    required this.outCoinInfo,
    required this.inCoinInfo,
    required this.outCoinConfig,
    required this.inCoinConfig,
    required this.amount,
    required this.onNoticeDoubleTransaction,
    required this.onConfirmSubmit,
    required this.onUnlockWallet,
    required this.onSuccessTransaction,
  });

  final AssetCoin outCoinInfo;
  final AssetCoin inCoinInfo;
  final SwapConfigCoin outCoinConfig;
  final SwapConfigCoin inCoinConfig;
  final String amount;
  final Future<bool> Function() onNoticeDoubleTransaction;
  final Future<WalletPrivateData> Function() onUnlockWallet;
  final Future<bool> Function(SwapCreateParams) onConfirmSubmit;
  final void Function(String txId) onSuccessTransaction;

  @override
  Future<AppState?> reduce() async {
    /*
    final params = SwapCreateParams(
      amount: NumberUtil.getDouble(amount),
      outCoinInfo: outCoinInfo,
      inCoinInfo: inCoinInfo,
      inCoinConfig: inCoinConfig,
      outCoinConfig: outCoinConfig,
    );

    var txId = '';

    // Check if USDT-BBC contract has enough balance
    final completer = Completer<double>();
    store.dispatch(AssetActionGetCoinBalance(
      wallet: store.state.walletState.activeWallet,
      chain: params.inCoinConfig.chain,
      symbol: params.inCoinConfig.symbol,
      address: params.inCoinConfig.address,
      ignoreUnspent: true,
      ignoreBalanceLock: true,
      completer: completer,
    ));
    final poolBalance = await completer.future;
    if (NumberUtil.isGreater(amount, poolBalance)) {
      throw SwapPoolBalanceLowError();
    }

    if (params.isChainUseApiRawTx) {
      // Check again balance
      final approveBalance = await SwapRepository().getApproveBalance(
        chain: outCoinInfo.chain,
        symbol: outCoinInfo.symbol,
        address: outCoinInfo.address,
        contract: outCoinInfo.contract,
        chainPrecision: outCoinInfo.chainPrecision,
      );
      if (NumberUtil.isGreater(amount, approveBalance)) {
        throw SwapApproveBalanceLowError();
      }

      final payAmount = NumberUtil.getAmountAsInt(
        params.amount,
        outCoinInfo.chainPrecision,
      );

      final json = await SwapRepository().postCreateTransaction(
        chain: params.outCoinInfo.chain,
        symbol: params.outCoinInfo.symbol,
        fromAddress: params.outCoinInfo.address,
        fromContract: params.outCoinInfo.contract,
        toAddress: params.inCoinInfo.address,
        toContract: params.inCoinInfo.contract,
        amount: payAmount,
      );
      params.templateData = WalletTemplateData(
        chain: params.outCoinInfo.chain,
        symbol: params.outCoinInfo.symbol,
        templateData: json,
        templateAddress: '',
        templateHex: '',
      );

      final canContinue = await onConfirmSubmit(params);
      if (canContinue != true) {
        return null;
      }

      final walletData = await onUnlockWallet();
      if (walletData == null) {
        return null;
      }

      final requestSubmit = Completer<String>();
      dispatch(WalletActionSignAndSubmitRawTx(
        chain: params.outCoinInfo.chain,
        symbol: params.outCoinInfo.symbol,
        rawTx: params.templateData.rawTx,
        walletData: walletData,
        fromAddress: params.outCoinInfo.address,
        broadcastType: '',
        completer: requestSubmit,
        amount: NumberUtil.getDouble(params.amount),
      ));
      txId = await requestSubmit.future;
    } else {
      final txData = {
        'chain': params.inCoinInfo.chain == 'ETH' ? 'ether' : 'tron',
        'contract': params.inCoinInfo.contract,
        'address': params.inCoinInfo.address,
      };

      final withdrawDataRequest = Completer<WalletWithdrawData>();
      dispatch(WalletActionWithdrawBefore(
        params: WithdrawBeforeParams(
          chain: params.outCoinInfo.chain,
          symbol: params.outCoinInfo.symbol,
          fromAddress: params.outCoinInfo.address,
          amount: NumberUtil.getDouble(amount),
          chainPrecision: params.outCoinInfo.chainPrecision,
          contractOrForkId: params.outCoinInfo.contract,
          toAddress: params.outCoinConfig.address,
          txData: '${AppConstants.swapUUID}0000000000${jsonEncode(txData)}',
        ),
        ignoreAddressCheck: true,
        completer: withdrawDataRequest,
      ));
      final withdrawData = await withdrawDataRequest.future;

      params.templateData = WalletTemplateData(
        chain: params.outCoinInfo.chain,
        symbol: params.outCoinInfo.symbol,
        templateData: {
          'fee': withdrawData.fee.feeValue,
        },
        templateAddress: '',
        templateHex: '',
      );

      final canContinue = await onConfirmSubmit(params);
      if (canContinue != true) {
        return null;
      }

      final walletData = await onUnlockWallet();
      if (walletData == null) {
        return null;
      }

      final submitTransaction = Completer<String>();
      dispatch(WalletActionWithdrawSubmit(
        params: WithdrawSubmitParams(
          withdrawData: withdrawData,
          amount: NumberUtil.getDouble(amount),
          chainPrecision: params.outCoinInfo.chainPrecision,
          toAddress: params.outCoinConfig.address,
          txData: jsonEncode(txData),
          txDataUUID: AppConstants.swapUUID,
          dataType: BbcDataType.withData,
        ),
        walletData: walletData,
        completer: submitTransaction,
      ));
      txId = await submitTransaction.future;
    }

    dispatch(AssetActionAddTransaction(Transaction.fromRaw(
      txId: txId,
      chain: params.outCoinInfo.chain,
      symbol: params.outCoinInfo.symbol,
      feeValue: params.templateData.feeValue,
      feeSymbol: params.outCoinInfo.chain,
      amount: params.amount,
      toAddress: params.templateData.contract,
      fromAddress: params.outCoinInfo.address,
      type: TransactionType.approveCall,
    )));

    onSuccessTransaction(txId);
    */
    return null;
  }

  @override
  Object? wrapError(dynamic error) {
    return error;
  }
}
