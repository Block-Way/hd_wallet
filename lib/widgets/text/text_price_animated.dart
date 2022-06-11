part of widgets;

class PriceTextAnimated extends HookWidget {
  const PriceTextAnimated(
    this.value,
    this.symbol,
    this.size, {
    this.color,
    this.bold = true,
    this.approximate = false,
    this.sameStyle = false,
    Key? key,
  }) : super(key: key);

  final String value;
  final String symbol;
  final TextSize size;
  final Color? color;
  final bool bold;
  final bool approximate;
  final bool sameStyle;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: Duration(seconds: 1),
      initialValue: 1,
      lowerBound: 0.1,
      upperBound: 0.3,
    );

    final animation = useAnimation(controller);

    final _scale = 1 - animation;

    useEffect(() {
      controller.forward();

      return () {
        // controller.dispose();
      };
    }, [value]);

    return Transform.scale(
      scale: _scale,
      child: PriceText(
        value,
        symbol,
        size,
        color: color,
        bold: bold,
        approximate: approximate,
        sameStyle: sameStyle,
      ),
    );
  }
}
