part of community_domain_module;

class CommunityApi {
  Future<Map<String, dynamic>> getConfig() => Request().getObject(
        '/v1/hd/team/config',
      );

  Future<List<Map<String, dynamic>>> getCommunityTeamList({
    @required int skip,
    @required int take,
    @required String type,
    String searchName,
    String fork,
  }) =>
      Request().getListOfObjects(
        '/v1/hd/team/list/$type/$skip/$take',
        params: {
          'keyword': searchName,
          'fork': fork,
        },
      );

  Future<List<Map<String, dynamic>>> getCommunityMemberList({
    @required int skip,
    @required int take,
    @required String id,
    String searchName,
  }) =>
      Request().getListOfObjects(
        '/v1/hd/team/$id/member/list/$skip/$take',
        params: {
          'keyword': searchName,
        },
      );

  Future<void> submitCommunity({
    @required String walletId,
    @required int type,
    @required String name,
    @required String desc,
    @required String fork,
    @required String telegram,
    @required String logo,
    @required String extraInfo,
  }) =>
      addAuthSignature(
        walletId,
        {
          'type': type,
          'fork': fork,
          'telegram_account': telegram,
          'describe': desc,
          'name': name,
          'icon': logo,
          'extra_info': extraInfo,
        },
        (params, auth) => Request().post(
          '/v1/hd/team/create',
          params,
          authorization: auth,
        ),
      );

  Future<void> joinCommunity({
    @required String walletId,
    @required int type,
    @required String teamId,
    @required String name,
    @required String desc,
    @required String logo,
    @required String telegram,
    @required String github,
    @required String extraInfo,
  }) =>
      addAuthSignature(
        walletId,
        {
          'hash': walletId,
          'type': type,
          'team': teamId,
          'name': name,
          'intro': desc,
          'logo': logo,
          'telegram': telegram,
          'github': github,
          'extra_info': extraInfo,
        },
        (params, auth) => Request().post(
          '/v1/hd/team/join',
          params,
          authorization: auth,
        ),
      );

  Future<Map<String, dynamic>> getOwnCommunity({
    String walletId,
    String type,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getObject(
          '/v1/hd/team/my/$type',
          params: params,
          authorization: auth,
        ),
      );

  Future<Map<String, dynamic>> getOwnMember({
    String walletId,
    String type,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getObject(
          '/v1/hd/team/$type/member/me',
          params: params,
          authorization: auth,
        ),
      );

  Future<List<Map<String, dynamic>>> getCommunityBlacklist({
    @required int skip,
    @required int take,
    @required String type,
    String searchName,
    String fork,
  }) =>
      Request().getListOfObjects(
        '/v1/hd/team/blacklist/$type/$skip/$take',
        params: {
          'keyword': searchName,
          'fork': fork,
        },
      );

  Future<Map<String, dynamic>> getTeamInfo({
    String teamId,
  }) =>
      Request().getObject(
        '/v1/hd/team/$teamId/info',
      );
}
