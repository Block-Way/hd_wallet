part of invitation_ui_module;

Future<bool> showInvitationConfirmDialog({
  required BuildContext context,
  required WalletWithdrawData withdrawData,
  required AssetCoin coinInfo,
  required String amount,
  required AssetCoin Function({
    required String chain,
    required String symbol,
  })
      getCoinInfo,
}) {
  final response = Completer<bool>();

  final feeCoin = getCoinInfo(
    chain: withdrawData.chain,
    symbol: withdrawData.fee.feeSymbol,
  );

  final isFeeSameChain = feeCoin.symbol == coinInfo.symbol;

  var payBalanceNotEnough = false;
  var feeBalanceNotEnough = false;

  final totalAmount = isFeeSameChain
      ? NumberUtil.plus<String>(withdrawData.fee.feeValue, amount)
      : amount;

  // 支付金额不足
  if (NumberUtil.isLess(coinInfo.balance, totalAmount)) {
    payBalanceNotEnough = true;
  }

  // 手续费余额不足
  if (NumberUtil.isLess(feeCoin.balance, withdrawData.fee.feeValue)) {
    feeBalanceNotEnough = true;
  }

  final canSubmit = !payBalanceNotEnough && !feeBalanceNotEnough;

  final confirmList = [
    CSConfirmItem(
      label: tr('invitation:defi_create_dialog_amount'),
      notice: coinInfo.name,
      value: amount,
    ),
    CSConfirmItem(
      label: tr('invitation:defi_create_dialog_fee'),
      notice: coinInfo.name,
      value: '${withdrawData.fee.feeValue}',
    ),
    CSConfirmItem(
      label: tr('invitation:defi_create_dialog_total_amount'),
      notice: coinInfo.name,
      value: totalAmount ?? '',
    ),
    if (!isFeeSameChain)
      CSConfirmItem(
        label: tr('invitation:defi_create_dialog_total_fee'),
        notice: coinInfo.name,
        value: '${withdrawData.fee.feeValue}',
      ),
  ];

  final errorText = payBalanceNotEnough
      ? tr(
          'invitation:defi_create_dialog_pay_balance_not_enough',
          namedArgs: {'symbol': coinInfo.name ?? ''},
        )
      : feeBalanceNotEnough
          ? tr(
              'invitation:defi_create_dialog_fee_balance_not_enough',
              namedArgs: {'symbol': feeCoin.name ?? ''},
            )
          : '';

  showCSTransactionDialog(
    context,
    title: tr('invitation:defi_create_dialog_title'),
    confirmList: confirmList,
    errorText: errorText,
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
        AssetDepositPage.open(feeBalanceNotEnough ? feeCoin : coinInfo);
      }
    },
  );

  return response.future;
}
