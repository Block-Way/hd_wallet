part of widgets;

class TextAdapt extends HookWidget {
  TextAdapt(
    this.text, {
    this.maxWidth = 50,
    this.cmpRight,
    this.textStyle,
  });

  final String text;
  /*
   * 不能实际控制组件宽度，但是当文字达到这个宽度的时候
   * 外层会自动包裹 Expanded，让水平方向延展
   */
  final double maxWidth;
  final Widget? cmpRight;
  final TextStyle? textStyle;

  final GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final useExpand = useState<bool>(false);

    useEffect(() {
      useExpand.value = false;
      Timer(Duration(milliseconds: 200), () {
        final width = widgetKey.currentContext?.size?.width;
        useExpand.value = width != null && width > maxWidth;
      });

      return null;
    }, [text]);

    Widget _textWidget() {
      return Text(
        text,
        softWrap: true,
        key: widgetKey,
        maxLines: 1,
        style: textStyle ??
            context.textBody(bold: true, fontWeight: FontWeight.normal),
        overflow: TextOverflow.ellipsis,
      );
    }

    return Row(
      children: [
        if (!useExpand.value) _textWidget(),
        if (useExpand.value) Expanded(child: _textWidget()),
        if (cmpRight != null) cmpRight!
      ],
    );
  }
}
