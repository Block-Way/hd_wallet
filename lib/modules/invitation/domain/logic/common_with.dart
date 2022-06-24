part of invitation_domain_module;

// 这里的数据结构是怎么填充的呢？
class VMWithInvitation {
  static List<AssetCoin> getInvitationCoins(Store<AppState> store) {
    final coins = store.state.commonState.config?.coins;
    final list = <AssetCoin>[];
    if (coins != null && coins.isNotEmpty) {
      coins.forEach((_, coin) {
        if (coin.canInvitation) {
          list.add(store.state.assetState.getCoinInfo(
            chain: coin.chain,
            symbol: coin.symbol,
          ));
        }
      });
    }
    return list;
  }
}
