part of community_domain_module;

abstract class CommunityTeamOptions
    implements Built<CommunityTeamOptions, CommunityTeamOptionsBuilder> {
  // Constructors
  factory CommunityTeamOptions([Function(CommunityTeamOptionsBuilder) b]) =
      _$CommunityTeamOptions;
  CommunityTeamOptions._();

  static Serializer<CommunityTeamOptions> get serializer =>
      _$communityTeamOptionsSerializer;

// Fields
  @nullable
  @BuiltValueField(wireName: 'valid_address_count')
  int get addressCount;

  @nullable
  @BuiltValueField(wireName: 'valid_address_average_balance')
  BuiltMap<String, String> get addressAverageBalance;

  @nullable
  @BuiltValueField(wireName: 'business_info')
  BuiltList<String> get businessInfo;

  @nullable
  @BuiltValueField(wireName: 'telegram_account')
  String get telegramAccount;

  @nullable
  String get icon;

  @nullable
  @BuiltValueField(wireName: 'join_apply_type')
  String get joinApplyType;

  @nullable
  @BuiltValueField(wireName: 'admin')
  BuiltMap<String, String> get admin;

  String get displayIcon => icon != null
      ? AppConfig().getImageUrlFor(icon)
      : 'assets/images/app_default_logo.png';
}
