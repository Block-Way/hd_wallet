part of community_domain_module;

class CommunityRepository {
  factory CommunityRepository([CommunityApi _api]) {
    _instance._api = _api ?? CommunityApi();
    return _instance;
  }
  CommunityRepository._internal();

  CommunityApi _api;

  static final _instance = CommunityRepository._internal();

  Future<CommunityConfig> getConfig() async {
    final json = await _api.getConfig();
    return CommunityConfig.fromJson(json);
  }

  Future<List<CommunityTeam>> getCommunityTeamList({
    @required int skip,
    @required int take,
    @required String type,
    String searchName,
    String fork,
  }) async {
    final json = await _api.getCommunityTeamList(
      skip: skip,
      take: take,
      searchName: searchName,
      fork: fork,
      type: type,
    );
    return deserializeListOf<CommunityTeam>(json).toList();
  }

  Future<List<CommunityMember>> getCommunityMemberList({
    @required int skip,
    @required int take,
    @required String id,
    String searchName,
  }) async {
    final json = await _api.getCommunityMemberList(
      skip: skip,
      take: take,
      searchName: searchName,
      id: id,
    );
    return deserializeListOf<CommunityMember>(json).toList();
  }

  Future<void> submitCommunity({
    @required String walletId,
    @required int type,
    @required String name,
    @required String desc,
    @required String fork,
    @required String telegram,
    @required String logo,
    @required String extraInfo,
  }) async {
    return _api.submitCommunity(
      walletId: walletId,
      type: type,
      name: name,
      desc: desc,
      fork: fork,
      telegram: telegram,
      logo: logo,
      extraInfo: extraInfo,
    );
  }

  Future<void> joinCommunity({
    @required String walletId,
    @required int type,
    @required String teamId,
    @required String name,
    @required String desc,
    @required String logo,
    @required String telegram,
    @required String github,
    String extraInfo,
  }) async {
    return _api.joinCommunity(
      walletId: walletId,
      type: type,
      teamId: teamId,
      name: name,
      desc: desc,
      logo: logo,
      telegram: telegram,
      github: github,
      extraInfo: extraInfo,
    );
  }

  Future<CommunityTeam> getOwnCommunity({
    String walletId,
    String type,
  }) async {
    final json = await _api.getOwnCommunity(
      walletId: walletId,
      type: type,
    );
    if (json.keys.toList().isEmpty) {
      return null;
    }
    json['is_mine'] = true;
    return CommunityTeam.fromJson(json);
  }

  Future<CommunityMember> getOwnMember({
    String walletId,
    String type,
  }) async {
    final json = await _api.getOwnMember(
      walletId: walletId,
      type: type,
    );

    if (json.keys.toList().isEmpty) {
      return null;
    }

    json['is_mine'] = true;
    return CommunityMember.fromJson(json);
  }

  Future<List<CommunityTeam>> getCommunityBlacklist({
    @required int skip,
    @required int take,
    @required String type,
    String searchName,
    String fork,
  }) async {
    final json = await _api.getCommunityBlacklist(
      skip: skip,
      take: take,
      searchName: searchName,
      fork: fork,
      type: type,
    );
    return deserializeListOf<CommunityTeam>(json).toList();
  }

  Future<CommunityTeam> getTeamInfo({
    String teamId,
  }) async {
    final json = await _api.getTeamInfo(
      teamId: teamId,
    );
    return CommunityTeam.fromJson(json);
  }
}
