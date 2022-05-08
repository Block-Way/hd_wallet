part of asset_domain_module;

class AssetActionRedDotListDone extends _BaseAction {
  AssetActionRedDotListDone();

  @override
  AppState reduce() {
    return state.rebuild((a) => a..assetState.hideInvitationNotice = true);
  }
}

class AssetActionShowcaseListDone extends _BaseAction {
  AssetActionShowcaseListDone();

  @override
  AppState reduce() {
    return state.rebuild((a) => a..assetState.hideInvitationShowcase = true);
  }
}

class AssetActionShowcaseDepositDone extends _BaseAction {
  AssetActionShowcaseDepositDone();

  @override
  AppState reduce() {
    return state.rebuild((a) => a..assetState.hideDepositShowcase = true);
  }
}

class AssetActionShowcaseWithdrawDone extends _BaseAction {
  AssetActionShowcaseWithdrawDone();

  @override
  AppState reduce() {
    return state.rebuild((a) => a..assetState.hideWithdrawShowcase = true);
  }
}
