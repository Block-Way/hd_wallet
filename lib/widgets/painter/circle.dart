part of widgets;

class CirclePainter extends CustomPainter {
  CirclePainter({
    @required this.center,
    @required this.radius,
    @required this.radians,
    @required this.colors,
    this.stops,
  });

  Offset center;
  double radius;
  double radians;
  List<Color> colors;
  List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final gradient = LinearGradient(
      colors: colors,
      stops: stops,
    );

    final brush = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 0
      ..shader = gradient.createShader(rect);

    canvas.drawCircle(center, radius, brush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return kReleaseMode;
  }
}
