part of common_domain_module;

class CommonActionLoadConfig extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final config = await CommonRepository().getConfig();

    try {
      final date = await CommonRepository().getSystemDate();
      SystemDate.initTime(date);
    } catch (_) {}

    // Update getit configs
    GetIt.I<CoinConfig>().updateFromConfig(config);
    GetIt.I<ModulePermissionUtils>().updateFromConfig(
      config,
      state.commonState.appInfo.version,
    );

    return state.rebuild(
      (b) => b
        ..commonState.config.replace(config)
        ..commonState.newVersion.replace(config.version),
    );
  }

  @override
  void after() {
    super.after();
    dispatch(CommonActionLoadConfigAfter());
    dispatch(AppActionAfterCommonConfig(state.commonState.config));
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}

class CommonActionLoadConfigAfter extends _BaseAction {
  @override
  AppState reduce() {
    final config = store.state.commonState.config;
    final isError = config == null || config.version == null;
    return state.rebuild(
      (a) => a.commonState.configState =
          isError ? ConfigState.error.index : ConfigState.success.index,
    );
  }
}
