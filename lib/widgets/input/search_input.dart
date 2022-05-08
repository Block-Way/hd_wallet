part of widgets;

class CSSearchInput extends HookWidget {
  const CSSearchInput({
    @required this.onChanged,
    Key key,
    this.value = '',
    this.height = 50,
    this.radius,
    this.background,
    this.decoration,
    this.margin,
    this.cmpRight,
    this.showSearchIcon = true,
    this.autofocus = false,
    this.maxLength = 32,
    this.controller,
    this.hintText = '',
    this.hintStyle,
    this.inputStyle,
    this.onClear,
    this.onSubmitted,
  }) : super(key: key);

  final String value;
  final double height;
  final double radius;
  final Color background;
  final BoxDecoration decoration;
  final EdgeInsetsGeometry margin;
  final Widget cmpRight;
  final bool showSearchIcon;
  final bool autofocus;
  final int maxLength;
  final TextEditingController controller;
  final String hintText;
  final TextStyle hintStyle;
  final TextStyle inputStyle;
  final VoidCallback onClear;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final _controller = controller ?? useTextEditingController(text: value);

    return Container(
      margin: margin ?? context.edgeHorizontal,
      decoration: decoration ??
          context.boxDecoration(
            color: background,
            radius: radius,
          ),
      height: height,
      child: Row(
        children: [
          if (showSearchIcon)
            Padding(
              padding: context.edgeHorizontal8,
              child: Icon(
                CSIcons.Search,
                size: 16,
                color: context.secondaryColor,
              ),
            ),
          if (!showSearchIcon) SizedBox(width: context.edgeSize),
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: autofocus,
              maxLength: maxLength,
              style: inputStyle ??
                  context.textSmall(
                    color: context.bodyColor,
                  ),
              autocorrect: false, //是否自动更正
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
                hintStyle: hintStyle ?? context.textPlaceholder(),
                counterText: '',
              ),
              onChanged: onChanged,
              onSubmitted: (text) {
                if (onSubmitted != null) {
                  onSubmitted(text);
                }
              },
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) {
              return Offstage(
                offstage: value.text.isEmpty,
                child: CSButtonIcon(
                  icon: Icons.cancel,
                  size: 18,
                  padding: context.edgeAll.copyWith(right: 2),
                  background: Colors.transparent,
                  color: context.secondaryColor,
                  onPressed: () {
                    _controller.clear();
                    if (onClear != null) {
                      onClear();
                    }
                  },
                ),
              );
            },
          ),
          if (cmpRight != null) cmpRight
        ],
      ),
    );
  }
}
