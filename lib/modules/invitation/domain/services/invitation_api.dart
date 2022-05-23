part of invitation_domain_module;

class InvitationApi {
  Future<List<Map<String, dynamic>>> getInvitationList({
    @required String walletId,
    @required String address,
    @required String contract,
    @required int skip,
    @required int take,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/invite_lists/$address');
    final data = response.data;
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );
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

  ///检查 是否能邀请别人
  Future checkRelationParent({
    @required String walletId,
    @required String fork,
    @required String device,
    @required String toAddress,
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

  ///检查 自己是否能够被邀请
  Future checkRelationChild({
    @required String walletId,
    @required String fork,
    @required String device,
    @required String fromAddress,
  }) async {
    return true;
    // 只要有矿工费都可以邀请别人
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
