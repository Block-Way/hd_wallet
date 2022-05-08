part of home_ui_module;

class DotBuilder extends SwiperPlugin {
  const DotBuilder({
    this.activeColor,
    this.color,
    this.key,
    this.size = 10.0,
    this.activeSize = 10.0,
    this.space = 3.0,
  });

  ///color when current index,if set null ,
  /// will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double activeSize;

  ///Size of the dot
  final double size;

  /// Space between dots
  final double space;

  final Key key;

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    var activeColor = this.activeColor;
    var color = this.color;

    if (activeColor == null || color == null) {
      final themeData = Theme.of(context);
      activeColor = this.activeColor ?? themeData.primaryColor;
      color = this.color ?? themeData.scaffoldBackgroundColor;
    }

    if (config.indicatorLayout != PageIndicatorLayout.NONE &&
        config.layout == SwiperLayout.DEFAULT) {
      return PageIndicator(
        count: config.itemCount,
        controller: config.pageController,
        layout: config.indicatorLayout,
        size: size,
        activeColor: activeColor,
        color: color,
        space: space,
      );
    }

    final list = <Widget>[];

    final itemCount = config.itemCount;
    final activeIndex = config.activeIndex;

    for (var i = 0; i < itemCount; ++i) {
      final active = i == activeIndex;
      list.add(
        Container(
          key: Key('pagination_$i'),
          child: Opacity(
            opacity: active ? 1 : 0.5,
            child: Container(
              width: 17,
              height: 4,
              decoration: BoxDecoration(
                color: active ? activeColor : color,
                borderRadius: i == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomLeft: Radius.circular(2),
                      )
                    : i + 1 == itemCount
                        ? BorderRadius.only(
                            topRight: Radius.circular(2),
                            bottomRight: Radius.circular(2),
                          )
                        : BorderRadius.all(
                            Radius.circular(0),
                          ),
              ),
            ),
          ),
        ),
      );
    }

    final dotWidth = 15.0 * itemCount;
    return itemCount == 1
        ? Container()
        : Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: Container(
                  width: dotWidth,
                  height: 3,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(2),
                    ),
                  ),
                ),
              ),
              Row(
                key: key,
                mainAxisSize: MainAxisSize.min,
                children: list,
              ),
            ],
          );
  }
}

class SwiperCSPagination extends SwiperPlugin {
  const SwiperCSPagination({
    this.alignment,
    this.key,
    this.margin = const EdgeInsets.all(24.0),
    this.builder = SwiperPagination.dots,
  });

  /// dot style pagination
  static const SwiperPlugin dots = DotBuilder();

  /// Alignment.bottomCenter by default when scrollDirection== Axis.horizontal
  /// Alignment.centerRight by default when scrollDirection== Axis.vertical
  final Alignment alignment;

  /// Distance between pagination and the container
  final EdgeInsetsGeometry margin;

  /// Build the widget
  final SwiperPlugin builder;

  final Key key;

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    Widget child = Container(
      margin: margin,
      child: builder.build(context, config),
    );
    if (!config.outer) {
      child = Align(
        key: key,
        alignment: Alignment.bottomCenter,
        child: child,
      );
    }
    return child;
  }
}
