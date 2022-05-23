part of invitation_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class InvitationActionGetList extends _BaseAction {
  InvitationActionGetList({
    @required this.isRefresh,
    @required this.skip,
    @required this.coin,
  });

  final bool isRefresh;
  final int skip;
  final AssetCoin coin;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;

    final data = await InvitationRepository().getInvitationList(
      walletId: walletId,
      address: coin.address,
      contract: coin.contract,
      skip: skip,
      take: 10,
    );

    final list = <Invitation>[];
    for (final item in data) {
      list.add(Invitation(
        item['current']?.toString(),
        NumberUtil.getInt(item['created_at']),
      ));
    }

    return state.rebuild((a) => skip == 0
        ? a.invitationState.invitations.replace(list)
        : a.invitationState.invitations.addAll(list));
  }
}

class InvitationActionClear extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    return state.rebuild(
      (s) => s.invitationState.invitations = ListBuilder([]),
    );
  }
}

class InvitationActionCheckRelationParent extends _BaseAction {
  InvitationActionCheckRelationParent({
    @required this.fork,
    @required this.toAddress,
    @required this.completer,
  });

  final String fork;
  final String toAddress;
  final Completer<bool> completer;

  @override
  Future<AppState> reduce() async {
    final deviceId = await PlatformUtils.getDeviceId();
    final walletId = state.walletState.activeWalletId;

    await InvitationRepository().checkRelationParent(
      fork: fork,
      walletId: walletId,
      deviceId: deviceId,
      toAddress: toAddress,
    );

    completer.complete(true);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class InvitationActionCheckRelationChild extends _BaseAction {
  InvitationActionCheckRelationChild({
    @required this.fork,
    @required this.fromAddress,
    @required this.completer,
  });

  final String fork;
  final String fromAddress;
  final Completer<bool> completer;

  @override
  Future<AppState> reduce() async {
    final deviceId = await PlatformUtils.getDeviceId();
    final walletId = state.walletState.activeWalletId;

    await InvitationRepository().checkRelationChild(
      fork: fork,
      fromAddress: fromAddress,
      walletId: walletId,
      deviceId: deviceId,
    );

    completer.complete(true);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class InvitationActionLoadCode extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;

    final result = await InvitationRepository().getInvitationCodeFromCache(
      walletId,
    );
    return state.rebuild(
      (s) => s.invitationState.invitationCodes.replace(result),
    );
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}

class InvitationActionCreateCode extends _BaseAction {
  InvitationActionCreateCode({
    @required this.mnemonic,
    @required this.coinInfo,
    @required this.completer,
  });

  final String mnemonic;
  final AssetCoin coinInfo;
  final Completer<InvitationCode> completer;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;

    // My Coin Chain private key
    final privateKey = await WalletRepository().exportPrivateKey(
      mnemonic: mnemonic,
      chain: coinInfo.chain,
      forkId: coinInfo.contract,
    );

    //获取需要签名的信息
    final sharedKeyPair = await WalletRepository().createBBCPairKey();

    final invitationData =
        await InvitationRepository().createInvitationCodeData(
      signPrivateKey: privateKey,
      codePublicKey: sharedKeyPair.publicKey,
      codePrivateKey: sharedKeyPair.privateKey,
      codeForkId: coinInfo.contract,
    );

    //获取全部缓存
    final allCode = await InvitationRepository().getInvitationCodeFromCache(
      walletId,
    );

    // 应该不会有重复的，但是以防万一
    final existingCode = allCode.firstWhere(
      (e) => e.chain == coinInfo.chain && e.symbol == coinInfo.symbol,
      orElse: () => null,
    );

    var newCode = existingCode;

    if (existingCode == null) {
      newCode = InvitationCode.create(
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
        fork: coinInfo.contract,
        address: coinInfo.address,
        subSign: invitationData.subSign,
        sharePrvKey: invitationData.sharePrvKey,
      );
      allCode.add(newCode);
    }

    await InvitationRepository().saveInvitationCodeToCache(
      walletId,
      allCode,
    );

    completer.complete(newCode);

    return state.rebuild(
      (s) => s.invitationState.invitationCodes.replace(allCode),
    );
  }

  @override
  Object wrapError(dynamic error) {
    final newError = parseWalletError(error);
    completer.completeError(newError);
    return newError;
  }
}
