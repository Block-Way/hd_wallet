part of widgets;

/// return true is refresh success
///
/// return false or null is fail

class LoadMore extends StatefulWidget {
  const LoadMore({
    @required this.child,
    @required this.onLoadMore,
    Key key,
    this.textBuilder,
    this.isFinish = false,
    this.delegate,
    this.whenEmptyLoad = true,
  }) : super(key: key);

  static LoadMoreDelegate buildDelegate() => DefaultLoadMoreDelegate();

  static LoadMoreTextBuilder buildTextBuilder() =>
      DefaultLoadMoreTextBuilder.chinese;

  /// Only support [ListView],[SliverList]
  final Widget child;

  /// return true is refresh success
  ///
  /// return false or null is fail
  final Future<bool> Function() onLoadMore;

  /// if [isFinish] is true,
  /// then loadMoreWidget status is [LoadMoreStatus.noMore].
  final bool isFinish;

  /// see [LoadMoreDelegate]
  final LoadMoreDelegate delegate;

  /// see [LoadMoreTextBuilder]
  final LoadMoreTextBuilder textBuilder;

  /// when [whenEmptyLoad] is true,
  /// and when listView children length is 0,
  /// or the itemCount is 0,not build loadMoreWidget
  final bool whenEmptyLoad;

  @override
  _LoadMoreState createState() => _LoadMoreState();
}

class _LoadMoreState extends State<LoadMore> {
  Widget get child => widget.child;

