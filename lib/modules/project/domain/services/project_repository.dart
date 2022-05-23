part of project_domain_module;

class ProjectRepository {
  factory ProjectRepository([ProjectApi _api]) {
    _instance._api = _api ?? ProjectApi();
    return _instance;
  }
  ProjectRepository._internal();

  static final _instance = ProjectRepository._internal();

  ProjectApi _api;

  Future<ProjectInfo> getProjectInfo({
    @required int id,
  }) async {
    final json = await _api.getProjectInfo(id: id);
    return ProjectInfo.fromJson(json);
  }

  Future<List<ProjectInfo>> getProjectList({
    @required int skip,
    @required int take,
  }) async {
    final json = await _api.getProjectList(
      skip: skip,
      take: take,
    );
    return deserializeListOf<ProjectInfo>(json).toList();
  }

  Future<Map<String, dynamic>> submitProject({
    @required String walletId,
    @required Map<String, dynamic> params,
  }) {
    return _api.submitProject(
      walletId: walletId,
      params: params,
    );
  }

  Future<ProjectConfig> getProjectConfig() async {
    final data = await _api.getProjectConfig();
    return ProjectConfig.fromJson(data);
  }
}
