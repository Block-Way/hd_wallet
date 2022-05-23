part of widgets;

class _TabFancySelectedPainter extends CustomPainter {
  _TabFancySelectedPainter({
    this.isSelected = false,
    this.isLast = false,
  });

  final bool isSelected;
  final bool isLast;

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = 3
      ..color = isSelected ? Color(0xFFffdf0c) : Color(0xFFf0f0f0);
    // ..color = isSelected ? Colors.red : Colors.blue;

    final bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = isSelected ? Colors.white : Color(0xFFfefcf1);
    // ..color = isSelected ? Colors.red : Colors.blue;

    const borderRadius = 10.0;
    const angle = 15.0;
    final width = size.width;
    final height = size.height + 1;

    final path = Path();

    if (isSelected) {
      path.moveTo(0, height);
      path.lineTo(0, height);
    } else {
      if (isLast) {
        path.moveTo(2, height);
        path.moveTo(-15, 4);
      } else {
        path.moveTo(0, height);
        path.lineTo(0, height);
      }
    }

    if (isSelected) {
      path.cubicTo(
        // From
        isLast ? angle : 0,
        borderRadius,
        // Border point
        isLast ? angle : 0,
        0,
        // To
        isLast ? angle + borderRadius : borderRadius,
        0,
      );
      path.lineTo(width - angle - borderRadius, 0);
    } else {
      if (isLast) {
        path.lineTo(width - borderRadius, 4);
      } else {
        path.cubicTo(
          // From
          0,
          4 + borderRadius,
          // Border point
          0,
          4,
          // To
          borderRadius,
          4,
        );
      }
    }

    if (isSelected) {
      path.cubicTo(
        // From
        width - borderRadius - (isLast ? 0 : angle),
        0,
        // Border point
        width - (isLast ? 0 : angle),
        0,
        // To
        width - (isLast ? 0 : angle),
        borderRadius,
      );
      path.lineTo(width, height);
    } else {
      if (isLast) {
        path.cubicTo(
          // From
          width - borderRadius,
          4,
          // Border point
          width,
          4,
          // To
          width,
          4 + borderRadius,
        );
      } else {
        path.lineTo(width + 20, 4);
      }
      path.lineTo(width, height);
    }

    // Got to start
    if (isSelected) {
      path.moveTo(0, height);
    } else {
      path.lineTo(2, height);
      path.lineTo(isLast ? -14 : 0, 4);
    }
    path.close();

    canvas.drawPath(path, bgPaint);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CSButtonTabsFancy extends StatelessWidget {
  const CSButtonTabsFancy({
    @required this.selected,
    @required this.onSelected,
    @required this.holdLbl,
    @required this.holdValue,
    @required this.invitationLbl,
    @required this.invitationValue,
    Key key,
  }) : super(key: key);

  final int selected;
  final Function(int value) onSelected;
  // button value
  final String holdLbl;
  final String holdValue;
  final String invitationLbl;
  final String invitationValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.edgeTop.copyWith(bottom: 2),
      padding: context.edgeHorizontal,
      height: 56,
      decoration: BorderDecorator(
        hasBottom: true,
        color: context.primaryColor,
        width: 2,
        leftInset: 8,
        rightInset: 8,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 2),
        child: Row(
          children: [
            Expanded(
              child: CustomPaint(
                painter: _TabFancySelectedPainter(
                  isSelected: selected == 0,
                ),
                child: Container(
                  padding: context.edgeRight,
                  child: InkWell(
                    onTap: () {
                      onSelected(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          holdLbl,
                          style: context.textSmall(
                            color: context.labelColor,
                          ),
                        ),
                        Text(
                          holdValue,
                          style: context.textBodyPrice(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomPaint(
                painter: _TabFancySelectedPainter(
                  isSelected: selected == 1,
                  isLast: true,
                ),
                child: InkWell(
                  onTap: () {
                    onSelected(1);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        invitationLbl,
                        style: context.textSmall(
                          color: context.labelColor,
                        ),
                      ),
                      Text(
                        invitationValue,
                        style: context.textBodyPrice(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
