part of widgets;

class CSProgressIndicator extends StatelessWidget {
  const CSProgressIndicator({
    Key? key,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.0,
    this.value,
    this.size,
    this.width,
    this.height,
  }) : super(key: key);

  /// Default primaryColor
  final Color? color;
  final Color? backgroundColor;

  final double strokeWidth;
  final double? width;
  final double? height;
  final double? size;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final valueColor = AlwaysStoppedAnimation<Color>(
      color ?? context.primaryColor,
    );

    final view = CircularProgressIndicator(
      strokeWidth: strokeWidth,
      valueColor: valueColor,
      backgroundColor: backgroundColor ?? Colors.transparent,
      value: value,
    );

    if ((width != null && height != null) || size != null) {
      return SizedBox(
        width: width ?? size,
        height: height ?? size,
        child: view,
      );
    }

    return view;
  }
}
