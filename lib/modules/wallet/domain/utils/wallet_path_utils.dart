part of wallet_domain_module;

class WalletPathUtils {
  static final pathConfigs = [
    WalletPathConfig(
      name: 'Sugar',
      logo: 'assets/images/wallet_sugar.png',
    ),
    WalletPathConfig(
      name: 'Huobi',
      logo: 'assets/images/wallet_huobi.png',
    ),
    WalletPathConfig(
      name: 'Binance',
      logo: 'assets/images/wallet_binance.png',
    ),
    WalletPathConfig(
      name: 'Bittrex',
      logo: 'assets/images/wallet_bitfinex.png',
    ),
    WalletPathConfig(
      name: 'Kraken',
      logo: 'assets/images/wallet_kraken.png',
    ),
    WalletPathConfig(
      name: 'OKEx',
      logo: 'assets/images/wallet_okex.png',
    ),
    WalletPathConfig(
      name: 'Bitfinex',
      logo: 'assets/images/wallet_bittrex.png',
    ),
    WalletPathConfig(
      name: 'Coinbase',
      logo: 'assets/images/wallet_coinbase.png',
    ),
    WalletPathConfig(
      name: 'imToken',
      logo: 'assets/images/wallet_imtoken.png',
    ),
    WalletPathConfig(
      name: 'Ledger',
      logo: 'assets/images/wallet_ledger.png',
    ),
    WalletPathConfig(
      name: 'PockMine',
      logo: 'assets/images/wallet_pockmine.png',
      path: WalletType.mnemonicBip39,
    ),
    WalletPathConfig(
      name: 'Others',
      logo: 'assets/images/wallet_others.png',
      transKey: 'wallet:select_path_lbl_others',
    ),
  ];
}
