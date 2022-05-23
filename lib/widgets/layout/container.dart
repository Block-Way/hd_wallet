part of widgets;

class CSContainer extends StatelessWidget {
  const CSContainer({
    @required this.child,
    Key key,
    this.width = double.infinity,
    this.height,
    this.radius = 12,
    this.margin,
    this.padding,
    this.decoration,
    this.secondary,
    this.onTap,
    this.splashColor,
  })  : assert(child != null),
        super(key: key);

  final double width;
  final double height;
  final double radius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool secondary;
  final Decoration decoration;
  final Widget child;
  final void Function() onTap;
  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? context.edgeAll,
      width: width,
      height: height,
      decoration: decoration ??
          context.boxDecoration(
            radius: radius,
            color: secondary == true
                ? context.bgSecondaryColor
                : context.bgPrimaryColor,
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          type: MaterialType.transparency,
          child: onTap == null
              ? Padding(
                  padding: padding ?? context.edgeAll,
                  child: child,
                )
              : InkWell(
                  splashColor: splashColor ?? context.bgSecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  onTap: onTap,
                  child: Padding(
                    padding: padding ?? context.edgeAll,
                    child: child,
                  ),
                ),
        ),
      ),
    );
  }
}
