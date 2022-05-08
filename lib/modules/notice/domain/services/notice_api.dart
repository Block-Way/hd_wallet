part of notice_domain_module;

class NoticeApi {
  Future<List<Map<String, dynamic>>> getNoticeList({
    @required int skip,
    @required int take,
  }) =>
      Request()
          .getListOfObjects('/v1/system_notice/lists?skip=$skip&take=$take');

  Future<Map<String, dynamic>> getNoticeDetail(int id) =>
      Request().getValue<Map<String, dynamic>>('v1/system_notice/$id/info');
}
