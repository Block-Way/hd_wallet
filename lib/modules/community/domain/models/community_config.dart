part of community_domain_module;

abstract class CommunityConfig
    implements Built<CommunityConfig, CommunityConfigBuilder> {
// Constructors
  factory CommunityConfig([Function(CommunityConfigBuilder) b]) =
      _$CommunityConfig;
  CommunityConfig._();

  static Serializer<CommunityConfig> get serializer =>
      _$communityConfigSerializer;

  static CommunityConfig fromJson(Map<String, dynamic> json) {
    return deserialize<CommunityConfig>(json);
  }

// Fields
  @nullable
  String get fork;

  @nullable
  @BuiltValueField(wireName: 'home_list')
  BuiltList<int> get homeList;

  @nullable
  @BuiltValueField(wireName: 'type')
  BuiltList<CommunityInfo> get types;

  @nullable
  @BuiltValueField(wireName: 'ecological')
  BuiltList<CommunityEcological> get ecological;
}
