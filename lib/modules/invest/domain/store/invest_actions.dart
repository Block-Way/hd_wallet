part of invest_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class InvestActionClear extends _BaseAction {
  @override
  AppState reduce() {
    return state.rebuild(
      (s) => s
        ..investState.mintInfo = null
        ..investState.chartList = ListBuilder([])
        ..investState.profitInvitationList = ListBuilder([])
        ..investState.profitRecordList = ListBuilder([]),
    );
  }
}

class InvestActionLoadMintBefore extends _BaseAction {
  InvestActionLoadMintBefore(this.mint);

  final MintItem mint;

  @override
  Future<AppState> reduce() async {
    final activeMint = store.state.investState.activeMint;
    if (mint != null && activeMint != null && activeMint.id != mint.id) {
      // 切换矿池的话 需要清除state中的数据
      await store.dispatchFuture(InvestActionClear());
    }
    return state.rebuild(
      (a) => a.investState.activeMint = mint.toBuilder(),
    );
  }
}

class InvestActionLoadMint extends _BaseAction {
  InvestActionLoadMint(this.mint);
  final MintItem mint;

  @override
  void before() {
    dispatch(InvestActionLoadMintBefore(mint));
  }

  @override
  Future<AppState> reduce() async {
    if (state.walletState.hasWallet) {
      await store.dispatchFuture(InvestActionLoadMintInfo());
      await store.dispatchFuture(InvestActionLoadChart());
    }

    return null;
  }

  @override
  void after() {
    //
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}