  LoadMoreDelegate get loadMoreDelegate =>
      widget.delegate ?? LoadMore.buildDelegate();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onLoadMore == null) {
      return child;
    }
    if (child is ListView) {
      return _buildListView(child as ListView);
    }
    if (child is SliverList) {
      return _buildSliverList(child as SliverList);
    }
    return child;
  }

  /// if call the method, then the future is not null
  /// so, return a listView and  item count + 1
  Widget _buildListView(ListView listView) {
    final delegate = listView.childrenDelegate;
    outer:
    if (delegate is SliverChildBuilderDelegate) {
      final delegate = listView.childrenDelegate as SliverChildBuilderDelegate;
      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }
      final viewCount = delegate.estimatedChildCount + 1;
      Widget builder(BuildContext context, int index) {
        if (index == viewCount - 1) {
          return _buildLoadMoreView();
        }
        return delegate.builder(context, index);
      }

      return ListView.builder(
        itemBuilder: builder,
        addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
        addRepaintBoundaries: delegate.addRepaintBoundaries,
        addSemanticIndexes: delegate.addSemanticIndexes,
        dragStartBehavior: listView.dragStartBehavior,
        semanticChildCount: listView.semanticChildCount,
        itemCount: viewCount,
        cacheExtent: listView.cacheExtent,
        controller: listView.controller,
        itemExtent: listView.itemExtent,
        key: listView.key,
        padding: listView.padding,
        physics: listView.physics,
        primary: listView.primary,
        reverse: listView.reverse,
        scrollDirection: listView.scrollDirection,
        shrinkWrap: listView.shrinkWrap,
      );
    } else if (delegate is SliverChildListDelegate) {
      final delegate = listView.childrenDelegate as SliverChildListDelegate;

      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }

      delegate.children.add(_buildLoadMoreView());
      return ListView(
        addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
        addRepaintBoundaries: delegate.addRepaintBoundaries,
        cacheExtent: listView.cacheExtent,
        controller: listView.controller,
        itemExtent: listView.itemExtent,
        key: listView.key,
        padding: listView.padding,
        physics: listView.physics,
        primary: listView.primary,
        reverse: listView.reverse,
        scrollDirection: listView.scrollDirection,
        shrinkWrap: listView.shrinkWrap,
        addSemanticIndexes: delegate.addSemanticIndexes,
        dragStartBehavior: listView.dragStartBehavior,
        semanticChildCount: listView.semanticChildCount,
        children: delegate.children,
      );
    }
    return listView;
  }

  Widget _buildSliverList(SliverList list) {
    final delegate = list.delegate;
    if (delegate == null) {
      return list;
    }

    if (delegate is SliverChildListDelegate) {
      return SliverList(
        delegate: null,
      );
    }

    outer:
    if (delegate is SliverChildBuilderDelegate) {
      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }
      final viewCount = delegate.estimatedChildCount + 1;
      Widget builder(BuildContext context, int index) {
        if (index == viewCount - 1) {
          return _buildLoadMoreView();
        }
        return delegate.builder(context, index);
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          builder,
          addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
          addRepaintBoundaries: delegate.addRepaintBoundaries,
          addSemanticIndexes: delegate.addSemanticIndexes,
          childCount: viewCount,
          semanticIndexCallback: delegate.semanticIndexCallback,
          semanticIndexOffset: delegate.semanticIndexOffset,
        ),
      );
    }

    outer:
    if (delegate is SliverChildListDelegate) {
      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }
      delegate.children.add(_buildLoadMoreView());
      return SliverList(
        delegate: SliverChildListDelegate(
          delegate.children,
          addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
          addRepaintBoundaries: delegate.addRepaintBoundaries,
          addSemanticIndexes: delegate.addSemanticIndexes,
          semanticIndexCallback: delegate.semanticIndexCallback,
          semanticIndexOffset: delegate.semanticIndexOffset,
        ),
      );
    }

    return list;
  }

  LoadMoreStatus status = LoadMoreStatus.idle;

  Widget _buildLoadMoreView() {
    if (widget.isFinish == true) {
      status = LoadMoreStatus.noMore;
    } else {
      if (status == LoadMoreStatus.noMore) {
        status = LoadMoreStatus.idle;
      }
    }
    return NotificationListener<_RetryNotify>(
      onNotification: _onRetry,
      child: NotificationListener<_BuildNotify>(
        onNotification: _onLoadMoreBuild,
        child: DefaultLoadMoreView(
          status: status,
          delegate: loadMoreDelegate,
          textBuilder: widget.textBuilder ?? LoadMore.buildTextBuilder(),
        ),
      ),
    );
  }

  bool _onLoadMoreBuild(_BuildNotify notification) {
    //判断状态，触发对应的操作
    if (status == LoadMoreStatus.loading) {
      return false;
    }
    if (status == LoadMoreStatus.noMore) {
      return false;
    }
    if (status == LoadMoreStatus.fail) {
      return false;
    }
    if (status == LoadMoreStatus.idle) {
      // 切换状态为加载中，并且触发回调
      loadMore();
    }
    return false;
  }

  void _updateStatus(LoadMoreStatus status) {
    if (mounted) {
      setState(() => this.status = status);
    }
  }

  bool _onRetry(_RetryNotify notification) {
    loadMore();
    return false;
  }

  void loadMore() {
    _updateStatus(LoadMoreStatus.loading);
    widget.onLoadMore().then((v) {
      if (v == true) {
        // 成功，切换状态为空闲
        _updateStatus(LoadMoreStatus.idle);
      } else {
        // 失败，切换状态为失败
        _updateStatus(LoadMoreStatus.fail);
      }
    });
  }
}

enum LoadMoreStatus {
  /// 空闲中，表示当前等待加载
  ///
  /// wait for loading
  idle,

  /// 刷新中，不应该继续加载，等待future返回
  ///
  /// the view is loading
  loading,

  /// 刷新失败，刷新失败，这时需要点击才能刷新
  ///
  /// loading fail, need tap view to loading
  fail,

  /// 没有更多，没有更多数据了，这个状态不触发任何条件
  ///
  /// not have more data
  noMore,
}

class DefaultLoadMoreView extends StatefulWidget {
  const DefaultLoadMoreView({
    @required this.delegate,
    @required this.textBuilder,
    this.status = LoadMoreStatus.idle,
    Key key,
  }) : super(key: key);

