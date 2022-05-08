part of asset_domain_module;

final kDefaultCoinFixed = ['BBC', 'SUG'];

List<AssetCoin> sortCoins(List<AssetCoin> coins) {
  coins.sort((a, b) {
    if (kDefaultCoinFixed.indexOf(a.symbol) >
        kDefaultCoinFixed.indexOf(b.symbol)) {
      return -1;
    }
    if (kDefaultCoinFixed.indexOf(a.symbol) <
        kDefaultCoinFixed.indexOf(b.symbol)) {
      return 1;
    }
    if (a.balance > 0 || b.balance > 0) {
      return b.balance.compareTo(a.balance);
    }
    return a.symbol.compareTo(b.symbol);
  });
  return coins;
}
