part of widgets;

/// 画弹出菜单下面的三角形
class TrianglePainter extends CustomPainter {
  TrianglePainter({
    this.isDown = true,
    this.color,
  });

  bool isDown;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint();
    _paint.strokeWidth = 2.0;
    _paint.color = color;
    _paint.style = PaintingStyle.fill;

    final path = Path();
    if (isDown) {
      path.moveTo(0.0, -1.0);
      path.lineTo(size.width, -1.0);
      path.lineTo(size.width / 2.0, size.height);
    } else {
      path.moveTo(size.width / 2.0, 0.0);
      path.lineTo(0.0, size.height + 1);
      path.lineTo(size.width, size.height + 1);
    }

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
