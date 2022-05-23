part of community_domain_module;

abstract class CommunityEcological
    implements Built<CommunityEcological, CommunityEcologicalBuilder> {
// Constructors
  factory CommunityEcological([Function(CommunityEcologicalBuilder) b]) =
      _$CommunityEcological;
  CommunityEcological._();

  static Serializer<CommunityEcological> get serializer =>
      _$communityEcologicalSerializer;

// Fields

  @nullable
  String get chain;

  @nullable
  @BuiltValueField(wireName: 'currency')
  String get symbol;

  @nullable
  String get name;

  @nullable
  String get fork;

  @nullable
  String get id;
}
