part of trade_ui_module;

class TradeOrderCancelProcess {
  static void doCancelOrder(
    BuildContext context,
    TradeHomeVM viewModel, {
    @required TradeOrder order,
    @required Function(String) onSuccessTransaction,
  }) {
    LoadingDialog.show(context);
    viewModel
        .doCancelOrder(
      order: order,
      onConfirmCancel: (withdrawAmount) {
        LoadingDialog.dismiss(context);
        final completer = Completer<bool>();
        showCSDialog(
          context,
          (_) => CSAlertDialog(
            confirmBtnText: tr('trade:order_confirm_cancel_btn'),
            hideCancel: false,
            cancelBtnStyle: context.textBody(),
            onConfirm: () {
              LoadingDialog.show(context);
              completer.complete(true);
            },
            onCancel: () {
              completer.complete(false);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr(order.statusCancelMsg),
                  style: context.textBody(lineHeight: 1.67),
                ),
                SizedBox(height: 30),
                Text(
                  tr('trade:order_confirm_cancel_amount'),
                  style: context.textSmall(),
                ),
                SizedBox(height: 8),
                Text(
                  '$withdrawAmount ${order.symbol}',
                  style: context.textMedium(bold: true),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
        return completer.future;
      },
      onUnlockWallet: () {
        LoadingDialog.dismiss(context);
        final completer = Completer<WalletPrivateData>();
        showPasswordDialog(
          context,
          (password) => viewModel.doUnlockWallet(password),
          (walletData, _) {
            LoadingDialog.show(context);
            completer.complete(walletData);
          },
        );
        return completer.future;
      },
      onSuccessTransaction: (txId) {
        LoadingDialog.dismiss(context);
        Toast.show(tr('trade:order_msg_order_cancelled'));
        if (onSuccessTransaction != null) {
          onSuccessTransaction(txId);
        }
      },
    )
        .catchError(
      (error) {
        LoadingDialog.dismiss(context);
        Toast.showError(error);
      },
    );
  }
}
