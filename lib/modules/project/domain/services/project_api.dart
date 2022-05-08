part of project_domain_module;

class ProjectApi {
  Future<Map<String, dynamic>> getProjectInfo({
    @required int id,
  }) {
    return Request().getObject(
      '/v1/creation/info/$id',
    );
  }

  Future<List<Map<String, dynamic>>> getProjectList({
    @required int skip,
    @required int take,
  }) {
    return Request().getListOfObjects(
      '/v1/creation/lists/$skip/$take',
    );
  }

  Future<Map<String, dynamic>> submitProject({
    @required String walletId,
    @required Map<String, dynamic> params,
  }) =>
      addAuthSignature(
        walletId,
        params,
        (params, auth) => Request().post(
          '/v1/creation/new',
          params,
          authorization: auth,
        ),
      );

  Future<Map<String, dynamic>> getProjectConfig() {
    return Request().getObject(
      '/v1/config/creation',
    );
  }
}
