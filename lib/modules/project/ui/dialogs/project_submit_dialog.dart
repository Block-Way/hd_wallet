part of project_ui_module;

Future<bool> showProjectConfirmDialog(
  BuildContext context, {
  @required ProjectCreateParams params,
  @required AssetCoin Function({String chain, String symbol}) getCoinInfo,
}) {
  final response = Completer<bool>();

  final feeCoin = getCoinInfo(
    chain: params.withdrawData.chain,
    symbol: params.withdrawData.fee.feeSymbol,
  );

  final payCoin = getCoinInfo(
    chain: params.chain,
    symbol: params.symbol,
  );

  final isFeeSameChain = feeCoin.symbol == params.symbol;
  final payAmount = NumberUtil.getDouble(params.amount);

  final feeSymbol = params.withdrawData.fee.feeSymbol;

  final outCoinName = params.symbol;

  var canSubmit = true;
  var isFeeNeedDeposit = false;

  // Check if I have enough balance to pay the total and the network fee
  final totalToPayFromBalance = isFeeSameChain
      ? NumberUtil.plus<double>(params.withdrawData.fee, payAmount)
      : payAmount;

  if (payCoin.balance < totalToPayFromBalance) {
    canSubmit = false;
  }

  if (feeCoin.balance < params.withdrawData.fee.feeValue) {
    canSubmit = false;
    isFeeNeedDeposit = true;
  }

  final realAmount = NumberUtil.minus<double>(payAmount, 0);

  final confirmList = [
    {
      'label': tr('swap:confirm_dialog_lbl_pay_amount',
          namedArgs: {'symbol': outCoinName}),
      'value': payAmount,
    },
    {
      'label':
          tr('swap:confirm_dialog_lbl_fee', namedArgs: {'symbol': feeSymbol}),
      'value': params.withdrawData.displayFee,
    },
    {
      'label': tr('swap:confirm_dialog_lbl_real_amount',
          namedArgs: {'symbol': 'payCoin'}),
      'value': realAmount > 0 ? realAmount : '-',
    },
  ];

  showCSDialog(
    context,
    (context) => CSAlertDialog(
      title: tr('trade:order_confirm_dialog_title'),
      confirmBtnText: canSubmit
          ? tr('global:btn_continue')
          : tr('trade:order_confirm_dialog_btn_deposit'),
      confirmBtnStyle: context.textBody(bold: true),
      hideCancel: false,
      dismissOnBgClick: false,
      cancelBtnText: tr('global:btn_return'),
      cancelBtnStyle: context.textBody(),
      contentPadding: EdgeInsets.zero,
      onCancel: () {
        response.complete(false);
      },
      onConfirm: () {
        if (canSubmit) {
          response.complete(true);
        } else {
          response.complete(false);
          AssetDepositPage.open(isFeeNeedDeposit ? feeCoin : payCoin);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: context.edgeAll.copyWith(top: 0),
            alignment: Alignment.centerLeft,
            child: Wrap(
              runSpacing: 20,
              children: [
                ...confirmList
                    .map(
                      (item) => SizedBox(
                        width: context.mediaWidth * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['label'].toString(),
                              style: context.textSmall(),
                            ),
                            SizedBox(height: 10),
                            Text(
                              item['value'].toString(),
                              style: context.textSecondary(
                                bold: true,
                                color: context.bodyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          if (!canSubmit)
            Padding(
              padding: context.edgeHorizontal,
              child: Text(
                tr(
                  'swap:lbl_insufficient_balance',
                  namedArgs: {
                    'symbol': isFeeNeedDeposit ? feeSymbol : outCoinName
                  },
                ),
                style: context.textSmall(color: context.redColor),
              ),
            ),
          SizedBox(height: context.edgeSize),
        ],
      ),
    ),
  );
  return response.future;
}
