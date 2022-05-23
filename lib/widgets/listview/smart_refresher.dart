part of widgets;

class CSRefresherController extends RefreshController {
  Function _listener;
  // ignore: use_setters_to_change_properties
  void addListener(Function listener) {
    _listener = listener;
  }

  @override
  void refreshCompleted({
    bool resetFooterState = false,
    bool noticeListener = true,
  }) {
    if (_listener != null && noticeListener) {
      _listener();
    }
    super.refreshCompleted(resetFooterState: resetFooterState);
  }
}

class CSRefresher extends HookWidget {
  const CSRefresher({
    @required this.child,
    this.onRefresh,
    this.controller,
    this.scrollController,
    this.refreshDelay,
    this.header,
  });

  final CSRefresherController controller;
  final ScrollController scrollController;
  final Widget child;
  final Widget header;
  final Function onRefresh;
  final Duration refreshDelay;

  @override
  Widget build(BuildContext context) {
    final widgetStream = useStreamController<bool>();
    final lastCompletedTime = useValueNotifier(0);

    final refreshController = useMemoized(
      () => controller ?? CSRefresherController(),
    );

    useEffect(() {
      refreshController.addListener(() {
        if (widgetStream.isClosed) {
          return;
        }
        lastCompletedTime.value = DateTime.now().millisecondsSinceEpoch;
      });
      return () {
        refreshController.dispose();
      };
    }, []);

    Future<void> handleRefresh() async {
      final nowTime = DateTime.now().millisecondsSinceEpoch;
      final subDate = nowTime - lastCompletedTime.value;
      if (refreshDelay != null && subDate < refreshDelay.inMilliseconds) {
        await Future.delayed(Duration(seconds: 2));
        refreshController.refreshCompleted(noticeListener: false);
      } else if (onRefresh != null) {
        onRefresh();
      }
    }

    return SmartRefresher(
      onRefresh: handleRefresh,
      header: header,
      controller: refreshController,
      scrollController: scrollController,
      child: child,
    );
  }
}
