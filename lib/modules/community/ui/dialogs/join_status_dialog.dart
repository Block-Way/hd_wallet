part of community_ui_module;

void showJoinStatusDialog(
  BuildContext context, {
  @required String message,
}) {
  showAlertDialog(
    context,
    title: tr('community:join_lbl_can_not_title'),
    content: message,
  );
}
