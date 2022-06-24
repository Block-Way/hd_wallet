part of home_domain_module;

class HomeApi {
  Future<List<dynamic>> getBanners() async {
    final dio = Dio();

    final response = await dio.get('${AppConstants.randomApiUrl}/banners');
    debugPrint(response.toString());
    final data = response.data;
    return data as List<dynamic>;
    /*
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );*/
  }
//  => Request().getListOfObjects(
//        '/v1/banner/banners/home',
//      );

  Future<List<dynamic>> getQuotations({
    required String marketId,
    int? timestamp,
  }) async {
    final dio = Dio();
    final response = await dio.get('${AppConstants.randomApiUrl}/quotations');
    final data = response.data;
    print('这是data数据 $data');
    return data as List<dynamic>;
    /*
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );*/
  }
}
