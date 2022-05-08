part of admission_domain_module;

class AdmissionRepository {
  factory AdmissionRepository([AdmissionApi _api]) {
    _instance._api = _api ?? AdmissionApi();
    return _instance;
  }
  AdmissionRepository._internal();

  AdmissionApi _api;

  static final _instance = AdmissionRepository._internal();

  Future<AdmissionConfig> getConfig() async {
    final json = await _api.getConfig();
    return AdmissionConfig.fromJson(json);
  }

  Future<List<AdmissionInfo>> getLatest() async {
    final json = await _api.getLatest();
    return deserializeListOf<AdmissionInfo>(json).toList();
  }
}
