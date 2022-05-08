part of dialogs;

void showCSDialog(BuildContext context, WidgetBuilder builder) {
  showGeneralDialog(
    context: context,
    barrierColor: context.backdropColor,
    barrierDismissible: false,
    transitionBuilder: (context, a1, a2, widget) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Builder(builder: builder),
            ),
          ),
        ],
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) => null,
  );
}

void showAlertDialog(
  BuildContext context, {
  @required String content,
  String title,
  void Function() onDismiss,
}) {
  showCSDialog(
    context,
    (_) => CSAlertDialog(
      title: title,
      content: content,
      onDismiss: onDismiss,
    ),
  );
}

void showConfirmDialog(
  BuildContext context, {
  @required String content,
  @required void Function() onConfirm,
  void Function() onCancel,
  String title,
  TextStyle titleStyle,
  String cancelBtnText,
  TextStyle cancelBtnStyle,
  String confirmBtnText,
  TextStyle confirmBtnStyle,
  int confirmTimeout,
}) {
  showCSDialog(
    context,
    (_) => CSAlertDialog(
      title: title,
      titleStyle: titleStyle,
      content: content,
      confirmBtnText: confirmBtnText,
      confirmBtnStyle: confirmBtnStyle,
      confirmTimeout: confirmTimeout,
      hideCancel: false,
      cancelBtnText: cancelBtnText,
      cancelBtnStyle: cancelBtnStyle ?? context.textBody(),
      onCancel: onCancel,
      onConfirm: onConfirm,
    ),
  );
}
