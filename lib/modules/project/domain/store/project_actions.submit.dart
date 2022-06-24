part of project_domain_module;

class ProjectActionCreateSubmit extends _BaseAction {
  ProjectActionCreateSubmit({
    required this.params,
    required this.onUnlockWallet,
    required this.onConfirmData,
    required this.onSuccessTransaction,
    this.onConfirmSubmit,
  });

  final ProjectCreateParams params;
  final Future<WalletPrivateData> Function() onUnlockWallet;
  final Future<bool> Function(ProjectCreateParams) onConfirmData;
  final void Function(String txId) onSuccessTransaction;
  final Future<bool> Function()? onConfirmSubmit;

  @override
  Future<AppState?> reduce() async {
    return null;
    /*
    // final projectConfig = store.state.commonState.config.project;

    final payCoin = store.state.assetState.getCoinInfo(
      chain: 'BBC',
      symbol: 'BBC',
    );

    await store.dispatchFuture(
      WalletActionWalletRegister(store.state.walletState.activeWallet),
      notify: false,
    );

    // Fetch transaction data (fee, unspent, etc)
    final withdrawDataRequest = Completer<WalletWithdrawData>();
    dispatch(WalletActionWithdrawBefore(
      params: WithdrawBeforeParams(
        chain: payCoin.chain,
        symbol: payCoin.symbol,
        fromAddress: payCoin.address,
        chainPrecision: payCoin.chainPrecision,
        contractOrForkId: payCoin.contract,
        toAddress: 'projectConfig.toAddress',
      ),
      completer: withdrawDataRequest,
    ));
    final _ = await withdrawDataRequest.future;

    // params.setWithdrawData(
    //   withdrawCoin: payCoin,
    //   withdrawData: withdrawData,
    //   withdrawAmount: projectConfig.createAmount,
    // );

    final confirmData = await onConfirmData(params);
    if (confirmData != true) {
      return null;
    }

    final walletData = await onUnlockWallet();
    if (walletData == null) {
      return null;
    }

    final submitTransaction = Completer<String>();
    dispatch(WalletActionWithdrawSubmit(
      params: WithdrawSubmitParams(
        withdrawData: params.withdrawData,
        amount: params.withdrawAmount,
        chainPrecision: payCoin.chainPrecision,
        toAddress: params.withdrawData.toAddress,
      ),
      walletData: walletData,
      completer: submitTransaction,
      onConfirmSubmit: onConfirmSubmit,
    ));

    final txId = await submitTransaction.future;

    // params.setWithdrawSuccess(
    //   txId: txId,
    //   submittedAt: DateTime.now().millisecondsSinceEpoch,
    // );

    // Reset project info cache
    await dispatchFuture(ProjectActionCreateSaveToCache(null));

    await dispatchFuture(ProjectActionCreateSuccess(params));

    onSuccessTransaction(txId);

    return null;
    */
  }

  @override
  Object? wrapError(dynamic error) {
    return error;
  }
}

class ProjectActionCreateSuccess extends _BaseAction {
  ProjectActionCreateSuccess(this.params);
  final ProjectCreateParams params;

  @override
  Future<AppState?> reduce() async {
    /*
    final walletId = state.walletState.activeWalletId;

    // Save to cache
    // await dispatchFuture(HDWalletActionAddBroadcastTx(
    //   txId: params.txId,
    //   chain: 'BBC',
    //   symbol: 'BBC',
    //   type: BroadcastTxType.project,
    //   apiParams: params.toJson(),
    // ));

    // Call api
    await ProjectRepository().submitProject(
      walletId: walletId,
      params: params.toApiParams(),
    );

    // If api return success, update cache
    // await dispatchFuture(HDWalletActionDoneBroadcastTx(
    //   txId: params.txId,
    //   type: BroadcastTxType.project,
    // ));
    */
    return null;
  }
}

class ProjectActionReSubmitProjects extends _BaseAction {
  @override
  Future<AppState?> reduce() async {
    /*
    final broadcastRequest = Completer<List<BroadcastTxInfo>>();
    dispatch(WalletActionGetBroadcastsFailed(
      type: BroadcastTxType.project,
      completer: broadcastRequest,
    ));
    final prevBroadcasts = await broadcastRequest.future;

    for (final broadcastInfo in prevBroadcasts) {
      dispatch(
        ProjectActionCreateSuccess(
          ProjectCreateParams.fromJson(broadcastInfo.apiParams),
        ),
      );
    }*/
    return null;
  }
}

class ProjectActionCreateSaveToCache extends _BaseAction {
  ProjectActionCreateSaveToCache(this.params);

  final ProjectCreateParams params;

  @override
  AppState reduce() {
    return state.rebuild(
      (state) =>
          state..projectState.lastProjectCreateParams = params.toBuilder(),
    );
  }
}
