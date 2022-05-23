part of invitation_ui_module;

class InvitationSubmitProcess {
  static void doSubmit({
    @required BuildContext context,
    @required InvitationCreateVM viewModel,
    @required AssetCoin coinInfo,
    @required String toAddress,
    @required String signCode,
    @required String sharePrvKey,
    @required String amount,
    @required AssetCoin Function({String chain, String symbol}) getCoinInfo,
    @required Function(String) onSuccessTransaction,
  }) {
    LoadingDialog.show(context);
    viewModel
        .doSubmitInvitation(
      coinInfo: coinInfo,
      toAddress: toAddress,
      signCode: signCode,
      sharePrvKey: sharePrvKey,
      amount: amount,
      onConfirmParams: (withdrawData) {
        LoadingDialog.dismiss(context);
        return showInvitationConfirmDialog(
          context: context,
          withdrawData: withdrawData,
          coinInfo: coinInfo,
          amount: amount,
          getCoinInfo: getCoinInfo,
        );
      },
      onConfirmSubmit: () => viewModel
          .checkDefiRelation(coinInfo.contract, toAddress)
          .then((_) => true)
          .catchError((error) {
        LoadingDialog.dismiss(context);
        final responseError = Request().getResponseError(error);
        if (responseError.statusCode == 400) {
          showAlertDialog(
            context,
            content: responseError.message ??
                tr('asset:invitation_create_defi_relation'),
          );
        } else {
          Toast.showError(error);
        }
        return false;
      }),
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
