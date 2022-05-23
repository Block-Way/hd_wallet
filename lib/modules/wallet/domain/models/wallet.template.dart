part of wallet_domain_module;

class WalletTemplateData {
  WalletTemplateData({
    @required this.chain,
    @required this.symbol,
    @required this.templateHex,
    @required this.templateData,
    @required this.templateAddress,
  });

  final String chain;
  final String symbol;

  /// - For BBC this is the Template Address
  /// - For ETH/TRX this is the Primary Key
  final String templateAddress;

  /// Template raw data (Fee, RawTx, )
  final Map<String, dynamic> templateData;

  /// - For BBC this is the Template Hex
  /// - For ETH/TRX this is the Primary Key
  final String templateHex;

  String get rawTx => templateData['raw']?.toString();

  String get contract =>
      templateData['contract']?.toString() ?? templateAddress;

  int get gasLimit => NumberUtil.getInt(templateData['gas_limit']);

  int get gasPrice => NumberUtil.getInt(templateData['gas_price']);

  int get trxSun => NumberUtil.getInt(templateData['fee']);

  String get feeSymbol {
    switch (chain) {
      case 'TRX':
      case 'ETH':
        return chain;
      case 'BBC':
        return symbol;
      default:
        return chain;
    }
  }

  double get feeValue {
    switch (chain) {
      case 'TRX':
        return WalletFeeUtils.getTRXFeeValue(
          sun: trxSun,
          chainPrecision: 8, // TRX is 8
        );
      case 'ETH':
        return WalletFeeUtils.getETHFeeValue(
          gasPrice: gasPrice,
          gasLimit: gasLimit,
          chainPrecision: 10, // ETH is 18 but we only show 10
        );
      case 'BBC':
        return WalletFeeUtils.getBBCFeeValue(
          bbc: NumberUtil.getDouble(templateData['fee']),
          chainPrecision: 8,
        );
      default:
        return 0.0;
    }
  }
}
