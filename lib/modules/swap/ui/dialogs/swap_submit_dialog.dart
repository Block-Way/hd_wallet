part of swap_ui_module;

Future<bool> showSwapConfirmDialog(
  BuildContext context, {
  @required SwapCreateParams params,
  @required AssetCoin Function({String chain, String symbol}) getCoinInfo,
}) {
  final response = Completer<bool>();

  final feeCoin = getCoinInfo(
    chain: params.templateData.chain,
    symbol: params.templateData.feeSymbol,
  );

  final isFeeSameChain = feeCoin.symbol == params.outCoinInfo.symbol;
  final payAmount = NumberUtil.getDouble(params.amount);

  final outCoinName = tr('asset:lbl_coin_name', namedArgs: {
    'name': params.outCoinInfo.symbol,
    'fullName': params.outCoinInfo.fullName,
  });

  final inCoinName = tr('asset:lbl_coin_name', namedArgs: {
    'name': params.inCoinInfo.symbol,
    'fullName': params.inCoinInfo.fullName,
  });

  final feeCoinName = tr('asset:lbl_coin_name', namedArgs: {
    'name': feeCoin.symbol,
    'fullName': feeCoin.fullName,
  });

  var payBalanceNotEnough = false;
  var feeBalanceNotEnough = false;

  // Check if I have enough balance to pay the total and the network fee
  final totalAmount = isFeeSameChain
      ? NumberUtil.plus<double>(params.templateData.feeValue, payAmount)
      : payAmount;

  if (NumberUtil.isLess(params.outCoinInfo.balance, totalAmount)) {
    payBalanceNotEnough = true;
  }

  if (NumberUtil.isLess(feeCoin.balance, params.templateData.feeValue)) {
    feeBalanceNotEnough = true;
  }

  final canSubmit = !payBalanceNotEnough && !feeBalanceNotEnough;

  final confirmList = [
    CSConfirmItem(
      label: tr('swap:confirm_dialog_lbl_pay_amount'),
      notice: outCoinName,
      value: '$payAmount',
    ),
    CSConfirmItem(
      label: tr('swap:confirm_dialog_lbl_in_amount'),
      notice: inCoinName,
      value: '$payAmount',
    ),
    CSConfirmItem(
      label: tr('swap:confirm_dialog_lbl_real_amount'),
      notice: inCoinName,
      value: NumberUtil.minus<String>(
        payAmount,
        params.inCoinConfig.transferFee,
      ),
    ),
    CSConfirmItem(
      label: tr('swap:confirm_dialog_lbl_fee'),
      notice: feeCoinName,
      value: '${params.templateData.feeValue}',
    ),
  ];

  final errorText = payBalanceNotEnough
      ? tr(
          'swap:confirm_dialog_pay_balance_not_enough',
          namedArgs: {'symbol': outCoinName},
        )
      : feeBalanceNotEnough
          ? tr(
              'swap:confirm_dialog_fee_balance_not_enough',
              namedArgs: {'symbol': feeCoinName},
            )
          : '';

  showCSTransactionDialog(
    context,
    title: tr('swap:confirm_dialog_title'),
    confirmList: confirmList,
    errorText: errorText,
    approveText: tr('swap:create_msg_tip_network'),
    confirmBtnText:
        canSubmit ? tr('global:btn_continue') : tr('asset:lbl_deposit'),
    onCancel: () {
      response.complete(false);
    },
    onConfirm: () {
      if (canSubmit) {
        response.complete(true);
      } else {
        AppNavigator.gotoTabBar();
        AssetDepositPage.open(
          feeBalanceNotEnough ? feeCoin : params.outCoinInfo,
        );
      }
    },
  );

  return response.future;
}
