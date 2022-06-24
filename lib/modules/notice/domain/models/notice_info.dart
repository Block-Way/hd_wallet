part of notice_domain_module;

abstract class NoticeInfo implements Built<NoticeInfo, NoticeInfoBuilder> {
// Constructors
  factory NoticeInfo([Function(NoticeInfoBuilder) b]) = _$NoticeInfo;
  NoticeInfo._();

  static Serializer<NoticeInfo> get serializer => _$noticeInfoSerializer;

  static NoticeInfo? fromJson(Map<String, dynamic> json) {
    return deserialize<NoticeInfo>(json);
  }

// Fields
  //@nullable
  int? get id;

  //@nullable
  String? get title;

  @BuiltValueField(wireName: 'cover_img')
  //@nullable
  String? get coverImg;

  @BuiltValueField(wireName: 'created_at')
  //@nullable
  int? get createdAt;

  @BuiltValueField(wireName: 'share_img')
  //@nullable
  BuiltList<String>? get shareImg;

  @memoized
  String get image => AppConfig().getImageUrlFor(coverImg ?? '');

  @memoized
  List<String> get shareImgWithUrl => shareImg != null
      ? shareImg!
          .map<String>((item) => AppConfig().getImageUrlFor(item))
          .toList()
      : [];

  String get displayCreatedAt =>
      formatDate(DateTime.fromMillisecondsSinceEpoch((createdAt ?? 0) * 1000));
}
