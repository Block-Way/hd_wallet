part of app_module;

class AppCoins {
  static final defaultCoins = [
    CoinInfo(
      chain: 'BTC',
      symbol: 'BTC',
      name: 'BTC',
      fullName: 'Bitcoin',
      iconLocal: 'assets/images/coin_btc.png',
      isEnabled: false,
      isFixed: false,
      chainPrecision: 18,
      displayPrecision: 8,
    ),
    CoinInfo(
      chain: 'BBC',
      symbol: 'BBC',
      name: 'BBC',
      fullName: 'BigBang Core',
      iconLocal: 'assets/images/coin_bbc.png',
      isEnabled: false,
      isFixed: false,
      chainPrecision: 6,
      displayPrecision: 6,
      contract: AppConstants.bbc_fork,
    ),
    CoinInfo(
      chain: 'ETH',
      symbol: 'ETH',
      name: 'ETH',
      fullName: 'Ethereum',
      iconLocal: 'assets/images/coin_eth.png',
      isEnabled: false,
      isFixed: false,
      chainPrecision: 18,
      displayPrecision: 8,
    ),
    CoinInfo(
      chain: 'TRX',
      symbol: 'TRX',
      name: 'TRX',
      fullName: 'TRON',
      iconLocal: 'assets/images/coin_trx.png',
      isEnabled: false,
      isFixed: false,
      chainPrecision: 6,
      displayPrecision: 6,
    ),
    CoinInfo(
      chain: 'ETH',
      symbol: 'USDT',
      name: 'USDT-ERC20',
      fullName: 'Tether USD (ERC20)',
      iconLocal: 'assets/images/coin_usdt_erc.png',
      isEnabled: false,
      isFixed: false,
      contract: '0xdac17f958d2ee523a2206206994597c13d831ec7',
      chainPrecision: 6,
      displayPrecision: 6,
    ),
    CoinInfo(
      chain: 'TRX',
      symbol: 'USDT',
      name: 'USDT-TRC20',
      fullName: 'Tether USD (TRC20)',
      iconLocal: 'assets/images/coin_usdt_trx.png',
      isEnabled: false,
      isFixed: false,
      chainPrecision: 6,
      displayPrecision: 6,
    ),
    // App Specific coins
    CoinInfo(
      chain: 'BBC',
      symbol: 'HAH',
      name: 'HAH',
      fullName: 'Hash Ahead',
      iconLocal: 'assets/images/logo_hah.png',
      isEnabled: true,
      isFixed: false,
      chainPrecision: 6,
      displayPrecision: 6,
      contract: AppConstants.btca_fork,
    ),
  ];
}