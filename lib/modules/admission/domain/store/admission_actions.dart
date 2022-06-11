part of admission_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  String get walletId => store.state.walletState.activeWalletId!;
  AdmissionConfig get admissionConfig => store.state.admissionState.config!;
}

class AdmissionActionGetLatest extends _BaseAction {
  @override
  Future<AppState?> reduce() async {
    /*
    final list = await AdmissionRepository().getLatest();
    return state.rebuild((s) => s.admissionState.admissionList.replace(list));
    */
    return null;
  }

  @override
  Object? wrapError(dynamic error) {
    return error;
  }
}
