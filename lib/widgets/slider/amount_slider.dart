part of widgets;

class CSAmountSlider extends HookWidget {
  const CSAmountSlider({
    @required this.maxChanges,
    @required this.valueChanges,
    @required this.onChanged,
    Key key,
    this.color,
    this.handlerSize = 16,
  }) : super(key: key);

  final Stream<double> maxChanges;
  final Stream<double> valueChanges;
  final Function(double) onChanged;
  final double handlerSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final handlerColor = color ?? context.bodyColor;
    final trackActiveColor = color ?? context.bodyColor;
    final trackInactiveColor = Color(0xFFEEEEEE);
    final currentValue = useStream(valueChanges, initialData: 0.0);
    final maxValue = useStream(maxChanges, initialData: 0.0);
    final isZero = NumberUtil.truncateDecimal<double>(maxValue.data) == 0.0;
    final safeMaxValue =
        isZero ? 100.0 : NumberUtil.truncateDecimal<double>(maxValue.data);
    final maxSteps = NumberUtil.truncateDecimal<double>(safeMaxValue / 100);
    final safeCurrentValue = isZero
        ? 0.0
        : (currentValue.data > safeMaxValue ? safeMaxValue : currentValue.data);

    final trackLinesStyle = FlutterSliderSizedBox(
      width: 8,
      height: 14,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        color: trackInactiveColor,
        border: Border.all(width: 2, color: Colors.white),
      ),
    );

    return SizedBox(
      height: 55,
      child: FlutterSlider(
        handlerWidth: handlerSize,
        handlerHeight: handlerSize,
        handler: FlutterSliderHandler(
          decoration: BoxDecoration(),
          child: Container(
            width: handlerSize,
            height: handlerSize,
            decoration: BoxDecoration(
              color: handlerColor,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: handlerColor.withOpacity(0.3),
                  spreadRadius: 0.05,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Icon(
              CSIcons.Slider,
              color: Colors.white,
              size: 10,
            ),
          ),
        ),
        trackBar: FlutterSliderTrackBar(
          inactiveTrackBar: BoxDecoration(
            color: trackInactiveColor,
            border: Border.all(width: 3, color: trackInactiveColor),
          ),
          activeTrackBar: BoxDecoration(
            color: trackActiveColor,
          ),
        ),
        hatchMark: FlutterSliderHatchMark(
          labelsDistanceFromTrackBar: 35,
          linesDistanceFromTrackBar: -11,
          displayLines: true,
          bigLine: trackLinesStyle,
          smallLine: trackLinesStyle,
          density: 0.05, // means 50 lines, from 0 to 100 percent
          labels: [
            FlutterSliderHatchMarkLabel(
              percent: 0,
              label: Text(
                '0',
                style: context.textSmall(),
              ),
            ),
            FlutterSliderHatchMarkLabel(
              percent: 100,
              label: Text(
                '100%',
                style: context.textSmall(),
              ),
            ),
          ],
        ),
        tooltip: FlutterSliderTooltip(
          disabled: true, // Set false if need tooltip
          textStyle: TextStyle(fontSize: 17, color: Colors.white),
          boxStyle: FlutterSliderTooltipBox(
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.7),
            ),
          ),
        ),
        values: [safeCurrentValue],
        max: safeMaxValue,
        min: 0,
        step: FlutterSliderStep(step: maxSteps),
        onDragging: (handlerIndex, lowerValue, upperValue) {
          if (!isZero) {
            onChanged(lowerValue as double);
          }
        },
      ),
    );
  }
}
