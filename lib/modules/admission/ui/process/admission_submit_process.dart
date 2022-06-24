part of admission_ui_module;

class AdmissionSubmitProcess {
  static void doSubmit({
    required BuildContext context,
    required AdmissionCreateVM viewModel,
    required AssetCoin coinInfo,
    required String toAddress,
    required String txData,
    required String amount,
    required AssetCoin Function({required String chain, required String symbol})
        getCoinInfo,
    required Function(String) onSuccessTransaction,
  }) {
    LoadingDialog.show(context);
    viewModel
        .doSubmitAdmission(
      coinInfo: coinInfo,
      toAddress: toAddress,
      txData: txData,
      amount: amount,
      onConfirmParams: (withdrawData) {
        LoadingDialog.dismiss(context);
        return showAdmissionConfirmDialog(
          context: context,
          withdrawData: withdrawData,
          coinInfo: coinInfo,
          amount: amount,
          getCoinInfo: getCoinInfo,
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
