part of admission_domain_module;

class AdmissionActionLoadConfig extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final config = await AdmissionRepository().getConfig();
    return state.rebuild(
      (a) => a.admissionState.config.replace(config),
    );
  }

  @override
  void after() {
    super.after();
    dispatch(AdmissionActionLoadConfigAfter());
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}

class AdmissionActionLoadConfigAfter extends _BaseAction {
  @override
  AppState reduce() {
    final isError = admissionConfig == null;

    return store.state.rebuild(
      (a) => a.admissionState.configState =
          isError ? ConfigState.error.index : ConfigState.success.index,
    );
  }
}
