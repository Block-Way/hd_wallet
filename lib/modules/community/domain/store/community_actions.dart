part of community_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  String get walletId => store.state.walletState.activeWalletId;
  CommunityConfig get communityConfig => store.state.communityState.config;
}

class CommunityActionGetList extends _BaseAction {
  CommunityActionGetList({
    this.isRefresh,
    this.skip,
    this.searchName,
    this.type,
    this.isTeamList,
  });
  final bool isRefresh;
  final int skip;
  final String searchName;
  final String type;
  final bool isTeamList;

  @override
  Future<AppState> reduce() async {
    final config = store.state.communityState.config;
    final hasWallet = state.walletState.hasWallet;

    final walletId = state.walletState.activeWalletId;
    CommunityTeam myItem;
    CommunityMember myMember;
    if (skip == 0 && searchName == '' && hasWallet) {
      if (isTeamList) {
        myItem = await CommunityRepository().getOwnCommunity(
          walletId: walletId,
          type: type,
        );
      } else {
        myMember = await CommunityRepository().getOwnMember(
          walletId: walletId,
          type: type,
        );
      }
    }

    if (isTeamList == true) {
      final list = await CommunityRepository().getCommunityTeamList(
        skip: skip,
        take: 10,
        searchName: searchName,
        fork: config.fork,
        type: type,
      );

      return state.rebuild(
        (s) => isRefresh || skip == 0
            ? s.communityState.communityTeamList
                .replace(myItem != null ? [myItem, ...list] : [...list])
            : s.communityState.communityTeamList.addAll(list),
      );
    } else {
      final list = await CommunityRepository().getCommunityMemberList(
        skip: skip,
        take: 10,
        searchName: searchName,
        id: type,
      );

      return state.rebuild(
        (s) => isRefresh || skip == 0
            ? s.communityState.communityMemberList
                .replace(myMember != null ? [myMember, ...list] : [...list])
            : s.communityState.communityMemberList.addAll(list),
      );
    }
  }
}

class CommunityActionClearList extends _BaseAction {
  CommunityActionClearList({this.isTeamList});

  final bool isTeamList;

  @override
  Future<AppState> reduce() async {
    if (isTeamList == true) {
      return state.rebuild(
        (a) => a.communityState.communityTeamList = ListBuilder([]),
      );
    } else {
      return state.rebuild(
        (a) => a.communityState.communityMemberList = ListBuilder([]),
      );
    }
  }
}

class CommunityActionCreate extends _BaseAction {
  CommunityActionCreate(this.params);
  final TeamCreateParams params;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;
    final typeInfo = params.type;
    await CommunityRepository().submitCommunity(
      walletId: walletId,
      type: typeInfo.type,
      name: params.name,
      desc: params.desc,
      fork: params.fork,
      telegram: params.telegram,
      logo: params.logo,
      extraInfo: jsonEncode(params.images),
    );
    return null;
  }
}

class CommunityActionJoin extends _BaseAction {
  CommunityActionJoin(this.params);
  final TeamJoinParams params;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;
    await CommunityRepository().joinCommunity(
      walletId: walletId,
      type: params.type,
      teamId: params.teamId,
      name: params.name,
      desc: params.desc,
      logo: params.logo,
      telegram: params.telegram,
      github: params.github,
    );
    return null;
  }
}

class CommunityActionGetBlacklist extends _BaseAction {
  CommunityActionGetBlacklist({
    this.isRefresh,
    this.skip,
    this.searchName,
    this.type,
  });
  final bool isRefresh;
  final int skip;
  final String searchName;
  final String type;

  @override
  Future<AppState> reduce() async {
    final config = store.state.communityState.config;
    final list = await CommunityRepository().getCommunityBlacklist(
      skip: skip,
      take: 20,
      searchName: searchName,
      type: type,
      fork: config.fork,
    );

    return state.rebuild(
      (s) => isRefresh
          ? s.communityState.communityBlacklist.replace(list)
          : s.communityState.communityBlacklist.addAll(list),
    );
  }
}

class CommunityActionClearBlacklist extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    return state.rebuild(
      (a) => a.communityState.communityBlacklist = ListBuilder([]),
    );
  }
}

class CommunityActionGetTeamInfo extends _BaseAction {
  CommunityActionGetTeamInfo({
    this.teamId,
    this.completer,
  });

  final String teamId;
  final Completer<CommunityTeam> completer;

  @override
  Future<AppState> reduce() async {
    final data = await CommunityRepository().getTeamInfo(
      teamId: teamId,
    );
    completer.complete(data);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class CommunityActionGetMyTeam extends _BaseAction {
  CommunityActionGetMyTeam({
    @required this.type,
    @required this.completer,
  });

  final int type;
  final Completer<CommunityTeam> completer;

  @override
  Future<AppState> reduce() async {
    final data = await CommunityRepository().getOwnCommunity(
      type: type.toString(),
      walletId: walletId,
    );
    completer.complete(data);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class CommunityActionGetMyJoin extends _BaseAction {
  CommunityActionGetMyJoin({
    @required this.id,
    @required this.completer,
  });

  final String id;
  final Completer<CommunityMember> completer;

  @override
  Future<AppState> reduce() async {
    final data = await CommunityRepository().getOwnMember(
      type: id,
      walletId: walletId,
    );
    completer.complete(data);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}
