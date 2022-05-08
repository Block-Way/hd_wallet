part of widgets;

class ListViewHeader extends RefreshIndicator {
  const ListViewHeader({
    Key key,
    this.color,
    this.background,
    this.useProgressLoading = false,
  }) : super(
          key: key,
          height: useProgressLoading == true ? 60 : 80,
          refreshStyle: RefreshStyle.UnFollow,
        );

  final Color background;
  final Color color;
  final bool useProgressLoading;

  @override
  State<StatefulWidget> createState() {
    return _ListViewHeaderState();
  }
}

class _ListViewHeaderState extends RefreshIndicatorState<ListViewHeader>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _dismissCtl;

  double get headerHeight => widget.useProgressLoading == true ? 60 : 80;

  @override
  void onOffsetChange(double offset) {
    final realOffset = offset - headerHeight;
    if (!_animationController.isAnimating) {
      _animationController.value = realOffset;
    }
  }

  @override
  Future<void> readyToRefresh() {
    _dismissCtl.animateTo(0.0);
    return _animationController.animateTo(0.0);
  }

  @override
  void initState() {
    _dismissCtl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      value: 1.0,
    );
    _animationController = AnimationController(
      vsync: this,
      upperBound: headerHeight,
      duration: Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  bool needReverseAll() {
    return false;
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    Widget child;

    if (mode == RefreshStatus.refreshing || mode == RefreshStatus.completed) {
      if (widget.useProgressLoading == true) {
        child = SizedBox(
          width: 20.0,
          height: 20.0,
          child: CSProgressIndicator(
            color: context.secondaryColor,
          ),
        );
      } else {
        child = RiveAnimation(
          fileName: 'refreshing',
          animation: 'Top Loading',
          width: 100,
          height: 60,
        );
      }
    } else if (mode == RefreshStatus.failed) {
      child = Text(
        tr('global:list_refresh_failed'),
        style: context.textSmall(),
      );
    } else if (mode == RefreshStatus.idle || mode == RefreshStatus.canRefresh) {
      // None
    }
    return Container(
      height: headerHeight,
      color: widget.background ?? context.bgScaffoldColor,
      child: Center(
        child: child,
      ),
    );
  }

  @override
  void resetValue() {
    _animationController.reset();
    _dismissCtl.value = 1.0;
  }

  @override
  void dispose() {
    _dismissCtl.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
