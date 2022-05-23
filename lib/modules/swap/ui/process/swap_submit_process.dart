part of swap_ui_module;

class SwapSubmitProcess {
  static void doApproveSwap(
    BuildContext context,
    SwapCreateVM viewModel, {

    /// If True user request a reset
    @required bool userReset,
    @required AssetCoin outCoinInfo,
    @required SwapConfigCoin outCoinConfig,
    @required Function(String) onSuccessTransaction,
  }) {
    var isReset = userReset;
    LoadingDialog.show(context);
    viewModel
        .doApproveSwap(
            outCoinInfo: outCoinInfo,
            outCoinConfig: outCoinConfig,
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
                coinInfo: outCoinInfo,
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
                chain: outCoinInfo.chain,
                getTransactionInfo: (txId) => viewModel.getTransactionInfo(
                  txId: txId,
                  chain: outCoinInfo.chain,
                  symbol: outCoinInfo.symbol,
                  fromAddress: outCoinInfo.address,
                  chainPrecision: outCoinInfo.chainPrecision,
                ),
                onConfirmed: (txId) {
                  if (isReset == true) {
                    Toast.show(tr('swap:create_msg_approve_reset_success'));
                  } else {
                    Toast.show(tr('swap:create_msg_approve_success'));
                  }
                  onSuccessTransaction(txId);
                },
              );
            })
        .catchError(
      (error) {
        LoadingDialog.dismiss(context);
        Toast.showError(error);
      },
    );
  }

  static void doSubmitSwap(
    BuildContext context,
    SwapCreateVM viewModel, {
    @required String amount,
    @required AssetCoin inCoinInfo,
    @required AssetCoin outCoinInfo,
    @required SwapConfigCoin inCoinConfig,
    @required SwapConfigCoin outCoinConfig,
    @required Function(String) onSuccessTransaction,
  }) {
    LoadingDialog.show(context);
    viewModel
        .doSubmitSwap(
      amount: amount,
      inCoinInfo: inCoinInfo,
      outCoinInfo: outCoinInfo,
      inCoinConfig: inCoinConfig,
      outCoinConfig: outCoinConfig,
      onConfirmSubmit: (params) {
        LoadingDialog.dismiss(context);
        return showSwapConfirmDialog(
          context,
          params: params,
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
      onNoticeDoubleTransaction: () {
        LoadingDialog.dismiss(context);
        return showWalletConfirmDoubleTransDialog(context);
      },
      onSuccessTransaction: (txId) {
        LoadingDialog.dismiss(context);
        onSuccessTransaction(txId);
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
