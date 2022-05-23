part of common_ui_module;

class CSHorizontalProgress extends StatelessWidget {
  const CSHorizontalProgress({
    @required this.width,
    @required this.height,
    @required this.value,
    @required this.valueColor,
    @required this.backgroundColor,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;

  /// 0~1
  final double value;
  final Color valueColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final valueProgress = (value >= 0 && value <= 1 ? value : 0.5) * width;

    return Stack(
      children: [
        /// bg progress
        Container(
          width: width,
          height: height,
          decoration: context.boxDecoration(
            color: backgroundColor,
            radius: 10,
          ),
        ),
        Container(
          width: valueProgress,
          height: height,
          decoration: context.boxDecoration(
            color: valueColor,
            radius: 10,
          ),
        ),
      ],
    );
  }
}
