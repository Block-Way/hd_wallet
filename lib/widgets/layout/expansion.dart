part of widgets;

const Duration _kExpand = Duration(milliseconds: 200);

class CSExpansionTile extends StatefulWidget {
  const CSExpansionTile({
    required this.title,
    required this.body,
    Key? key,
    this.leading,
    this.subtitle,
    this.backgroundColor,
    this.onExpansionChanged,
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tileRadius,
    this.tilePadding,
    this.tileMargin,
    this.tileDecoration,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
  })  : assert(initiallyExpanded != null),
        assert(maintainState != null),
        assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          '''CrossAxisAlignment.baseline is not supported since the expanded children '''
          'are aligned in a column, not a row. Try to use another constant.',
        ),
        super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool>? onExpansionChanged;

  /// The widget that are displayed when the tile expands.
  final Widget body;

  /// The color to display behind the sublist when expanded.
  final Color? backgroundColor;

  /// A widget to display instead of a rotating arrow icon.
  final Widget? trailing;

  /// Specifies if the list tile is initially expanded (true)
  /// or collapsed (false, the default).
  final bool initiallyExpanded;

  /// Specifies whether the state of the children
  /// is maintained when the tile expands and collapses.
  ///
  /// When true, the children are kept in the tree while the tile is collapsed.
  /// When false (default), the children are
  /// removed from the tree when the tile is
  /// collapsed and recreated upon expansion.
  final bool maintainState;

  /// Specifies padding for the [ListTile].
  ///
  /// Analogous to [ListTile.contentPadding],
  /// this property defines the insets for
  /// the [leading], [title], [subtitle]
  /// and [trailing] widgets. It does not inset
  /// the expanded [children] widgets.
  ///
  /// When the value is null, the tile's padding
  /// is `EdgeInsets.symmetric(horizontal: 16.0)`.
  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? tileMargin;
  final double? tileRadius;
  final BoxDecoration? tileDecoration;

  /// Specifies the alignment of [children], which are arranged in a column when
  /// the tile is expanded.
  ///
  /// The internals of the expanded tile make use of a [Column] widget for
  /// [children], and [Align] widget to align
  /// the column. The `expandedAlignment`
  /// parameter is passed directly into the [Align].
  ///
  /// Modifying this property controls the alignment of the column within the
  /// expanded tile, not the alignment of [children] widgets within the column.
  /// To align each child within [children], see [expandedCrossAxisAlignment].
  ///
  /// The width of the column is the
  /// width of the widest child widget in [children].
  ///
  /// When the value is null,
  /// the value of `expandedAlignment` is [Alignment.center].
  final Alignment? expandedAlignment;

  /// Specifies the alignment of each
  /// child within [children] when the tile is expanded.
  ///
  /// The internals of the expanded tile make use of a [Column] widget for
  /// [children], and the `crossAxisAlignment` parameter
  /// is passed directly into the [Column].
  ///
  /// Modifying this property controls the cross axis alignment of each child
  /// within its [Column]. Note that the width of the [Column] that houses
  /// [children] will be the same as
  /// the widest child widget in [children]. It is
  /// not necessarily the width of [Column]
  /// is equal to the width of expanded tile.
  ///
  /// To align the [Column] along the expanded
  /// tile, use the [expandedAlignment] property
  /// instead.
  ///
  /// When the value is null, the value
  /// of `expandedCrossAxisAlignment` is [CrossAxisAlignment.center].
  final CrossAxisAlignment? expandedCrossAxisAlignment;

  /// Specifies padding for [children].
  ///
  /// When the value is null,
  /// the value of `childrenPadding` is [EdgeInsets.zero].
  final EdgeInsetsGeometry? childrenPadding;

  @override
  _CSExpansionTileState createState() => _CSExpansionTileState();
}

class _CSExpansionTileState extends State<CSExpansionTile>
    with SingleTickerProviderStateMixin {
  static final _easeInTween = CurveTween(curve: Curves.easeIn);
  static final _halfTween = Tween<double>(begin: 0.0, end: 0.25);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  // Animation<Color> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    // _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    // _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    // _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    // _backgroundColor =
    //     _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    }
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return CSContainer(
      margin: widget.tileMargin,
      padding: EdgeInsets.zero,
      radius: widget.tileRadius!,
      onTap: _handleTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: widget.tilePadding!,
            child: Row(
              children: [
                if (widget.leading != null) widget.leading!,
                widget.title,
                Spacer(),
                RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    CSIcons.More,
                    color: context.blackColor,
                    size: 8,
                  ),
                ),
              ],
            ),
          ),
          ClipRect(
            child: Align(
              alignment: widget.expandedAlignment ?? Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _borderColorTween.end = context.whiteColor;
    _headerColorTween
      ..begin = context.whiteColor
      ..end = context.whiteColor;
    _iconColorTween
      ..begin = context.blackColor
      ..end = context.blackColor;
    _backgroundColorTween.end = context.bgSecondaryColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: widget.body,
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
