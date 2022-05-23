part of wallet_ui_module;

void showWalletCreateDialog(BuildContext context) {
  showCSBottomSheet(
    context,
    (context) => WalletCreateDialog(isUseDialog: true),
    minHeight: 0,
    maxHeight: context.mediaHeight * 0.3,
  );
}

class WalletCreateDialog extends StatelessWidget {
  const WalletCreateDialog({
    this.addSpacer = false,
    this.isUseDialog = false,
  });

  final bool addSpacer;
  final bool isUseDialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.edgeHorizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (addSpacer) Spacer(),
          Text(
            tr('wallet:msg_create_wallet_title'),
            style: context.textBody(
              color: context.secondaryColor,
            ),
          ),
          WalletCreateButtons(
            isUseDialog: isUseDialog,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: context.edgeBottom,
            child: Text(
              tr('wallet:lbl_imtoken'),
              style: context.textSmall(
                color: context.placeholderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
