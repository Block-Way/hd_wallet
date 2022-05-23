part of community_domain_module;

abstract class CommunityState
    implements Built<CommunityState, CommunityStateBuilder> {
// Constructors
  factory CommunityState() {
    return _$CommunityState._(
      communityBlacklist: BuiltList([]),
      communityTeamList: BuiltList([]),
      communityMemberList: BuiltList([]),
      configState: ConfigState.loading.index,
    );
  }
  CommunityState._();

  factory CommunityState.fromCache(
    List<dynamic> data,
  ) {
    try {
      return _$CommunityState._(
        communityBlacklist: BuiltList([]),
        communityTeamList: BuiltList([]),
        communityMemberList: BuiltList([]),
        configState: ConfigState.loading.index,
        config: deserialize<CommunityConfig>(data[0]),
      );
    } catch (_) {
      return CommunityState();
    }
  }

  List<dynamic> toCache() {
    try {
      return [
        serialize<CommunityConfig>(config),
      ];
    } catch (_) {
      return [];
    }
  }

// Config
  @nullable
  CommunityConfig get config;

  @nullable
  int get configState;

// Fields
  @nullable
  BuiltList<CommunityTeam> get communityTeamList;

  @nullable
  BuiltList<CommunityMember> get communityMemberList;

  @nullable
  BuiltList<CommunityTeam> get communityBlacklist;
}
