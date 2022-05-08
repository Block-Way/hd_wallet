part of common_ui_module;

class ShareView extends StatefulHookWidget {
  const ShareView({
    @required this.child,
    Key key,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  ShareViewState createState() => ShareViewState();
}

class ShareViewState extends State<ShareView> {
  GlobalKey rootWidgetKey = GlobalKey();

  Future<void> capture() async {
    try {
      final boundary = rootWidgetKey.currentContext.findRenderObject()
          as RenderRepaintBoundary;
      final dpr = context.pixelRatio;
      final image = await boundary.toImage(pixelRatio: dpr);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData.buffer.asUint8List();
      await FileUtils.saveImage(pngBytes, quality: 100);
      Toast.show(tr('global:msg_picture_saved_successfully'));
    } catch (e) {
      if (e is FileUtilsPermissionError) {
        Toast.show(tr('global:msg_permission_denied_storage'));
      } else {
        Toast.show(tr('global:msg_picture_saved_failed'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: rootWidgetKey,
      child: widget.child,
    );
  }
}
