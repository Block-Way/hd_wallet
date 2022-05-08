part of trade_ui_module;

Future<bool> showTradeOrderConfirmDialog(
  BuildContext context, {
  @required TradePair tradePair,
  @required DexCreateOrderParams orderParams,
  @required AssetCoin Function({String chain, String symbol}) getCoinInfo,
}) {
  final response = Completer<bool>();

  final isBuy = orderParams.isBuy;
  final payAmount = orderParams.payAmount;

  final feeCoin = getCoinInfo(
    chain: orderParams.withdrawData.chain,
    symbol: orderParams.withdrawData.fee.feeSymbol,
  );
  final amountCoin = getCoinInfo(
    chain: isBuy ? tradePair.priceChain : tradePair.tradeChain,
    symbol: isBuy ? tradePair.priceSymbol : tradePair.tradeSymbol,
  );

  final priceCoin = getCoinInfo(
    chain: tradePair.priceChain,
    symbol: tradePair.priceSymbol,
  );

  final tradeCoin = getCoinInfo(
    chain: tradePair.tradeChain,
    symbol: tradePair.tradeSymbol,
  );

  final priceName = tr('asset:lbl_coin_name', namedArgs: {
    'name': priceCoin.symbol,
    'fullName': priceCoin.fullName,
  });
  final tradeName = tr('asset:lbl_coin_name', namedArgs: {
    'name': tradeCoin.symbol,
    'fullName': tradeCoin.fullName,
  });
  final amountName = tr('asset:lbl_coin_name', namedArgs: {
    'name': amountCoin.symbol,
    'fullName': amountCoin.fullName,
  });
  final feeName = tr('asset:lbl_coin_name', namedArgs: {
    'name': feeCoin.symbol,
    'fullName': feeCoin.fullName,
  });

  var canSubmit = true;
  var isFeeNeedDeposit = false;
  final isFeeSameChain = feeCoin.symbol == amountCoin.symbol;

  final confirmList = [
    CSConfirmItem(
      label: tr('trade:order_confirm_lbl_price'),
      notice: priceName,
      value: orderParams.price.toString(),
    ),
    CSConfirmItem(
      label: tr('trade:order_confirm_lbl_quantity'),
      notice: tradeName,
      value: orderParams.amount.toString(),
    ),
    CSConfirmItem(
      label: tr('trade:order_lbl_transaction_amount'),
      notice: priceName,
      value: orderParams.total.toString(),
    ),
    CSConfirmItem(
      label: tr('trade:order_lbl_miner_fee_confirm'),
      notice: feeName,
      value: orderParams.withdrawData.displayFee,
    ),
    if (isFeeSameChain)
      CSConfirmItem(
        label: tr('trade:order_confirm_dialog_lbl_total'),
        notice: amountName,
        value: NumberUtil.plus(
          payAmount,
          orderParams.withdrawData.fee.feeValue,
        ),
      ),
    if (!isFeeSameChain)
      CSConfirmItem(
        label: tr('trade:order_confirm_dialog_lbl_total'),
        notice: amountName,
        value: payAmount.toString(),
      ),
    if (!isFeeSameChain)
      CSConfirmItem(
        label: tr('trade:order_confirm_dialog_lbl_total_fee'),
        notice: feeName,
        value: orderParams.withdrawData.displayFee,
      ),
  ];

  // Check if I have enough balance to pay the total and the network fee
  final totalToPayFromBalance = isFeeSameChain
      ? NumberUtil.plus<double>(
          orderParams.withdrawData.fee.feeValue, payAmount)
      : payAmount;

  if (amountCoin.balance < totalToPayFromBalance) {
    canSubmit = false;
  }

  if (feeCoin.balance < orderParams.withdrawData.fee.feeValue) {
    canSubmit = false;
    isFeeNeedDeposit = true;
  }

  showCSTransactionDialog(
    context,
    title: tr('trade:order_confirm_dialog_title'),
    confirmList: confirmList,
    errorText: canSubmit
        ? ''
        : tr(
            'trade:order_confirm_dialog_msg_balance',
            namedArgs: {
              'symbol': isFeeNeedDeposit ? feeCoin.symbol : amountCoin.symbol
            },
          ),
    confirmBtnText: canSubmit
        ? tr('global:btn_continue')
        : tr('trade:order_confirm_dialog_btn_deposit'),
    onCancel: () {
      response.complete(false);
    },
    onConfirm: () {
      if (canSubmit) {
        response.complete(true);
      } else {
        AssetDepositPage.open(
          isFeeNeedDeposit ? feeCoin : amountCoin,
        );
      }
    },
  );

  return response.future;
}

