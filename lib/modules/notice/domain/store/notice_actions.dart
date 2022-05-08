part of notice_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class NoticeActionGetList extends _BaseAction {
  NoticeActionGetList({this.isRefresh, this.skip});
  final bool isRefresh;
  final int skip;

  @override
  Future<AppState> reduce() async {
    final list = await NoticeRepository().getNoticeList(skip: skip, take: 10);

    return state.rebuild(
      (s) => skip == 0
          ? s.noticeState.noticeList.replace(list)
          : s.noticeState.noticeList.addAll(list),
    );
  }
}

class NoticeActionGetDetail extends _BaseAction {
  NoticeActionGetDetail(this.id);
  final int id;

  @override
  Future<AppState> reduce() async {
    final data = await NoticeRepository().getNoticeDetail(id);
    return state.rebuild((s) => s.noticeState.noticeDetail = data.toBuilder());
  }
}

class NoticeActionGetLatest extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final list = await NoticeRepository().getNoticeLatest();
    return state.rebuild((s) => s.noticeState.noticeLatest.replace(list));
  }
}
