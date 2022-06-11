part of invitation_domain_module;

class InvitationApi {
  Future<List<Map<String, dynamic>>> getInvitationList({
    required String walletId,
    required String address,
    required String contract,
    required int skip,
    required int take,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/invite_lists/$address');
    final data = response.data;
    return data as List<Map<String, dynamic>>;
    /*
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );*/
    /*
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/hd/defi/invite_lists/$contract/$address/$skip/$take',
          params: params,
          authorization: auth,
        ),
      );*/
  }

  Future checkRelationParent({
    required String walletId,
    required String fork,
    required String device,
    required String toAddress,
  }) async {
    return true;
    /*
    addAuthSignature(
      walletId,
      {
        'device': device,
        'fork': fork,
        'to': toAddress,
        'hash': walletId,
      },
      (params, auth) => Request().post(
        '/v1/hd/defi/relation/parent/bind',
        params,
        authorization: auth,
      ),
    );*/
  }

  Future checkRelationChild({
    required String walletId,
    required String fork,
    required String device,
    required String fromAddress,
  }) async {
    return true;
    /*
    addAuthSignature(
      walletId,
      {
        'device': device,
        'fork': fork,
        'from': fromAddress,
        'hash': walletId,
      },
      (params, auth) => Request().post(
        '/v1/hd/defi/relation/child/check',
        params,
        authorization: auth,
      ),
    );*/
  }
}
