part of dialogs;

class CSBaseDialog extends StatelessWidget {
  const CSBaseDialog({
    Key key,
    this.contentWidget,
    this.cancelBtnText = 'cancel',
    this.confirmBtnText = 'confirm',
    this.cancelBtnStyle,
    this.confirmBtnStyle,
    this.dismissOnBgClick = true,
    this.dismissOnConfirm = true,
    this.onDismiss,
    this.onCancel,
    this.onConfirm,
    this.hideCancel = false,
    this.hideConfirm = false,
    this.confirmTimeout,
  }) : super(key: key);

  /// dialog content
  final Widget contentWidget;

  /// cancel button
  final String cancelBtnText;

  /// confirm button
  final String confirmBtnText;
  final TextStyle cancelBtnStyle;
  final TextStyle confirmBtnStyle;

  /// click background and back button to close dialog
  final bool dismissOnBgClick;
  final bool dismissOnConfirm;

  /// dialog close call back
  final void Function() onDismiss;

  /// dialog close call back
  final void Function() onCancel;

  /// dialog close call back
  final void Function() onConfirm;

  final bool hideCancel;
  final bool hideConfirm;

  final int confirmTimeout;

  void handleConfirm() {
    if (dismissOnConfirm) {
      dismiss();
    }
    if (onConfirm != null) {
      onConfirm();
    }
  }

  void handleCancel() {
    if (onCancel != null) {
      onCancel();
    }
    dismiss();
  }

  void dismiss() {
    AppNavigator.goBack();
    if (onDismiss != null) {
      onDismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return dismissOnBgClick;
      },
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: context.mediaWidth - 40,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: context.radiusAll,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contentWidget,
                Padding(
                  padding: context.edgeAll,
                  child: Row(
                    children: [
                      if (!hideCancel)
                        Expanded(
                          child: CSButton(
                            bordered: true,
                            backgroundColor: context.mainColor,
                            onPressed: handleCancel,
                            label: cancelBtnText,
                          ),
                        ),
                      if (!hideConfirm && !hideCancel)
                        SizedBox(width: context.edgeSize),
                      if (!hideConfirm)
                        Expanded(
                          child: confirmTimeout != null
                              ? CSButtonTimeout(
                                  onPressed: handleConfirm,
                                  countdown: confirmTimeout,
                                  btnText: confirmBtnText,
                                  btnColor: confirmBtnStyle != null
                                      ? confirmBtnStyle.color
                                      : context.bodyColor,
                                )
                              : CSButton(
                                  onPressed: handleConfirm,
                                  label: confirmBtnText,
                                ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