  final LoadMoreStatus status;
  final LoadMoreDelegate delegate;
  final LoadMoreTextBuilder textBuilder;

  @override
  DefaultLoadMoreViewState createState() => DefaultLoadMoreViewState();
}

const _defaultLoadMoreHeight = 80.0;
const _loadMoreIndicatorSize = 33.0;
const _loadMoreDelay = 16;

class DefaultLoadMoreViewState extends State<DefaultLoadMoreView> {
  LoadMoreDelegate get delegate => widget.delegate;

  @override
  Widget build(BuildContext context) {
    notify();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.status == LoadMoreStatus.fail ||
            widget.status == LoadMoreStatus.idle) {
          _RetryNotify().dispatch(context);
        }
      },
      child: Container(
        height: delegate.widgetHeight(widget.status),
        alignment: Alignment.center,
        child: delegate.buildChild(
          widget.status,
          builder: widget.textBuilder,
        ),
      ),
    );
  }

  Future<void> notify() async {
    final delay = max(delegate.loadMoreDelay(), Duration(milliseconds: 16));
    await Future<void>.delayed(delay);
    if (widget.status == LoadMoreStatus.idle) {
      _BuildNotify().dispatch(context);
    }
  }

  Duration max(Duration duration, Duration duration2) {
    if (duration > duration2) {
      return duration;
    }
    return duration2;
  }
}

class _BuildNotify extends Notification {}

class _RetryNotify extends Notification {}

// ignore: prefer_generic_function_type_aliases
typedef T DelegateBuilder<T>();

/// load more widget properties
abstract class LoadMoreDelegate {
  const LoadMoreDelegate();

  // ignore: prefer_function_declarations_over_variables
  static final DelegateBuilder<LoadMoreDelegate> buildWidget =
      () => DefaultLoadMoreDelegate();

  /// the load more widget height
  double widgetHeight(LoadMoreStatus status) => _defaultLoadMoreHeight;

  /// build load more delay
  Duration loadMoreDelay() => Duration(milliseconds: _loadMoreDelay);

  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese});
}

class DefaultLoadMoreDelegate extends LoadMoreDelegate {
  const DefaultLoadMoreDelegate();

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    final text = builder(status);
    if (status == LoadMoreStatus.fail) {
      return Text(text);
    }
    if (status == LoadMoreStatus.idle) {
      return Text(text);
    }
    if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CSProgressIndicator(
              size: _loadMoreIndicatorSize,
              backgroundColor: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ],
        ),
      );
    }
    if (status == LoadMoreStatus.noMore) {
      return Text(text);
    }

    return Text(text);
  }
}

// ignore: prefer_generic_function_type_aliases
typedef String LoadMoreTextBuilder(LoadMoreStatus status);

String _buildChineseText(LoadMoreStatus status) {
  String text;
  switch (status) {
    case LoadMoreStatus.fail:
      text = '加载失败，请点击重试';
      break;
    case LoadMoreStatus.idle:
      text = '等待加载更多';
      break;
    case LoadMoreStatus.loading:
      text = '加载中，请稍候...';
      break;
    case LoadMoreStatus.noMore:
      text = '到底了，别扯了';
      break;
    default:
      text = '';
  }
  return text;
}

String _buildEnglishText(LoadMoreStatus status) {
  String text;
  switch (status) {
    case LoadMoreStatus.fail:
      text = 'load fail, tap to retry';
      break;
    case LoadMoreStatus.idle:
      text = 'wait for loading';
      break;
    case LoadMoreStatus.loading:
      text = 'loading, wait for moment ...';
      break;
    case LoadMoreStatus.noMore:
      text = 'no more data';
      break;
    default:
      text = '';
  }
  return text;
}

class DefaultLoadMoreTextBuilder {
  static const LoadMoreTextBuilder chinese = _buildChineseText;

  static const LoadMoreTextBuilder english = _buildEnglishText;
}
