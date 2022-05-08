part of widgets;

/// Implements a single application page's layout.
///
/// The scaffold lays out the navigation bar on top and the content between or
/// behind the navigation bar.
///
class CSScaffold extends StatelessWidget {
  /// Creates a layout for pages with a navigation bar at the top.
  const CSScaffold({
    @required this.child,
    Key key,
    this.title,
    this.titleStyle,
    this.titleWidget,
    this.titleCenter = true,
    this.hideLeading = false,
    this.actions,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.addTopInset = true,
    this.addBottomInset = true,
    this.outerChild,
    this.toolbarHeight = 42,
    this.toolbarBottom,
    this.headerBgColor,
    this.headerTextColor,
    this.scrollable = false,
    this.brightness = Brightness.light,
    this.bottomChild,
    this.drawer,
    this.appBar,
    this.outerBackground,
    this.leadingIcon,
  })  : assert(child != null),
        super(key: key);

  /// Widget to show in the main content area.
  final Widget child;

  final bool scrollable;
  final Brightness brightness;

  final List<Widget> actions;

  final String title;
  final TextStyle titleStyle;
  final Widget titleWidget;
  final bool titleCenter;
  final bool hideLeading;

  final Color backgroundColor;

  final Widget outerChild;
  final Widget bottomChild;

  final double toolbarHeight;
  final PreferredSizeWidget toolbarBottom;
  final Color headerBgColor;
  final Color headerTextColor;

  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;

  final bool addTopInset;

  /// Remove SafeArea bottom padding,
  /// Use True when need a fullScreen page
  final bool addBottomInset;

  final Widget drawer;
  final PreferredSizeWidget appBar;

  final Color outerBackground;

  final IconData leadingIcon;

  // final ScrollController _primaryScrollController = ScrollController();
  // void _handleStatusBarTap() {
  //   // Only act on the scroll controller if it has any attached scroll positions.
  //   if (_primaryScrollController.hasClients) {
  //     _primaryScrollController.animateTo(
  //       0.0,
  //       // Eyeballed from iOS.
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.linearToEaseOut,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = brightness == Brightness.dark;
    ThemeStatusBar.updateUiOverlayStyle(brightness);

    return Container(
      color: outerBackground ?? context.bgScaffoldColor,
      child: Stack(
        children: [
          if (outerChild != null) outerChild,
          Scaffold(
            drawer: drawer,
            drawerEnableOpenDragGesture: false,
            drawerScrimColor: context.backdropColor,
            backgroundColor: backgroundColor ?? context.bgScaffoldColor,
            appBar: appBar ??
                AppBar(
                  toolbarHeight: toolbarHeight,
                  automaticallyImplyLeading: !hideLeading,
                  centerTitle: titleCenter,
                  title: Transform.translate(
                    offset: Offset(0, titleCenter == false ? 5 : 0),
                    child: titleWidget ??
                        Text(
                          title ?? '',
                          style: titleStyle ??
                              context.textTitle(
                                bold: true,
                                color: isDark
                                    ? context.whiteColor
                                    : context.titleColor,
                              ),
                        ),
                  ),
                  actions: actions,
                  bottom: toolbarBottom,
                  leading: hideLeading
                      ? null
                      : IconButton(
                          icon: Icon(
                            leadingIcon ?? CSIcons.Back,
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                        ),
                  iconTheme: IconThemeData(
                    color: isDark ? context.whiteColor : context.titleColor,
                  ),
                  actionsIconTheme: IconThemeData(
                    color: isDark ? context.whiteColor : context.titleColor,
                  ),
                  backgroundColor: headerBgColor ?? context.bgScaffoldColor,
                  brightness: brightness,
                ),
            body: SafeArea(
              top: addTopInset,
              bottom: addBottomInset,
              child: scrollable ? SingleChildScrollView(child: child) : child,
            ),
            extendBodyBehindAppBar: extendBodyBehindAppBar,
          ),
          if (bottomChild != null) bottomChild,
        ],
      ),
    );
  }
}
