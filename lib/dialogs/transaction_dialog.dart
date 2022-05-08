part of dialogs;

class CSConfirmItem {
  CSConfirmItem({
    @required this.label,
    @required this.value,
    this.notice,
  });

  final String label;
  final String notice;
  final String value;
}

void showCSTransactionDialog(
  BuildContext context, {
  @required List<CSConfirmItem> confirmList,
  String title,
  String cancelBtnText,
  String confirmBtnText,
  String errorText,
  String approveText,
  void Function() onCancel,
  void Function() onConfirm,
  bool isDismissible = true,
  Widget subtitleWidget,
}) {
  showCSBottomSheet(
    context,
    (context) => Container(
      padding: context.edgeHorizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.edgeBottom16,
            child: Text(
              title,
              style: context.textBody(bold: true),
            ),
          ),
          if (subtitleWidget != null)
            Padding(
              padding: context.edgeBottom16,
              child: subtitleWidget,
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...confirmList.map(
                    (item) => Container(
                      padding: context.edgeBottom16,
                      width: context.mediaWidth - context.edgeSizeDouble,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.label ?? '-',
                            style: context.textSmall(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  item.value ?? '-',
                                  style: context.textSmall(
                                    color: context.bodyColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                item.notice ?? '',
                                style: context.textSmall(
                                  color: context.bodyColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (approveText != null && approveText.isNotEmpty)
                    Text(
                      approveText ?? '',
                      style: context.textSmall(
                        color: context.redColor,
                      ),
                    ),
                  if (errorText != null && errorText.isNotEmpty)
                    Padding(
                      padding: context.edgeTop5,
                      child: Text(
                        errorText ?? '-',
                        style: context.textSmall(color: context.redColor),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: context.edgeAll,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: CSButton(
                    label: cancelBtnText ?? tr('global:btn_cancel'),
                    bordered: true,
                    backgroundColor: context.bgPrimaryColor,
                    onPressed: () {
                      AppNavigator.goBack();
                      if (onCancel != null) {
                        onCancel();
                      }
                    },
                  ),
                ),
                SizedBox(width: context.edgeSize),
                Flexible(
                  child: CSButton(
                    label: confirmBtnText,
                    onPressed: () {
                      AppNavigator.goBack();
                      if (onConfirm != null) {
                        onConfirm();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    isDismissible: isDismissible,
    maxHeight: context.mediaHeight * 0.65,
  );
}
