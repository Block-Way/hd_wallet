part of explorer_domain_module;

class ExplorerConfig {
  ExplorerConfig({
    @required this.chain,
    @required this.name,
    @required this.mainUrl,
    @required this.txUrl,
    this.addressUrl = '',
  });

  final String chain;
  final String name;
  final String mainUrl;
  final String txUrl;
  final String addressUrl;
}

class ExplorerItem {
  ExplorerItem({
    @required this.coinInfo,
    @required this.config,
  });

  final AssetCoin coinInfo;
  final ExplorerConfig config;
}
