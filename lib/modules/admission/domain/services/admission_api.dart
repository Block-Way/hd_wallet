part of admission_domain_module;

class AdmissionApi {
  Future<Map<String, dynamic>> getConfig() => Request().getObject(
        '/v1/hd/team/config/fork',
      );

  Future<List<Map<String, dynamic>>> getLatest() =>
      Request().getListOfObjects('/v1/hd/team/config/fork');
}
