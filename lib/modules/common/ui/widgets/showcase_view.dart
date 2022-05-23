part of common_ui_module;

class ShowcaseView extends StatefulWidget {
  const ShowcaseView({
    @required this.message,
    @required this.child,
    Key key,
    this.width = 164,
    this.alignment = Alignment.center,
    this.hideImage = false,
    this.isPoleDecoratorBottom = false,
  }) : super(key: key);

  final double width;
  final Alignment alignment;
  final String message;
  final Widget child;
  final bool hideImage;
  final bool isPoleDecoratorBottom;

  @override
  ShowcaseViewState createState() => ShowcaseViewState();
}

class ShowcaseViewState extends State<ShowcaseView> {
  final showcaseKey = GlobalKey();

  void show() {
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {
    //     Future.delayed(
    //       Duration(milliseconds: 200),
    //       () => ShowCaseWidget.of(context).startShowCase(
    //         [showcaseKey],
    //       ),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    // var polePosX = 0.0;
    // const msgHeight = 45.0;

    // if (widget.alignment == Alignment.center) {
    //   polePosX = (widget.width / 2) + 1;
    // }
    // if (widget.alignment == Alignment.topRight) {
    //   polePosX = 20;
    // }
    // if (widget.alignment == Alignment.topLeft) {
    //   polePosX = 20;
    // }

    return SizedBox();
    // Showcase.withWidget(
    //   height: widget.isPoleDecoratorBottom ? 400 : 200,
    //   width: widget.width,
    //   disableAnimation: true,
    //   animationDuration: Duration(milliseconds: 500),
    //   key: showcaseKey,
    //   overlayColor: context.backdropColor,
    //   shapeBorder: CircleBorder(),
    //   container: GestureDetector(
    //     onTap: () {
    //       ShowCaseWidget.of(context).dismiss();
    //     },
    //     child: Stack(
    //       children: [
    //         if (!widget.hideImage)
    //           Positioned(
    //             left: 0,
    //             bottom: msgHeight - 15,
    //             child: CSImage(
    //               'assets/images/help.png',
    //               width: 70,
    //               backgroundColor: Colors.transparent,
    //             ),
    //           ),
    //         if (!widget.isPoleDecoratorBottom)
    //           Positioned(
    //             right: polePosX,
    //             bottom: widget.isPoleDecoratorBottom ? 0 : msgHeight,
    //             child: Container(
    //               height: msgHeight,
    //               decoration: PoleDecorator(context.btnPrimaryBgColor,
    //                   isCircleBottom: widget.isPoleDecoratorBottom),
    //             ),
    //           ),
    //         if (!widget.isPoleDecoratorBottom)
    //           renderTipsView(context, msgHeight, widget),
    //         if (widget.isPoleDecoratorBottom)
    //           Center(
    //             child: Column(
    //               children: [
    //                 renderTipsView(context, msgHeight, widget),
    //                 Container(
    //                   height: msgHeight,
    //                   decoration: PoleDecorator(context.btnPrimaryBgColor,
    //                       isCircleBottom: widget.isPoleDecoratorBottom),
    //                 ),
    //               ],
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    //   child: widget.child,
    // );
  }
}

Widget renderTipsView(
    BuildContext context, double msgHeight, ShowcaseView widget) {
  return Container(
    width: widget.width - 10,
    height: msgHeight,
    padding: context.edgeHorizontal10,
    margin: widget.isPoleDecoratorBottom
        ? EdgeInsets.zero
        : EdgeInsets.only(top: msgHeight + 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      color: context.btnPrimaryBgColor,
    ),
    child: Text(
      widget.message ?? '',
      style: context.textSecondary(
        bold: true,
        color: context.whiteColor,
      ),
    ),
  );
}
