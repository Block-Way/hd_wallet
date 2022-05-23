part of swap_ui_module;

void showSwapTipDialog(BuildContext context) {
  showCSBottomSheet(
    context,
    (context) => CSContainer(
      margin: context.edgeHorizontal,
      padding: context.edgeBottom,
      radius: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('global:dialog_alert_title'),
            style: context.textBody(
              bold: true,
            ),
          ),
          SizedBox(height: context.edgeSize),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                tr('swap:create_tip_dialog_content'),
                style: context.textSecondary(
                  color: context.bodyColor,
                  lineHeight: 1.61,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: CSButton(
              label: tr('global:btn_close'),
              onPressed: () {
                AppNavigator.goBack();
              },
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    ),
    maxHeight: context.mediaHeight * 0.5,
  );
}
