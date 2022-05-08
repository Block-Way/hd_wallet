part of dialogs;

class CSOptionsItem<T> {
  CSOptionsItem({
    @required this.value,
    @required this.label,
    this.color,
    this.showBadge,
  });

  final T value;
  final String label;
  final bool showBadge;
  final Color color;
}

Future<void> showOptionsDialog<T>(
  BuildContext context, {
  List<CSOptionsItem<T>> options,
  Function(T value) onSelected,
}) {
  Widget buildOptionBtn({
    String label,
    T value,
    bool showBadge = false,
    Color color,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.greyColor,
            width: 0.5,
          ),
        ),
      ),
      child: CSButton(
        label: label,
        flat: true,
        textBold: false,
        padding: context.edgeVertical20,
        textColor: color ?? context.bodyColor,
        onPressed: () {
          AppNavigator.goBack();
          onSelected(value);
        },
        cmpRight: showBadge == true
            ? CSBadge(
                size: 6,
                color: context.redColor,
              )
            : Container(),
      ),
    );
  }

  return showCupertinoModalPopup(
    context: context,
    // filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
    filter: null,
    builder: (context) => CupertinoActionSheet(
      cancelButton: CSButton(
        label: tr('global:btn_cancel'),
        backgroundColor: context.bgPrimaryColor,
        textBold: false,
        textColor: context.labelColor,
        onPressed: () {
          AppNavigator.goBack();
        },
      ),
      actions: [
        Container(
          color: context.bgPrimaryColor,
          child: Column(
            children: [
              ...options.map(
                (e) => buildOptionBtn(
                  label: e.label,
                  value: e.value,
                  showBadge: e.showBadge,
                  color: e.color,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
