part of open_domain_module;

class JsMethods {
  /// Return the balance of a given coin
  /// [Args] are chain and symbol
  static const String getBalance = 'sugGetBalance';

  /// Return the balance of a given coin
  ///   /// [Args] are chain and symbol
  static const String getAddress = 'sugGetAddress';

  /// Return active wallet Id
  static const String getWalletId = 'sugGetWalletId';
  static const String getLanguage = 'sugGetLanguage';
  static const String getFiatCurrency = 'sugGetFiatCurrency';
  static const String transferOut = 'sugTransferOut';

  static const List<String> allMethods = [
    getBalance,
    getAddress,
    getWalletId,
    getLanguage,
    getFiatCurrency,
    transferOut
  ];

  static MapEntry<String, String> getParamsChainSymbol(List<dynamic> args) {
    final Map params = args != null && args.isNotEmpty && args[0] is Map
        ? args[0] as Map
        : null;
    if (params != null && params['chain'] != null && params['symbol'] != null) {
      return MapEntry(
        params['chain'].toString(),
        params['symbol'].toString(),
      );
    }
    return null;
  }
}
