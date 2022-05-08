part of widgets;

const kCSListViewDefaultTake = 10;

enum CSListViewState {
  initial,
  loadingFirst,
  loadingMore,
  refreshing,
  loaded,
  error
}

class CSListViewParams<T> {
  CSListViewParams({
    this.requestId,
    this.skip = 0,
    this.take = kCSListViewDefaultTake,
    this.delay = 0,
    this.itemCount = 0,
    this.isRefresh = false,
    this.state = CSListViewState.initial,
    this.cacheState = CSListViewState.initial,
    this.params,
  }) {
    requestId = requestId ?? generateUuidV4();
  }

  factory CSListViewParams.withParams(T params, {int delay}) {
    return CSListViewParams<T>(
      params: params,
      delay: delay ?? 0,
    );
  }

  /// Unique identifier for this request
  String requestId;
  final int skip;
  final int take;
  final int delay;
  final int itemCount;
  final bool isRefresh;
  final CSListViewState state;
  final CSListViewState cacheState;
  final T params;

  /// Current page, calculated from skip and take
  int get page => skip ~/ take;

  /// Return true if is fetching data
  bool get isFetching =>
      state == CSListViewState.loadingFirst ||
      state == CSListViewState.loadingMore ||
      state == CSListViewState.refreshing;

  /// Return true if need to show loading in middle of page to the user
  bool get isLoading =>
      state == CSListViewState.loadingFirst ||
      (state == CSListViewState.refreshing && itemCount == 0) ||
      (state == CSListViewState.loadingMore && itemCount == 0);

  bool get isSyncing => isSyncCacheLoading || isSyncCacheFailed;

  bool get hasSyncCache => cacheState != CSListViewState.initial;

  bool get isSyncCacheLoading =>
      cacheState == CSListViewState.loaded &&
      itemCount > 0 &&
      state == CSListViewState.loadingFirst;

  bool get isSyncCacheFailed =>
      cacheState == CSListViewState.loaded &&
      itemCount > 0 &&
      state == CSListViewState.error;

  /// Return true if data is loaded and no items
  bool get isEmpty => itemCount == 0 && state == CSListViewState.loaded;

  /// Return true if need to show error
  bool get isError => itemCount == 0 && state == CSListViewState.error;

  CSListViewParams<T> copyWith({
    String requestId,
    int skip,
    int take,
    int delay,
    int itemCount,
    bool isRefresh,
    CSListViewState state,
    CSListViewState cacheState,
    T params,
  }) {
    return CSListViewParams<T>(
      requestId: requestId ?? this.requestId,
      skip: skip ?? this.skip,
      take: take ?? this.take,
      delay: delay ?? this.delay,
      itemCount: itemCount ?? this.itemCount,
      isRefresh: isRefresh ?? this.isRefresh,
      state: state ?? this.state,
      cacheState: cacheState ?? this.cacheState,
      params: params ?? this.params,
    );
  }

  @override
  String toString() {
    return '''(requestId: $requestId, skip: $skip, take: $take, itemCount: $itemCount, isRefresh: $isRefresh, state: $state, params: $params)''';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is CSListViewParams<T> &&
        o.requestId == requestId &&
        o.skip == skip &&
        o.take == take &&
        o.delay == delay &&
        o.itemCount == itemCount &&
        o.isRefresh == isRefresh &&
        o.state == state &&
        o.cacheState == cacheState &&
        o.params == params;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        skip.hashCode ^
        take.hashCode ^
        delay.hashCode ^
        itemCount.hashCode ^
        isRefresh.hashCode ^
        state.hashCode ^
        cacheState.hashCode ^
        params.hashCode;
  }
}

class CSListViewStream<T> extends HookWidget {
  const CSListViewStream({
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.requestStream,
    @required this.onLoadData,
    Key key,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.itemExtent,
    this.emptyLabel,
    this.emptyWidget,
    this.itemHeader,
    this.emptyImageUrl,
    this.errorEmptyUrl,
    this.headerBgColor,
    this.slivers,
    this.margin,
    this.padding,
    this.decoration,
    this.refreshController,
    this.scrollController,
    this.onLoadCachedData,
  }) : super(key: key);

  final int itemCount;
  final double itemExtent;
  final bool enablePullUp;
  final bool enablePullDown;
  final String emptyLabel;
  final Widget itemHeader;
  final Widget emptyWidget;
  final String emptyImageUrl;
  final String errorEmptyUrl;
  final Color headerBgColor;
  final List<Widget> slivers;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxDecoration decoration;
  final ScrollController scrollController;
  final RefreshController refreshController;
  final StreamController<CSListViewParams<T>> requestStream;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Future<int> Function(CSListViewParams<T> params) onLoadData;
  final Future<int> Function(CSListViewParams<T> params) onLoadCachedData;

