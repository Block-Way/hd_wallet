part of invest_domain_module;

class InvestActionLoadConfig extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final config = await InvestRepository().getConfig();
    return state.rebuild(
      (a) => a.investState.config.replace(config),
    );
  }

  @override
  void after() {
    dispatch(InvestActionLoadConfigAfter());
  }
}

class InvestActionLoadConfigAfter extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final mints = store.state.investState.mints;
    final isError = mints == null || mints.isEmpty;
    return state.rebuild(
      (a) => a.investState.configState =
          isError ? ConfigState.error.index : ConfigState.success.index,
    );
  }
}
