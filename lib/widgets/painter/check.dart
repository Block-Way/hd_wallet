part of widgets;

class CheckDecorator extends Decoration {
  const CheckDecorator({
    this.isCheck,
  });

  final bool? isCheck;

  @override
  BoxPainter createBoxPainter([void Function()? f]) {
    return CheckPainter(
      isCheck: isCheck,
    );
  }
}

class CheckPainter extends BoxPainter {
  const CheckPainter({
    this.isCheck,
  });

  final bool? isCheck;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final bounds = offset & configuration.size!;

    canvas.drawCircle(
        Offset(offset.dx - 6, offset.dy + bounds.height / 2),
        6.0,
        Paint()
          ..color = isCheck == true ? Color(0xFFFFDF0C) : Color(0xFFe5e5e5)
          ..style = PaintingStyle.fill);
    if (isCheck == true) {
      canvas.drawCircle(
          Offset(offset.dx - 6, offset.dy + bounds.height / 2),
          3,
          Paint()
            ..color = Color(0xFF333333)
            ..style = PaintingStyle.fill);
    }
  }
}
