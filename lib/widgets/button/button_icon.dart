part of widgets;

class CSButtonIcon extends StatelessWidget {
  const CSButtonIcon({
    @required this.icon,
    Key key,
    this.borderRadius,
    this.onPressed,
    this.color,
    this.background,
    this.splashColor,
    this.size = 14,
    this.disabled = false,
    this.disableDebounce = false,
    this.doubleClickInterval = 350,
    this.margin,
    this.padding,
    this.containerSize,
  }) : super(key: key);

  final double borderRadius;
  final Function onPressed;
  final bool disabled;
  final bool disableDebounce;
  final Color color;
  final Color background;
  final Color splashColor;
  final double size;
  final IconData icon;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final int doubleClickInterval;
  final double containerSize;

  @override
  Widget build(BuildContext context) {
    void handlePress() {
      if (onPressed != null && !disabled) {
        if (disableDebounce) {
          onPressed();
        } else {
          ButtonUtils.doubleClick(onPressed, doubleClickInterval);
        }
      }
    }

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: Container(
          width: containerSize,
          height: containerSize,
          padding: padding ?? context.edgeAll,
          color: background ?? context.primaryColor,
          alignment: Alignment.center,
          child: IgnorePointer(
            ignoring: disabled == true,
            child: IconButton(
              icon: Icon(icon),
              iconSize: size,
              padding: EdgeInsets.zero,
              color: color ?? context.bodyColor,
              splashColor: splashColor ?? context.bgSecondaryColor,
              onPressed: handlePress,
            ),
          ),
        ),
      ),
    );
  }
}
