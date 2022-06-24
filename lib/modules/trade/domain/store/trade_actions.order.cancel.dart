part of trade_domain_module;

class TradeActionOrderCancel extends _BaseAction {
  TradeActionOrderCancel({
    required this.order,
    required this.onUnlockWallet,
    required this.onSuccessTransaction,
    required this.onConfirmCancel,
    this.onConfirmSubmit,
  });

  final TradeOrder order;
  final Future<bool> Function()? onConfirmSubmit;
  final Future<bool> Function(double withdrawAmount) onConfirmCancel;
  final void Function(String txId) onSuccessTransaction;
  final Future<WalletPrivateData> Function() onUnlockWallet;

  @override
  Future<AppState?> reduce() async {
    /*
    final walletId = store.state.walletState.activeWalletId;

    final coinInfo = store.state.assetState.getCoinInfo(
      chain: order.chain,
      symbol: fixUSDTSymbol(order.symbol),
    );

    // Trade Coin Config for templateData
    final coinConfig = store.state.tradeState.getCoinConfig(
      chain: coinInfo.chain ?? '',
      symbol: coinInfo.symbol ?? '',
    );

    WalletWithdrawData withdrawData;
    WalletTemplateData? templateInfo;

    final dialogBalance = Completer<double>();
    store.dispatch(TradeActionGetOrderBalance(
      order: order,
      completer: dialogBalance,
    ));
    double? withdrawAmount = await dialogBalance.future;

    final canContinue = await onConfirmCancel(withdrawAmount);
    if (canContinue != true) {
      return null;
    }

    final forceBalance = Completer<double>();
    store.dispatch(TradeActionGetOrderBalance(
      order: order,
      completer: forceBalance,
      forceUpdate: true,
    ));
    withdrawAmount = await forceBalance.future;

    if (kChainsNeedUnspent.contains(coinInfo.chain)) {
      templateInfo = WalletTemplateData(
        chain: coinInfo.chain ?? '',
        symbol: coinInfo.symbol ?? '',
        templateHex: order.templateHex,
        templateData: {},
        templateAddress: order.templateAddress,
      );

      if (!order.isDealFail) {
        // FailOrder already have templateHex from API
        try {
          templateInfo = await TradeRepository().getOrderTemplateInfo(
            walletId: walletId!,
            chain: coinInfo.chain ?? '',
            chainPrecision: coinInfo.chainPrecision ?? 0,
            templateAddress: order.templateAddress,
          );
        } catch (error) {
          //if (templateInfo.templateHex == null) {
          //  rethrow;
          //}
        }
      }

      final utxosRequest = Completer<List<Map<String, dynamic>>>();
      dispatch(
        WalletActionGetUnspent(
          chain: coinInfo.chain ?? '',
          symbol: coinInfo.symbol ?? '',
          address: order.templateAddress,
          balance: coinInfo.balance ?? 0,
          forceUpdate: true,
          unspentType: 'dex',
          completer: utxosRequest,
        ),
      );
      final utxos = await utxosRequest.future;
      final fee = WalletWithdrawFeeData(
        feeRate: coinConfig.networkFee.toString(),
        feeValue: coinConfig.networkFee,
        feeUnit: coinInfo.symbol ?? '',
        feeSymbol: coinInfo.symbol ?? '',
      );
      withdrawData = WalletWithdrawData(
        chain: coinInfo.chain ?? '',
        symbol: coinInfo.symbol ?? '',
        toAddress: coinInfo.address,
        fromAddress: order.templateAddress,
        fee: fee,
        feeDefault: fee,
        utxos: utxos,
        contract: coinInfo.contract ?? '',
      );
      /*
      if (NumberUtil.minus<double>(
            withdrawAmount,
            withdrawData.fee.feeValue,
          )  <=
          0) {
        throw TradeLowBalanceForCancelError();
      }*/
      withdrawAmount = NumberUtil.minus<double>(
        withdrawAmount,
        withdrawData.fee.feeValue,
      );
    } else {
      // ETH/TRX
      final transInfo = await WalletRepository().dexCancelOrderTransaction(
        chain: coinInfo.chain ?? '',
        symbol: coinInfo.symbol ?? '',
        primaryKey: order.templateHex,
        sellAddress: coinInfo.address ?? '',
      );
      templateInfo = WalletTemplateData(
        chain: coinInfo.chain ?? '',
        symbol: coinInfo.symbol ?? '',
        templateHex: order.templateHex,
        templateData: transInfo,
        templateAddress: coinInfo.address ?? '',
      );
      final fee = WalletWithdrawFeeData(
        feeRate: templateInfo.trxSun.toString(),
        feeValue: templateInfo.feeValue,
        feeUnit: coinInfo.chain ?? '',
        feeSymbol: coinInfo.chain ?? '',
        gasLimit: templateInfo.gasLimit,
        gasPrice: templateInfo.gasPrice,
      );
      withdrawData = WalletWithdrawData(
        chain: order.chain,
        symbol: coinInfo.symbol ?? '',
        toAddress: coinInfo.address,
        fromAddress: coinInfo.address ?? '',
        fee: fee,
        feeDefault: fee,
        utxos: [],
        contract: coinInfo.contract ?? '',
      );

      final balance = state.walletState.activeWallet?.getCoinBalance(
        chain: order.chain,
        symbol: order.chain,
      );

      if (NumberUtil.isLess(balance, withdrawData.fee.feeValue)) {
        throw TradeFeeBalanceLowError();
      }
    }

