part of widgets;

class CSDrawer extends StatefulWidget {
  const CSDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
    this.widthPercent = 0.7,
    this.width,
    this.callback,
    this.decoration,
    this.borderRadius,
    this.color,
  })  : assert(
            widthPercent != null && widthPercent < 1.0 && widthPercent > 0.0),
        super(key: key);

  final double elevation;
  final Widget child;
  final String semanticLabel;
  final double widthPercent;
  final double width;
  final DrawerCallback callback;
  final BorderRadiusGeometry borderRadius;
  final Decoration decoration;
  final Color color;

  @override
  _CSDrawerState createState() => _CSDrawerState();
}

class _CSDrawerState extends State<CSDrawer> {
  @override
  void initState() {
    if (widget.callback != null) {
      widget.callback(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.callback != null) {
      widget.callback(false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    String label = widget.semanticLabel;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        label = widget.semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label = widget.semanticLabel ??
            MaterialLocalizations.of(context)?.drawerLabel;
    }

    final double _width =
        widget.width ?? context.mediaWidth * widget.widthPercent;

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: Material(
        color: Colors.transparent,
        elevation: widget.elevation,
        child: Container(
          decoration: widget.decoration ?? BoxDecoration(color: widget.color),
          constraints: BoxConstraints.expand(width: _width),
          child: widget.child,
        ),
      ),
    );
  }
}