Future<bool> showTradeOrderApproveDialog(
  BuildContext context, {
  @required AssetCoin coinInfo,
  @required WalletTemplateData approveData,

  /// User manually request a reset
  @required bool userReset,
  @required bool needReset,
  @required double currentBalance,
  @required double approveAmount,
  @required AssetCoin Function({String chain, String symbol}) getCoinInfo,
}) {
  final response = Completer<bool>();

  final feeCoin = getCoinInfo(
    chain: approveData.chain,
    symbol: approveData.feeSymbol,
  );
  final amountCoin = getCoinInfo(
    chain: coinInfo.chain,
    symbol: coinInfo.symbol,
  );

  final amountName = tr('asset:lbl_coin_name', namedArgs: {
    'name': amountCoin.symbol,
    'fullName': amountCoin.fullName,
  });

  final feeName = tr('asset:lbl_coin_name', namedArgs: {
    'name': feeCoin.symbol,
    'fullName': feeCoin.fullName,
  });

  var canSubmit = true;
  var isFeeNeedDeposit = false;

  final confirmList = [
    CSConfirmItem(
      label: tr('trade:order_confirm_approve_balance_lbl'),
      notice: amountName,
      value: currentBalance.toString(),
    ),
    CSConfirmItem(
      label: tr('trade:order_confirm_approve_max_lbl'),
      notice: amountName,
      value: approveAmount.toString(),
    ),
    CSConfirmItem(
      label: tr('trade:order_confirm_approve_fee_lbl'),
      notice: feeName,
      value: approveData.feeValue.toString(),
    ),
  ];

  // Check if I have enough balance to pay the total and the network fee
  final totalToPayFromBalance = approveData.feeValue;

  if (amountCoin.balance < totalToPayFromBalance) {
    canSubmit = false;
  }

  if (feeCoin.balance < approveData.feeValue) {
    canSubmit = false;
    isFeeNeedDeposit = true;
  }

  showCSTransactionDialog(
    context,
    title: tr('trade:order_confirm_approve_title'),
    confirmList: confirmList,
    errorText: canSubmit
        ? ''
        : tr(
            'trade:order_confirm_dialog_msg_balance',
            namedArgs: {
              'symbol': isFeeNeedDeposit ? feeName : amountName,
            },
          ),
    approveText: userReset
        ? tr('trade:order_confirm_approve_msg_balance_reset')
        : needReset
            ? tr('trade:order_confirm_approve_msg_balance_low')
            : tr('trade:order_confirm_approve_msg_balance_tip'),
    confirmBtnText: canSubmit
        ? needReset
            ? tr('global:btn_reset')
            : tr('global:btn_next')
        : tr('trade:order_confirm_dialog_btn_deposit'),
    onCancel: () {
      response.complete(false);
    },
    onConfirm: () {
      if (canSubmit) {
        response.complete(true);
      } else {
        AppNavigator.gotoTabBar();
        AssetDepositPage.open(isFeeNeedDeposit ? feeCoin : amountCoin);
      }
    },
  );

  return response.future;
}

void showTradeOrderTransactionPendingDialog(
  BuildContext context, {
  @required
      String chain,
  @required
      String txId,
  @required
      Future<Transaction> Function(
    String txId,
  )
          getTransactionInfo,
  @required
      void Function(String) onConfirmed,
}) {
  // Start check for txId
  Timer checkTxTimer;
  final checkStartTime = DateTime.now();
  bool isFetching = false;
  checkTxTimer = Timer.periodic(
    Duration(seconds: chain == 'TRX' ? 5 : 15),
    (timer) {
      if (isFetching) {
        return;
      }
      if (DateTime.now().difference(checkStartTime).inMinutes >= 5) {
        checkTxTimer.cancel();
        AppNavigator.goBack();
        Toast.show(tr('trade:order_approve_dialog_msg_failed'));
        return;
      }
      isFetching = true;
      getTransactionInfo(txId).then(
        (value) {
          if (value != null && value.confirmations >= 1) {
            checkTxTimer.cancel();
            AppNavigator.goBack();
            onConfirmed(txId);
            return;
          }
        },
      ).whenComplete(() {
        isFetching = false;
      });
    },
  );

  showCSBottomSheet(
    context,
    (context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.edgeAll.copyWith(top: 0),
          child: Text(
            tr('trade:order_approve_dialog_waiting_title'),
            style: context.textBody(bold: true),
          ),
        ),
        Padding(
          padding: context.edgeHorizontal,
          child: Text(
            tr('trade:order_approve_dialog_waiting_msg'),
            style: context.textSmall(lineHeight: 1.71),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 8),
          child: RiveAnimation(
            fileName: 'confirming',
            animation: 'Trade',
            width: context.mediaWidth,
            height: 118,
          ),
        ),
        Center(
          child: Text(
            tr('trade:order_approve_dialog_waiting_tip'),
            style: context.textSmall(),
          ),
        ),
      ],
    ),
    isDismissible: false,
    enableDrag: false,
  );
}
