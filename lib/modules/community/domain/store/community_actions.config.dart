part of community_domain_module;

class CommunityActionLoadConfig extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final config = await CommunityRepository().getConfig();
    return state.rebuild(
      (a) => a.communityState.config.replace(config),
    );
  }

  @override
  void after() {
    super.after();
    dispatch(CommunityActionLoadConfigAfter());
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}

class CommunityActionLoadConfigAfter extends _BaseAction {
  @override
  AppState reduce() {
    final isError = communityConfig == null ||
        communityConfig.ecological == null ||
        communityConfig.ecological.isEmpty;

    return store.state.rebuild(
      (a) => a.communityState.configState =
          isError ? ConfigState.error.index : ConfigState.success.index,
    );
  }
}
