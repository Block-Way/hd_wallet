part of dialogs;

class CSAlertDialog extends StatelessWidget {
  const CSAlertDialog({
    Key? key,
    this.title,
    this.titleStyle,
    this.confirmBtnText,
    this.confirmBtnStyle,
    this.onDismiss,
    this.onConfirm,
    this.onCancel,
    this.content,
    this.cancelBtnText,
    this.cancelBtnStyle,
    this.hideCancel = true,
    this.hideConfirm = false,
    this.child,
    this.contentPadding,
    this.dismissOnBgClick = true,
    this.dismissOnConfirm = true,
    this.rightTitle,
    this.rightTitleStyle,
    this.confirmTimeout,
  }) : super(key: key);

  /// dialog title
  final String? title;
  final TextStyle? titleStyle;

  final String? confirmBtnText;
  final TextStyle? confirmBtnStyle;
  final int? confirmTimeout;

  /// cancel button
  final String? cancelBtnText;
  final TextStyle? cancelBtnStyle;

  final String? rightTitle;
  final TextStyle? rightTitleStyle;

  /// dialog content
  final String? content;

  /// dialog close call back
  final void Function()? onDismiss;

  /// dialog close call back
  final void Function()? onConfirm;

  /// dialog close call back
  final void Function()? onCancel;

  final bool hideCancel;
  final bool hideConfirm;

  /// click background and back button  close dialog
  final bool dismissOnBgClick;

  final bool dismissOnConfirm;

  final Widget? child;

  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final width = context.mediaWidth;
    final height = context.mediaHeight;

    return CSBaseDialog(
      hideCancel: hideCancel,
      hideConfirm: hideConfirm,
      confirmBtnText: confirmBtnText ?? tr('global:btn_confirm'),
      confirmBtnStyle: confirmBtnStyle!,
      cancelBtnText: cancelBtnText ?? tr('global:btn_cancel'),
      cancelBtnStyle: cancelBtnStyle!,
      onConfirm: onConfirm!,
      onDismiss: onDismiss!,
      onCancel: onCancel!,
      dismissOnBgClick: dismissOnBgClick,
      dismissOnConfirm: dismissOnConfirm,
      confirmTimeout: confirmTimeout!,
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.edgeAll.copyWith(top: 24, bottom: 24),
            child: Center(
              child: Text(
                title ?? tr('global:dialog_alert_title'),
                textAlign: TextAlign.center,
                style: titleStyle ??
                    context.textBig(bold: true, color: context.iconColor),
              ),
            ),
          ),
          Padding(
            padding: contentPadding ?? context.edgeHorizontal16,
            child: Container(
              constraints: BoxConstraints(
                  minHeight: width * 0.48, maxHeight: height * 0.65),
              child: SingleChildScrollView(
                child: child ??
                    Padding(
                      padding: context.edgeBottom20,
                      child: Text(
                        content ?? '',
                        style: context.textBody(lineHeight: 1.67),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
