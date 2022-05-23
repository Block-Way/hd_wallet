part of explorer_domain_module;

class ExplorerUtils {
  static const onlySearchAddress = [
    'BBC',
    'TRX',
  ];

  static const explorerChains = [
    'BBC',
    'ETH',
    'BTC',
    'TRX',
  ];

  static final explorerConfigs = [
    ExplorerConfig(
      chain: 'BBC',
      name: 'BigBang Core',
      mainUrl: 'https://www.bbcexplorer.com',
      txUrl: 'https://www.bbcexplorer.com/transaction-detail/%s',
      addressUrl: 'https://www.bbcexplorer.com/address-detail/%s',
    ),
    ExplorerConfig(
      chain: 'ETH',
      name: 'Ethereum',
      mainUrl: 'https://etherscan.io',
      txUrl: 'https://cn.etherscan.com/search?f=0&q=%s',
    ),
    ExplorerConfig(
      chain: 'BTC',
      name: 'Bitcoin',
      mainUrl: 'https://btc.com',
      txUrl: 'https://btc.com/%s',
    ),
    ExplorerConfig(
      chain: 'TRX',
      name: 'Tron',
      mainUrl: 'https://tronscan.org/#/',
      txUrl: 'https://tronscan.org/#/transaction/%s',
      addressUrl: 'https://tronscan.org/#/address/%s',
    ),
  ];

  static String getChainExplorerTxUrl(String chain, String txid) {
    final list = explorerConfigs.firstWhere(
      (item) => item.chain == chain,
      orElse: () => null,
    );
    return list != null
        ? sprintf(list.txUrl, [txid])
        : 'https://www.bbcexplorer.com';
  }

  static String getChainExplorerSearchUrl(String chain, String term) {
    final list = explorerConfigs.firstWhere(
      (item) => item.chain == chain,
      orElse: () => null,
    );

    if (onlySearchAddress.contains(chain)) {
      return list != null
          ? sprintf(list.addressUrl, [term])
          : 'https://www.bbcexplorer.com';
    }

    return list != null
        ? sprintf(list.txUrl, [term])
        : 'https://www.bbcexplorer.com';
  }
}
