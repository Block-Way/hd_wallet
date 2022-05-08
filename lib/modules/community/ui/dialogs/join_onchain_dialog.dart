part of community_ui_module;

void showJoinOnChainDialog(BuildContext context, String userName) {
  showCSBottomSheet(
    context,
    (context) => CSContainer(
      margin: context.edgeHorizontal,
      padding: context.edgeBottom,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('community:detail_msg_leader'),
            style: context.textBody(bold: true),
          ),
          CSContainer(
            margin: context.edgeVertical.copyWith(top: context.edgeSizeDouble),
            secondary: true,
            padding: context.edgeAll.copyWith(
              top: context.edgeSizeDouble,
              bottom: context.edgeSizeDouble,
            ),
            child: Text(
              userName,
              style: context.textSecondary(
                bold: true,
                color: context.bodyColor,
              ),
            ),
          ),
          Text(
            tr('community:detail_msg_tips1'),
            style: context.textSmall(
              color: context.redColor,
              lineHeight: 1.61,
            ),
          ),
          Text(
            tr('community:detail_msg_tips2'),
            style: context.textSmall(
              color: context.redColor,
              lineHeight: 1.61,
            ),
          ),
          SizedBox(height: 60),
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
                  label: tr('community:detail_btn_copy'),
                  onPressed: () {
                    copyTextToClipboard(userName);
                    Toast.show(tr('global:msg_copy_success'));
                    AppNavigator.goBack();
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
