part of widgets;

class CSButtonGroup extends StatelessWidget {
  const CSButtonGroup({
    @required this.selectedId,
    Key key,
    this.onSelectedId,
  }) : super(key: key);

  final int selectedId;
  final Function(int value) onSelectedId;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(8, 0),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: buttonWidget(
                context,
                label: tr('trade:btn_buy'),
                isLeft: true,
                isSelect: selectedId == 0,
                selectedId: selectedId,
                onPress: () {
                  // TradeSide.buy.index;
                  onSelectedId(0);
                },
              )),
              Flexible(
                child: Transform.translate(
                  offset: Offset(-14, 0),
                  child: buttonWidget(
                    context,
                    label: tr('trade:btn_sell'),
                    isLeft: false,
                    isSelect: selectedId == 1,
                    selectedId: selectedId,
                    onPress: () {
                      // TradeSide.sell.index;
                      onSelectedId(1);
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Widget buttonWidget(
  BuildContext context, {
  String label,
  bool isLeft,
  bool isSelect,
  Function onPress,
  int selectedId,
}) {
  return ClipPath(
    clipper: TopBarClipper(isLeft: isLeft),
    child: ClipRRect(
      borderRadius: isLeft
          ? BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            )
          : BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
      child: CSButton(
        label: label,
        height: 40,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        borderRadius: 0,
        textColor: isSelect ? context.whiteColor : context.bodyColor,
        backgroundColor: isSelect
            ? selectedId == 0
                ? context.greenColor
                : context.redColor
            : context.greyDarkColor,
        onPressed: () {
          onPress();
        },
      ),
    ),
  );
}

class TopBarClipper extends CustomClipper<Path> {
  TopBarClipper({
    this.isLeft,
  });

  bool isLeft;

  @override
  Path getClip(Size size) {
    if (isLeft == true) {
      final path = Path()
        ..lineTo(0.0, 0.0)
        ..lineTo(0.0, size.height)
        ..lineTo(size.width - 16, size.height)
        ..lineTo(size.width, 0)
        ..close();
      return path;
    } else {
      final path = Path()
        ..lineTo(16, 0.0)
        ..lineTo(0.0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, 0)
        ..close();
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
