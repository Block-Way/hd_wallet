part of wallet_ui_module;

Future<bool> showWalletConfirmDoubleTransDialog(BuildContext context) {
  final response = Completer<bool>();

  showConfirmDialog(
    context,
    title: tr('asset:trans_confirm_title'),
    content: tr('asset:trans_confirm_tips'),
    confirmBtnText: tr('asset:trans_confirm_btn'),
    cancelBtnText: tr('global:btn_cancel'),
    onCancel: () {
      response.complete(false);
    },
    onConfirm: () {
      response.complete(true);
    },
  );

  return response.future;
}
