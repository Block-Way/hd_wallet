part of trade_ui_module;

class TradeOrderSubmitProcess {
  static void doApproveOrder(
    BuildContext context,
    TradeHomeVM viewModel, {

    /// If True user request a reset
    @required bool userReset,
    @required AssetCoin coinInfo,
    @required Function(String) onSuccessTransaction,
  }) {
    var isReset = userReset;
    LoadingDialog.show(context);
    viewModel
        .doApproveOrder(
      tradePair: viewModel.tradePair,
      tradeSide: viewModel.tradeSide,
      onConfirmSubmit: ({
        approveData,
        currentBalance,
        approveAmount,
        needReset,
      }) {
        isReset = userReset || needReset;
        LoadingDialog.dismiss(context);
        return showTradeOrderApproveDialog(
          context,
          coinInfo: coinInfo,
          approveData: approveData,
          currentBalance: currentBalance,
          approveAmount: approveAmount,
          needReset: needReset,
          userReset: userReset,
          getCoinInfo: viewModel.getCoinInfo,
        );
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
        showTradeOrderTransactionPendingDialog(
          context,
          txId: txId,
          chain: coinInfo.chain,
          getTransactionInfo: (txId) => viewModel.getTransactionInfo(
            txId: txId,
            chain: coinInfo.chain,
            symbol: coinInfo.symbol,
            fromAddress: coinInfo.address,
            chainPrecision: coinInfo.chainPrecision,
          ),
          onConfirmed: (txId) {
            if (isReset == true) {
              Toast.show(tr('trade:order_msg_approve_reset_success'));
            } else {
              Toast.show(tr('trade:order_msg_approve_success'));
            }
            onSuccessTransaction(txId);
          },
        );
      },
    )
        .catchError(
      (error) {
        LoadingDialog.dismiss(context);
        Toast.showError(error);
      },
    );
  }

  static void doCreateOrder(
    BuildContext context,
    TradeHomeVM viewModel, {
    @required String price,
    @required String amount,
    @required String total,
    @required Function(String) onSuccessTransaction,
  }) {
    LoadingDialog.show(context);
    viewModel
        .doCreateOrder(
      tradeSide: viewModel.tradeSide,
      tradePair: viewModel.tradePair,
      price: price,
      amount: amount,
      total: total,
      onConfirmSubmit: (params) {
        LoadingDialog.dismiss(context);
        return showTradeOrderConfirmDialog(
          context,
          tradePair: viewModel.tradePair,
          getCoinInfo: viewModel.getCoinInfo,
          orderParams: params,
        );
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
        Toast.show(tr('trade:order_msg_order_success'));
        onSuccessTransaction(txId);
      },
    )
        .catchError(
      (error) {
        AnalyticsReport().reportLog('Trade_SubmitError', {
          'walletId': viewModel.activeWalletId,
          'tradePair': viewModel.tradePair.id,
          'price': price,
          'amount': amount,
        });
        LoadingDialog.dismiss(context);
        Toast.showError(error);
      },
    );
  }
}
