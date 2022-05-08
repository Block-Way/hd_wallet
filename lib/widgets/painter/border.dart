part of widgets;

class BorderDecorator extends Decoration {
  const BorderDecorator({
    @required this.color,
    this.width,
    this.hasTop,
    this.hasBottom,
    this.leftInset,
    this.rightInset,
  });

  final Color color;
  final double width;
  final bool hasTop;
  final bool hasBottom;
  final double leftInset;
  final double rightInset;

  @override
  BoxPainter createBoxPainter([_]) {
    return BorderPainter(
      color: color,
      width: width ?? 1,
      hasTop: hasTop,
      hasBottom: hasBottom,
      leftInset: leftInset ?? 0,
      rightInset: rightInset ?? 0,
    );
  }
}

class BorderPainter extends BoxPainter {
  const BorderPainter({
    @required this.color,
    this.width,
    this.hasTop,
    this.hasBottom,
    this.leftInset,
    this.rightInset,
  });

  final Color color;
  final double width;
  final bool hasTop;
  final bool hasBottom;
  final double leftInset;
  final double rightInset;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final bounds = offset & configuration.size;

    final lineWidth = offset.dx + bounds.width - rightInset;

    if (hasTop == true) {
      canvas.drawLine(
        Offset(offset.dx + leftInset, offset.dy),
        Offset(lineWidth, offset.dy),
        Paint()
          ..strokeWidth = width
          ..color = color
          ..style = PaintingStyle.fill,
      );
    }

    if (hasBottom == true) {
      canvas.drawLine(
        Offset(offset.dx + leftInset, offset.dy + bounds.height),
        Offset(lineWidth, offset.dy + bounds.height),
        Paint()
          ..strokeWidth = width
          ..color = color
          ..style = PaintingStyle.fill,
      );
    }
  }
}
