part of invest_ui_module;

class AirdropHeader extends StatelessWidget {
  const AirdropHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 124,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('invest:airdrop_lbl_header'),
                overflow: TextOverflow.ellipsis,
                style: context.textBody(
                  bold: true,
                  color: Color(0xFF4e4c41),
                ),
              ),
              Padding(
                padding: context.edgeVertical5,
                child: PriceText(
                  '180000000',
                  'SUG',
                  TextSize.medium,
                  color: context.redColor,
                ),
              ),
              CustomPaint(
                size: Size(12, 6),
                painter: TrianglePainter(
                  color: context.redColor,
                  isDown: false,
                ),
              ),
              Container(
                height: 20,
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                decoration: context.boxDecoration(
                  color: context.redColor,
                  radius: 12,
                ),
                child: Text(
                  tr('invest:airdrop_lbl_tips'),
                  style: context.textSmall(
                    bold: true,
                    color: Color(0xFFfff091),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/airdrop_triangle_bg.png'),
              ),
            ),
            child: Transform.rotate(
              angle: math.pi / 4,
              child: SizedBox(
                width: 70,
                child: Text(
                  tr('invest:airdrop_lbl_mark'),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: context.textSmall(
                    color: Color(0xFF94820d),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
