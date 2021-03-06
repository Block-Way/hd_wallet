part of app_module;

class AppDrawerBackground extends Decoration {
  const AppDrawerBackground({
    required this.borderRadius,
  });
  final BorderRadiusGeometry borderRadius;

  @override
  BoxPainter createBoxPainter([void Function()? F]) {
    /*const startColor = Color(0xFFFFE56C);
    const endColor = Color(0xFFFFEA8A);*/
    const startColor = Color(0xFF32383E);
    const endColor = Color(0xFF32383E);
    return _AppDrawerBackgroundPainter(
      borderRadius: borderRadius,
      colors: [startColor, endColor],
    );
  }
}

class _AppDrawerBackgroundPainter extends BoxPainter {
  const _AppDrawerBackgroundPainter({
    required this.colors,
    required this.borderRadius,
  });

  final List<Color> colors;
  final BorderRadiusGeometry borderRadius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final bounds = offset & (configuration.size ?? Size(0, 0));

    final gradient = LinearGradient(
      colors: colors,
    );

    // Draw background color
    canvas.drawRRect(
      borderRadius.resolve(configuration.textDirection).toRRect(bounds),
      Paint()..shader = gradient.createShader(bounds),
    );

    canvas.drawPoints(
      PointMode.polygon,
      [
        Offset(
          -10,
          bounds.height * 0.2,
        ),
        Offset(
          bounds.width * 0.32,
          bounds.height * 0.17,
        ),
        Offset(
          -10,
          bounds.height * 0.4,
        ),
      ],
      Paint()
        ..color = Color(0xFFFDEEA8)
        ..isAntiAlias = true
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 20,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(
          bounds.width,
          bounds.height * 0.6,
        ),
        width: 200,
        height: 185,
      ),
      math.pi / 2,
      math.pi,
      false,
      Paint()
        ..color = Color(0xFFFDEEA8)
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20,
    );
  }
}