    final walletData = await onUnlockWallet();

    String txId = '';
    if (order.isChainUseApiRawTx) {
      final submitTransaction = Completer<String>();
      dispatch(
        WalletActionSignAndSubmitRawTx(
          chain: withdrawData.chain,
          symbol: withdrawData.symbol,
          fromAddress: withdrawData.fromAddress,
          rawTx: templateInfo!.rawTx,
          walletData: walletData,
          completer: submitTransaction,
          onConfirmSubmit: onConfirmSubmit,
          broadcastType: 'dex',
          amount: 0,
        ),
      );
      txId = await submitTransaction.future;

      // WalletActionSignAndSubmitRawTx will not add a
      // Transaction record, we need to add it here
      dispatch(
        AssetActionAddTransaction(
          Transaction.fromRaw(
            txId: txId,
            chain: withdrawData.chain,
            symbol: withdrawData.symbol,
            feeValue: withdrawData.fee.feeValue,
            feeSymbol: withdrawData.fee.feeSymbol,
            amount: withdrawAmount ?? 0,
            toAddress: coinInfo.address ?? '',
            fromAddress: withdrawData.fromAddress,
            type: TransactionType.deposit,
          ),
        ),
      );
    } else {
      final submitTransaction = Completer<String>();
      dispatch(
        WalletActionWithdrawSubmit(
          params: WithdrawSubmitParams(
            withdrawData: withdrawData,
            amount: withdrawAmount ?? 0,
            chainPrecision: coinInfo.chainPrecision ?? 0,
            toAddress: coinInfo.address ?? '',
            txTemplateData: templateInfo!.templateHex,
            broadcastType: 'dex',
          ),
          walletData: walletData,
          completer: submitTransaction,
          onConfirmSubmit: onConfirmSubmit,
        ),
      );

      txId = await submitTransaction.future;
    }

    await dispatchAsync(
      TradeActionOrderAddCancelling(
        order,
        txId,
      ),
    );

    // 失败订单的特殊处理
    if (order.isDealFail) {
      //1.保留失败记录
      await dispatchAsync(
        WalletActionAddBroadcastTx(
          txId: txId,
          chain: withdrawData.chain,
          symbol: withdrawData.symbol,
          type: BroadcastTxType.tradeFailOrder,
          apiParams: order.templateId,
        ),
      );

      try {
        //2.提交失败记录
        await store.dispatchAsync(
          TradeActionSubmitCancelTxid(
            template: order.templateId,
            txId: txId,
          ),
        );
        //3.如果失败几率提交成功 删除失败记录
        await dispatchAsync(
          WalletActionDoneBroadcastTx(
            txId: txId,
            type: BroadcastTxType.tradeFailOrder,
          ),
        );
      } catch (_) {}
    }

    onSuccessTransaction(txId);
*/
    return null;
  }

  @override
  Object? wrapError(dynamic error) {
    return parseWalletError(error);
  }
}

class TradeActionSubmitCancelTxid extends _BaseAction {
  TradeActionSubmitCancelTxid({
    this.template,
    this.txId,
  });

  final String? template;
  final String? txId;

  @override
  Future<AppState?> reduce() async {
    await TradeRepository().postOrderDealFail(
      txId: txId!,
      template: template!,
      walletId: walletId,
    );
    return null;
  }
}

class TradeActionReSubmitCancelTxid extends _BaseAction {
  @override
  Future<AppState?> reduce() async {
    final broadcastRequest = Completer<List<BroadcastTxInfo>>();
    dispatch(WalletActionGetBroadcastsFailed(
      type: BroadcastTxType.tradeFailOrder,
      completer: broadcastRequest,
    ));

    final prevBroadcasts = await broadcastRequest.future;
    for (final item in prevBroadcasts) {
      try {
        // 重新提交
        await dispatchAsync(TradeActionSubmitCancelTxid(
          txId: item.txId,
          template: item.apiParams,
        ));

        // 提交成功 删除记录
        await dispatchAsync(WalletActionDoneBroadcastTx(
          txId: item.txId,
          type: BroadcastTxType.tradeFailOrder,
        ));
      } catch (_) {}
    }
    return null;
  }
}