  @override
  Widget build(BuildContext context) {
    final request = useMemoized(
      () => requestStream ?? StreamController<CSListViewParams<T>>(),
    );
    final paramsChanges = useBehaviorStreamController<CSListViewParams<T>>();
    final _refreshController = useMemoized(
      () => refreshController ?? RefreshController(),
    );

    useEffect(() {
      request.stream
          .where((params) {
            if (params.isFetching) {
              _refreshController.refreshToIdle();
              return false;
            }
            return true;
          })
          .map((params) {
            int newSkip;
            CSListViewState newState;
            if (params.isRefresh == true) {
              // For refresh, reset skip, start from first page
              newSkip = 0;
              newState = params.state == CSListViewState.initial
                  ? CSListViewState.loadingFirst
                  : CSListViewState.refreshing;
            } else {
              // If I have items, increase the skip to fetch next page
              if (params.itemCount > 0) {
                newSkip = params.skip + params.take;
              } else {
                newSkip = 0;
              }
              newState = newSkip == 0
                  ? CSListViewState.loadingFirst
                  : CSListViewState.loadingMore;
            }
            return params.copyWith(
              state: newState,
              skip: newSkip,
            );
          })
          .switchMap((params) {
            if (onLoadCachedData != null) {
              paramsChanges.add(
                params.copyWith(
                  cacheState: params.state,
                ),
              );
              return onLoadCachedData(params).asStream().map((count) {
                return params.copyWith(
                  itemCount: count,
                  cacheState: CSListViewState.loaded,
                );
              }).onErrorReturnWith(
                (error) => params.copyWith(
                  cacheState: CSListViewState.error,
                ),
              );
            }
            return Stream.value(params);
          })
          .doOnData((params) {
            dev.log('Load Request: $params');
            // Save current params, so if call API failed,
            //  the onRetry button will have the latest params
            paramsChanges.add(params);
          })
          .switchMap((params) => TimerStream(
              params,
              Duration(
                // Delay base on params conditions
                seconds: params.skip == 0 ? params.delay : 0,
              )))
          .switchMap((params) {
            return onLoadData(params)
                .asStream()
                .map((count) => params.copyWith(
                      itemCount: count,
                      state: CSListViewState.loaded,
                    ))
                .onErrorReturnWith((error) => params.copyWith(
                      state: CSListViewState.error,
                    ));
          })
          .doOnData((params) {
            dev.log('Load Finish: $params');

            // Make sure we are the same last request
            if (params.requestId != paramsChanges.value.requestId) {
              return;
            }

            if (params.state == CSListViewState.error) {
              if (params.isRefresh) {
                _refreshController.refreshFailed();
              } else {
                _refreshController.loadFailed();
              }
            } else {
              if (params.isRefresh) {
                _refreshController.refreshCompleted(resetFooterState: true);
              } else {
                _refreshController.loadComplete();
              }
              // If I have less items the current skip + take,
              // there are no more data
              if (params.itemCount < (params.skip + params.take)) {
                _refreshController.loadNoData();
              }
            }
            if (!paramsChanges.isClosed) {
              paramsChanges.add(params.copyWith(isRefresh: false));
            }
          })
          .listen((params) {
            //
          });

      return () {
        request.close();
      };
    }, []);

    return StreamBuilder<CSListViewParams<T>>(
      stream: paramsChanges.stream,
      initialData: CSListViewParams(),
      builder: (context, snapshot) => SmartRefresher(
        primary: true,
        controller: _refreshController,
        scrollController: scrollController,
        enablePullUp: !snapshot.data.isLoading && enablePullUp,
        enablePullDown: !snapshot.data.isLoading && enablePullDown,
        onRefresh: () {
          request.add(paramsChanges.value.copyWith(isRefresh: true));
        },
        onLoading: () {
          request.add(paramsChanges.value.copyWith(isRefresh: false));
        },
        header: ListViewHeader(
          background: headerBgColor,
        ),
        footer: ListViewFooter(
          data: snapshot.data,
          itemCount: itemCount,
        ),
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            if (slivers != null) ...slivers,
            if (itemCount == 0 &&
                (snapshot.data.isLoading ||
                    snapshot.data.isEmpty ||
                    snapshot.data.isError))
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  margin: margin,
                  padding: padding ?? EdgeInsets.zero,
                  decoration: decoration,
                  child: snapshot.data.isEmpty && emptyWidget != null
                      ? emptyWidget
                      : CSEmpty(
                          label: snapshot.data.isEmpty
                              ? emptyLabel
                              : tr('global:list_load_failed'),
                          header: itemHeader,
                          imageUrl: snapshot.data.isEmpty
                              ? emptyImageUrl
                              : errorEmptyUrl ??
                                  'assets/images/error_record.png',
                          isLoading: snapshot.data.isLoading,
                          showButton: snapshot.data.isError,
                          width: snapshot.data.isError ? 121 : 133,
                          height: 120,
                          btnText: tr('global:btn_refresh'),
                          onPressed: () {
                            request.add(
                              paramsChanges.value.copyWith(isRefresh: true),
                            );
                          },
                        ),
                ),
              )
            else
              SliverGroupBuilder(
                margin: margin,
                padding: padding ?? EdgeInsets.zero,
                decoration: decoration,
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final data = snapshot.data;
                      final showHeader = index == 0 &&
                          (data.hasSyncCache || itemHeader != null);
                      if (showHeader) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: itemHeader == null && data.isSyncing
                                  ? 40
                                  : null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (itemHeader != null) itemHeader,
                                  if (itemHeader != null) Spacer(),
                                  if (data.isSyncCacheLoading)
                                    Text(
                                      tr('global:list_load_cache_syncing'),
                                      style: context.textTiny(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  if (data.isSyncCacheFailed)
                                    Text(
                                      tr('global:list_load_cache_failed'),
                                      style: context.textTiny(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  SizedBox(width: context.edgeSize),
                                  if (data.isSyncCacheLoading)
                                    CSProgressIndicator(
                                      size: context.edgeSize,
                                      color: context.secondaryColor,
                                      strokeWidth: 1,
                                    ),
                                  SizedBox(width: 2),
                                ],
                              ),
                            ),
                            itemBuilder(context, index),
                          ],
                        );
                      }
                      return itemBuilder(context, index);
                    },
                    childCount: itemCount,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
