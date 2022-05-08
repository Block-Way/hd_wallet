part of invitation_domain_module;

class InvitationApi {
  Future<List<Map<String, dynamic>>> getInvitationList({
    @required String walletId,
    @required String address,
    @required String contract,
    @required int skip,
    @required int take,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/hd/defi/invite_lists/$contract/$address/$skip/$take',
          params: params,
          authorization: auth,
        ),
      );

  ///检查 是否能邀请别人
  Future checkRelationParent({
    @required String walletId,
    @required String fork,
    @required String device,
    @required String toAddress,
  }) =>
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
      );

  ///检查 自己是否能够被邀请
  Future checkRelationChild({
    @required String walletId,
    @required String fork,
    @required String device,
    @required String fromAddress,
  }) =>
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
      );
}
