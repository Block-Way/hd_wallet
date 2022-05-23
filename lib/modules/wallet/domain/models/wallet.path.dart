part of wallet_domain_module;

class WalletPathConfig {
  WalletPathConfig({
    @required this.name,
    @required this.logo,
    this.transKey,
    this.path = WalletType.mnemonicBip44,
  });

  final String name;
  final String logo;
  final String transKey;
  final WalletType path;
}
