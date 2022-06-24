part of asset_domain_module;

final kDefaultCoinFixed = ['BBC', 'SUG'];

List<AssetCoin> sortCoins(List<AssetCoin> coins) {
  coins.sort((a, b) {
    if (kDefaultCoinFixed.indexOf(a.symbol ?? '') >
        kDefaultCoinFixed.indexOf(b.symbol ?? '')) {
      return -1;
    }
    if (kDefaultCoinFixed.indexOf(a.symbol ?? '') <
        kDefaultCoinFixed.indexOf(b.symbol ?? '')) {
      return 1;
    }
    if ((a.balance ?? 0) > 0 || (b.balance ?? 0) > 0) {
      return b.balance?.compareTo(a.balance ?? 0) ?? 0;
    }
    return a.symbol?.compareTo(b.symbol ?? '') ?? 0;
  });
  return coins;
}
