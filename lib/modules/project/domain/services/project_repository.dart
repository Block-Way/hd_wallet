part of project_domain_module;

class ProjectRepository {
  factory ProjectRepository([ProjectApi? _api]) {
    _instance._api = _api ?? ProjectApi();
    return _instance;
  }
  ProjectRepository._internal();

  static final _instance = ProjectRepository._internal();

  late ProjectApi _api;

  Future<ProjectInfo?> getProjectInfo({
    required int id,
  }) async {
    return null;
    //final json = await _api.getProjectInfo(id: id);
    //return ProjectInfo.fromJson(json);
  }

  Future<List<ProjectInfo>> getProjectList({
    required int skip,
    required int take,
  }) async {
    /*
    final json = await _api.getProjectList(
      skip: skip,
      take: take,
    );
    return deserializeListOf<ProjectInfo>(json).toList();
    */
    return [];
  }

  Future<Map<String, dynamic>> submitProject({
    required String walletId,
    required Map<String, dynamic> params,
  }) async {
    /*
    return _api.submitProject(
      walletId: walletId,
      params: params,
    );*/
    return {};
  }

  Future<ProjectConfig?> getProjectConfig() async {
    //final data = await _api.getProjectConfig();
    //return ProjectConfig.fromJson(data);
    return null;
  }
}
