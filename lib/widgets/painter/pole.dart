part of widgets;

class PoleDecorator extends Decoration {
  const PoleDecorator(
    this.color, {
    this.isCircleBottom,
  });
  final Color color;
  final bool? isCircleBottom;

  @override
  BoxPainter createBoxPainter([void Function()? f]) {
    return PolePainter(color, isCircleBottom: isCircleBottom!);
  }
}

class PolePainter extends BoxPainter {
  PolePainter(
    this.color, {
    this.isCircleBottom = false,
  });
  final Color color;
  final bool isCircleBottom;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;

    canvas.drawLine(
      offset,
      Offset(offset.dx, offset.dy + bounds.height),
      Paint()
        ..strokeWidth = 1.0
        ..color = color
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      isCircleBottom ? Offset(offset.dx, offset.dy + bounds.height) : offset,
      6,
      Paint()
        ..strokeWidth = 1.0
        ..color = color.withOpacity(0.5)
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      isCircleBottom ? Offset(offset.dx, offset.dy + bounds.height) : offset,
      4,
      Paint()
        ..strokeWidth = 1.0
        ..color = color.withOpacity(0.9)
        ..style = PaintingStyle.fill,
    );
  }
}
