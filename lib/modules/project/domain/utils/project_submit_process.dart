part of project_domain_module;

class ProjectSubmitProcess {
  static void doSubmitProject(
    BuildContext context,
    ProjectApplyVM viewModel, {
    @required ProjectCreateParams projectParams,
  }) {
    LoadingDialog.show(context);

    viewModel
        .doSubmitProject(
      params: projectParams,
      onConfirmData: (params) {
        LoadingDialog.dismiss(context);
        return showProjectConfirmDialog(
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
          (password) => viewModel.doUnlockHDWallet(password),
          (walletData, _) {
            LoadingDialog.show(context);
            completer.complete(walletData);
          },
        );
        return completer.future;
      },
      onSuccessTransaction: (txId) {
        LoadingDialog.dismiss(context);

        /// TODO: go back? or go detail?
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
