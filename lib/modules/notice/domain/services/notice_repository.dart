part of notice_domain_module;

class NoticeRepository {
  factory NoticeRepository([NoticeApi _api]) {
    _instance._api = _api ?? NoticeApi();
    return _instance;
  }
  NoticeRepository._internal();

  NoticeApi _api;

  static final _instance = NoticeRepository._internal();

  Future<List<NoticeInfo>> getNoticeList({
    @required int skip,
    @required int take,
  }) async {
    final json = await _api.getNoticeList(skip: skip, take: take);
    return deserializeListOf<NoticeInfo>(json).toList();
  }

  Future<List<NoticeInfo>> getNoticeLatest() async {
    final json = await _api.getNoticeList(skip: 0, take: 3);
    return deserializeListOf<NoticeInfo>(json).toList();
  }

  Future<NoticeInfo> getNoticeDetail(int id) async {
    final json = await _api.getNoticeDetail(id);
    return NoticeInfo.fromJson(json);
  }
}
