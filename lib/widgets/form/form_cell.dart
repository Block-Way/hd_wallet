part of widgets;

class FormCell extends StatelessWidget {
  const FormCell({
    Key key,
    this.hidden = false,
    this.height = 64,
    this.autoHeight = false,
    this.padding,
    this.label,
    this.labelStyle,
    this.onPress,
    this.child,
    this.cmpLeft,
    this.cmpRight,
    this.hideAccess = false,
    this.showBorderTop = false,
    this.showBorderBottom = false,
    this.borderTop,
    this.borderBottom,
  }) : super(key: key);

  final bool hidden;
  final double height;
  final bool autoHeight;
  final EdgeInsetsGeometry padding;
  final String label;
  final TextStyle labelStyle;
  final VoidCallback onPress;
  final Widget child;
  final Widget cmpLeft;
  final Widget cmpRight;
  final bool hideAccess;
  final bool showBorderTop;
  final bool showBorderBottom;
  final BorderSide borderTop;
  final BorderSide borderBottom;

  @override
  Widget build(BuildContext context) {
    if (hidden) {
      return SizedBox();
    }
    return InkWell(
      onTap: onPress, // onTap is null, InkWell will disable
      child: Container(
        height: autoHeight ? null : height,
        decoration: BorderDecorator(
          color: context.borderColor,
          width: 0.5,
          hasTop: showBorderTop,
          hasBottom: showBorderBottom,
          leftInset: context.edgeSize,
        ),
        padding: padding ?? context.edgeAll,
        child: Row(
          children: [
            if (cmpLeft != null) cmpLeft,
            if (label != null)
              Text(
                label ?? '',
                style: labelStyle ?? context.textBody(bold: true),
              ),
            if (child != null) Expanded(child: child),
            if (child == null) Spacer(),
            if (cmpRight != null) cmpRight,
            if (hideAccess != true)
              Padding(
                padding: context.edgeLeft8,
                child: Icon(
                  CSIcons.More,
                  size: 12,
                  color: context.bodyColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
