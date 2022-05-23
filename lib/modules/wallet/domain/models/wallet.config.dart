part of wallet_domain_module;

/// Chains that need to fetch Unspent data before make a transaction
const kChainsNeedUnspent = ['BTC', 'BBC'];

/// Chains that need lock refresh balance
const kChainsNeedLockBalance = ['ETH', 'TRX', 'BTC'];

// Chains where balance api return Unconfirmed balance
const kChainsHasUnconfirmedBalance = ['BBC'];

class WalletConfigNetwork {
  static bool bbc = kDebugMode;
  static bool btc = false;
  static bool eth = false;
  static bool trx = false;

  static bool getTestNetByChain(String chain) {
    switch (chain) {
      case 'BBC':
        return WalletConfigNetwork.bbc;
        break;
      case 'BTC':
        return WalletConfigNetwork.btc;
        break;
      case 'ETH':
        return WalletConfigNetwork.eth;
        break;
      case 'TRX':
        return WalletConfigNetwork.trx;
        break;
      default:
        return true;
    }
  }

  static void setTestNetByChain(String chain, {bool value}) {
    switch (chain) {
      case 'BBC':
        WalletConfigNetwork.bbc = value;
        break;
      case 'BTC':
        WalletConfigNetwork.btc = value;
        break;
      case 'ETH':
        WalletConfigNetwork.eth = value;
        break;
      case 'TRX':
        WalletConfigNetwork.trx = value;
        break;
      default:
    }
  }
}
