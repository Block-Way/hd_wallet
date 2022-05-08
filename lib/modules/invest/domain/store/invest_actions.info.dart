part of invest_domain_module;

/// 获取 矿池 info
class InvestActionLoadMintInfo extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final activeMint = store.state.investState.activeMint;
    //final walletId = store.state.walletState.activeWalletId;
    final coin = store.state.walletState.activeWallet.addresses
        .where((element) => element.chain == 'BBC')
        .first;
    final result = await InvestRepository().getMintInfo(
      fork: activeMint.forkId,
      addr: coin.address,
    );

    if (result.isEmpty) {
      return state.rebuild((a) => a.investState.mintInfo = MintInfo((a) => a
        ..minBalance = '-1'
        ..bestBalance = '0'
        ..bestBalanceReward = '0'
        ..minBalanceReward = '0').toBuilder());
    } else {
      final data = deserialize<MintInfo>(result);
      return state.rebuild((a) => a.investState.mintInfo = data.toBuilder());
    }
  }
}

/// 获取 矿池 图表数据
class InvestActionLoadChart extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final activeMint = store.state.investState.activeMint;
    //final walletId = store.state.walletState.activeWalletId;
    final coin = store.state.walletState.activeWallet.addresses
        .where((element) => element.chain == 'BBC')
        .first;

    final result = await InvestRepository().getChartList(
      fork: activeMint.forkId,
      addr: coin.address,
    );
    final data = deserializeListOf<MintChart>(result);
    return state.rebuild((a) => a.investState.chartList = ListBuilder(data));
  }
}

///获取收益记录
class InvestActionGetProfitRecordList extends _BaseAction {
  InvestActionGetProfitRecordList({
    @required this.isRefresh,
    @required this.take,
    @required this.skip,
  });

  final bool isRefresh;
  final int take;
  final int skip;

  @override
  Future<AppState> reduce() async {
    final activeMint = store.state.investState.activeMint;
    final walletId = store.state.walletState.activeWalletId;
    final result = await InvestRepository().getProfitRecordList(
      fork: activeMint.forkId,
      walletId: walletId,
      take: take,
      skip: skip,
    );
    final data = deserializeListOf<ProfitRecordItem>(result);
    return state.rebuild(
      (a) => a.investState.profitRecordList.replace(data),
    );
  }
}

/// 邀请人列表
class InvestActionGetInvitationList extends _BaseAction {
  InvestActionGetInvitationList({
    this.isRefresh,
    this.take,
    this.skip,
  });

  final bool isRefresh;
  final int take;
  final int skip;

  @override
  Future<AppState> reduce() async {
    final activeMint = store.state.investState.activeMint;
    //final walletId = store.state.walletState.activeWalletId;
    final coin = store.state.walletState.activeWallet.addresses
        .where((element) => element.chain == 'BBC')
        .first;

    final result = await InvestRepository().getProfitInvitationList(
      fork: activeMint.forkId,
      addr: coin.address,
      take: take,
      skip: skip,
    );

    final data = deserializeListOf<ProfitInvitationItem>(result);

    return state.rebuild(
      (a) => a.investState.profitInvitationList.replace(data),
    );
  }
}
