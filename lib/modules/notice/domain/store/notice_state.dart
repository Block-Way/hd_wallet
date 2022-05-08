part of notice_domain_module;

abstract class NoticeState implements Built<NoticeState, NoticeStateBuilder> {
// Constructors
  factory NoticeState() {
    return _$NoticeState._(
      noticeList: BuiltList([]),
      noticeLatest: BuiltList([]),
    );
  }
  NoticeState._();

  factory NoticeState.fromCache(
    List<dynamic> data,
  ) {
    try {
      return _$NoticeState._(
        noticeList:
            deserializeListOf<NoticeInfo>(data[0]) ?? BuiltList<NoticeInfo>([]),
        noticeLatest:
            deserializeListOf<NoticeInfo>(data[1]) ?? BuiltList<NoticeInfo>([]),
      );
    } catch (_) {
      return NoticeState();
    }
  }

  List<dynamic> toCache() {
    try {
      return [
        serializeListOf<NoticeInfo>(noticeList),
        serializeListOf<NoticeInfo>(noticeLatest),
      ];
    } catch (_) {
      return [];
    }
  }

// Fields
  @nullable
  BuiltList<NoticeInfo> get noticeList;

  @nullable
  BuiltList<NoticeInfo> get noticeLatest;

  @nullable
  NoticeInfo get noticeDetail;
}
