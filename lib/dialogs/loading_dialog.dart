part of dialogs;

bool _loadingDialogIsShowing = false;

class LoadingDialog {
  static void show<T extends dynamic>(
    BuildContext context, [
    String loadingText,
  ]) {
    _loadingDialogIsShowing = true;
    showDialog<T>(
      barrierDismissible: false,
      context: context,
      routeSettings: RouteSettings(name: 'loading_dialog'),
      barrierColor: context.backdropColor,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: CSContainer(
            width: 150,
            height: 150,
            child: RiveAnimation(
              fileName: 'loading',
              animation: 'Untitled 1',
              width: 150,
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CSProgressIndicator(
            //       size: 25,
            //       color: context.primaryColor,
            //     ),
            //     SizedBox(width: context.edgeSizeDouble),
            //     Text(
            //       loadingText ?? tr('global:lbl_loading'),
            //       style: context.textBody(),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  static void dismiss(BuildContext context) {
    if (_loadingDialogIsShowing) {
      _loadingDialogIsShowing = false;
      Navigator.of(context).pop();
    }
  }
}
