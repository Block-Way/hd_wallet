part of notice_domain_module;

abstract class NoticeListVM
    implements Built<NoticeListVM, NoticeListVMBuilder> {
  factory NoticeListVM([void Function(NoticeListVMBuilder) updates]) =
      _$NoticeListVM;
  NoticeListVM._();

// UI Fields
  @nullable
  BuiltList<NoticeInfo> get noticeList;

  @nullable
  BuiltList<NoticeInfo> get noticeLatest;

  @BuiltValueField(compare: false)
  Future<int> Function(bool isRefresh, int skip) get loadData;

  int get listCount => noticeList != null ? noticeList.length : 0;

  // UI Actions
  static Future<int> _loadData(
    Store<AppState> store,
    bool isRefresh,
    int skip,
  ) async {
    await store.dispatchFuture(NoticeActionGetList(
      isRefresh: isRefresh,
      skip: skip,
    ));
    return Future.value(store.state.noticeState.noticeList?.length ?? 0);
  }

  // UI Logic
  static NoticeListVM fromStore(Store<AppState> store) {
    return NoticeListVM((viewModel) => viewModel
      ..noticeList = store.state.noticeState.noticeList?.toBuilder()
      ..loadData = (isRefresh, skip) async {
        return _loadData(store, isRefresh, skip);
      }
      ..noticeLatest = store.state.noticeState.noticeLatest?.toBuilder());
  }
}
