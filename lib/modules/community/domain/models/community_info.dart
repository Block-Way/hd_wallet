part of community_domain_module;

abstract class CommunityInfo
    implements Built<CommunityInfo, CommunityInfoBuilder> {
// Constructors
  factory CommunityInfo([Function(CommunityInfoBuilder) b]) = _$CommunityInfo;
  CommunityInfo._();

  static Serializer<CommunityInfo> get serializer => _$communityInfoSerializer;

// Fields

  @nullable
  @BuiltValueField(wireName: 'display_type')
  String get displayType;

  bool get isTeamList => displayType == 'TEAM_LIST';

  @nullable
  String get id;

  @nullable
  String get name;

  @nullable
  int get type;

  CommunityTypes get teamType => CommunityUtils.mapCommunityType(type);

  @nullable
  String get describe;

  @nullable
  String get image;

  @BuiltValueField(wireName: 'join_type')
  String get joinType;

  bool get joinIsOnChain => joinType == 'on_chain';

  @nullable
  @BuiltValueField(wireName: 'create_type')
  String get createType;

  bool get canCreate => createType == 'on';

  @nullable
  @BuiltValueField(wireName: 'join_apply_type')
  String get joinApplyType;

  bool get canJoin => joinApplyType == 'on';

  @nullable
  @BuiltValueField(wireName: 'home_quick_start')
  String get homeQuickEntry;

  String get imageUrl => AppConfig().getImageUrlFor(image);
}
