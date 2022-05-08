part of common_domain_module;

class CommonApi {
  Future<Map<String, Object>> getConfig() =>
      Request().getValue<Map<String, Object>>(
        '/v1/config',
      );

  Future<Map<String, Object>> getConfigVersion() =>
      Request().getValue<Map<String, Object>>(
        '/v1/config/version',
      );

  Future<Map<String, dynamic>> getConfigImage() =>
      Request().getValue<Map<String, dynamic>>(
        '/v1/upload/signed',
      );

  Future<int> getSystemDate() => Request().getValue<int>(
        '/v1/time',
      );

  Future<String> getApiDns() => Request().getValue<String>(
        '/v1/dns',
      );

  Future<Map<String, dynamic>> getLastBetaVersion({
    @required String appSecret,
    @required String appDistribution,
  }) =>
      Request().getExternalObject(
        '/public/sdk/apps/$appSecret/distribution_groups/$appDistribution/releases/latest',
        baseUrl: 'https://api.appcenter.ms/v0.1',
        headers: {'X-API-Token': '53c523810b8bfa7e1e83aa843e668d26e142d756'},
      );

  Future<List<Map<String, dynamic>>> getLastBetaReleases({
    @required String appName,
    @required String platform,
  }) =>
      Request().getExternalListOfObjects(
        '/apps/LoMoCoinTeam/$appName-$platform/releases?published_only=true',
        baseUrl: 'https://api.appcenter.ms/v0.1',
        headers: {'X-API-Token': '53c523810b8bfa7e1e83aa843e668d26e142d756'},
      );

  Future<List<dynamic>> getAds(String type) =>
      Request().getValue<List<dynamic>>(
        '/v1/config/advertising/$type',
      );
}
