part of community_ui_module;

void showConfirmAgreementDialog(
  BuildContext context,
  void Function() onConfirm,
) {
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
            tr('community:create_lbl_agreement'),
            style: context.textBody(
              bold: true,
            ),
          ),
          SizedBox(height: context.edgeSize),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                tr('community:create_lbl_agreement_content'),
                style: context.textSecondary(
                  color: context.bodyColor,
                  lineHeight: 1.61,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CSButton(
                  label: tr('global:btn_cancel'),
                  onPressed: () {
                    AppNavigator.goBack();
                  },
                  bordered: true,
                  backgroundColor: context.bgPrimaryColor,
                ),
              ),
              SizedBox(width: context.edgeSize),
              Flexible(
                child: CSButton(
                  label: tr('community:create_btn_approve_submit'),
                  onPressed: () {
                    AppNavigator.goBack();
                    onConfirm();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
