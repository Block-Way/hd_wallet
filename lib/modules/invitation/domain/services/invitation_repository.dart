part of invitation_domain_module;

class InvitationRepository {
  factory InvitationRepository([InvitationApi _api]) {
    _instance._api = _api ?? InvitationApi();
    return _instance;
  }
  InvitationRepository._internal();

  static final _instance = InvitationRepository._internal();

  InvitationApi _api;
  LazyBox<List<dynamic>> _invitationCodes;

  static const _invitationCodeCacheKey = 'invitation_code_v1';

  Future<void> initializeCache() async {
    _invitationCodes = await AppHiveCache.openLazyBox<List<dynamic>>(
      _invitationCodeCacheKey,
    );
  }

  Future<List<Map<String, dynamic>>> getInvitationList({
    @required String walletId,
    @required String address,
    @required String contract,
    @required int skip,
    @required int take,
  }) {
    return _api.getInvitationList(
      walletId: walletId,
      address: address,
      contract: contract,
      skip: skip,
      take: take,
    );
  }

  Future checkRelationParent({
    @required String walletId,
    @required String fork,
    @required String deviceId,
    @required String toAddress,
  }) {
    return _api.checkRelationParent(
      walletId: walletId,
      fork: fork,
      device: deviceId,
      toAddress: toAddress,
    );
  }

  Future checkRelationChild({
    @required String walletId,
    @required String fork,
    @required String deviceId,
    @required String fromAddress,
  }) {
    return _api.checkRelationChild(
      walletId: walletId,
      fork: fork,
      device: deviceId,
      fromAddress: fromAddress,
    );
  }

// invitation code cache

  Future<List<InvitationCode>> getInvitationCodeFromCache(
    String walletId,
  ) async {
    try {
      final list = await _invitationCodes.get(
        walletId,
        defaultValue: [],
      );
      return List.from(list);
    } catch (_) {
      return List.from([]);
    }
  }

  Future<void> saveInvitationCodeToCache(
    String walletId,
    List<InvitationCode> code,
  ) async {
    await _invitationCodes.put(
      walletId,
      code,
    );
  }

  Future<void> clearInvitationCodeCache(
    String walletId,
  ) async {
    await _invitationCodes.put(
      walletId,
      [],
    );
  }

  Future<InvitationCodeData> createInvitationCodeData({
    /// Private key for sign
    @required String signPrivateKey,
    @required String codePublicKey,
    @required String codePrivateKey,

    /// Code Invitation coin forkId (can be empty string)
    @required String codeForkId,
  }) async {
    final invitationCode = 'DeFiRelation$codeForkId$codePublicKey';

    final subSign = await WalletRepository().signMsgWithPKAndBlake(
      privateKey: signPrivateKey,
      msg: invitationCode,
    );

    return InvitationCodeData(
      sharePrvKey: codePrivateKey,
      subSign: subSign,
    );
  }
}
