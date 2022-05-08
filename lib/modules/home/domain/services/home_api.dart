part of home_domain_module;

class HomeApi {
  Future<List<dynamic>> getBanners() => Request().getListOfObjects(
        '/v1/banner/banners/home',
      );

  Future<List<Map<String, dynamic>>> getQuotations({
    @required String marketId,
    int timestamp,
  }) =>
      Request().getListOfObjects(
        timestamp == null
            ? '/v1/quotation/current/base/$marketId'
            : '/v1/quotation/current/base/$marketId?timestamp=$timestamp',
      );
}
