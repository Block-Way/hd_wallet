part of community_domain_module;

abstract class CommunityMemberInfo
    implements Built<CommunityMemberInfo, CommunityMemberInfoBuilder> {
  // Constructors
  factory CommunityMemberInfo([Function(CommunityMemberInfoBuilder) b]) =
      _$CommunityMemberInfo;
  CommunityMemberInfo._();

  static Serializer<CommunityMemberInfo> get serializer =>
      _$communityMemberInfoSerializer;

  static CommunityMemberInfo? fromJson(Map<String, dynamic> json) {
    return deserialize<CommunityMemberInfo>(json);
  }

  //@nullable
  String? get name;

  //@nullable
  String? get describe;

  //@nullable
  String? get github;

  //@nullable
  String? get icon;

  //@nullable
  @BuiltValueField(wireName: 'telegram_account')
  String? get telegramAccount;

  //@nullable
  @BuiltValueField(wireName: 'admin')
  BuiltMap<String, String>? get admin;

  String get displayIcon => AppConfig().getImageUrlFor(icon ?? '');
}
