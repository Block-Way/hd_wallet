part of dialogs;

void showCSBottomSheet(
  BuildContext context,
  WidgetBuilder builder, {

  /// if false, scroll need child manage
  bool scrollable = false,
  bool enableDrag = true,
  bool isDismissible = true,
  double maxHeight,
  double minHeight,
}) {
  final height = context.mediaHeight;
  final dragHeight = enableDrag ? 40.0 : 10.0;
  final _maxHeight = maxHeight ?? height * 0.8;
  final _minHeight = minHeight ?? height * 0.4;

  final radiusTop = BorderRadius.vertical(
    top: Radius.circular(30.0),
  );

  showModalBottomSheet<void>(
    context: context,
    enableDrag: enableDrag,
    isDismissible: isDismissible,
    isScrollControlled: true,
    barrierColor: context.backdropColor,
    shape: RoundedRectangleBorder(
      borderRadius: radiusTop,
    ),
    builder: (context) => Padding(
      /// Add padding when Keyboard is shown
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radiusTop,
          color: context.bgPrimaryColor,
        ),
        constraints: BoxConstraints(
          maxHeight: _maxHeight + dragHeight,
          minHeight: _minHeight + dragHeight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: dragHeight,
              width: double.infinity,
              child: Center(
                child: enableDrag
                    ? Container(
                        width: 36,
                        height: 5,
                        decoration: BoxDecoration(
                          color: context.borderColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      )
                    : SizedBox(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: radiusTop,
                color: context.bgPrimaryColor,
              ),
              // If Keyboard is visible, do not add SafeAreaView bottom padding
              // If there is not Keyboard, add SafeAreaView bottom padding
              padding: MediaQuery.of(context).viewInsets.bottom > 0
                  ? context.edgeTop10
                  : MediaQuery.of(context).viewPadding.copyWith(top: 10),
              constraints: BoxConstraints(
                maxHeight: _maxHeight,
                minHeight: _minHeight,
              ),
              child: scrollable
                  ? SingleChildScrollView(child: builder(context))
                  : builder(context),
            )
          ],
        ),
      ),
    ),
  );
}
