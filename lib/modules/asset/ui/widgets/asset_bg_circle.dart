part of asset_ui_module;

class AssetBackgroundCircle extends Decoration {
  const AssetBackgroundCircle();

  @override
  BoxPainter createBoxPainter([_]) {
    const startColor = Color(0xFFfff0a2);
    const endColor = Color(0xFFf5c600);
    return _AssetBackgroundCirclePainter(
      radius: 80,
      colors: [
        startColor.withOpacity(0),
        startColor.withOpacity(0.1),
        startColor.withOpacity(0.15),
        endColor.withOpacity(0)
      ],
    );
  }
}

class _AssetBackgroundCirclePainter extends BoxPainter {
  const _AssetBackgroundCirclePainter({
    this.colors,
    this.radius = 10,
  });

  final List<Color> colors;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final bounds = offset & configuration.size;

    canvas.drawRRect(
      BorderRadius.all(Radius.circular(12))
          .resolve(configuration.textDirection)
          .toRRect(bounds),
      Paint()..color = Colors.white,
    );

    final gradient = LinearGradient(
      colors: colors,
    );

    final brush = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    final position1 = Offset(
      bounds.width - 20,
      bounds.height + offset.dy + radius * 0.5,
    );

    canvas.drawCircle(
      position1,
      radius,
      brush
        ..shader = gradient.createShader(
          Rect.fromCircle(
            center: position1,
            radius: radius,
          ),
        ),
    );

    final position2 = Offset(bounds.width, bounds.height + offset.dy - 20);

    canvas.drawCircle(
      position2,
      radius,
      brush
        ..shader = gradient.createShader(
          Rect.fromCircle(
            center: position2,
            radius: radius,
          ),
        ),
    );
  }
}
