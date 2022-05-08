part of wallet_domain_module;

class WalletWithdrawFeeData {
  WalletWithdrawFeeData({
    @required this.feeRate,
    @required this.feeValue,
    @required this.feeUnit,
    @required this.feeSymbol,
    this.feeError,
    this.gasPrice,
    this.gasLimit,
    this.nonce,
    this.feeLevel = 'default',
  });

  factory WalletWithdrawFeeData.fromJson({
    @required String feeSymbol,
    @required Map<String, dynamic> json,
    String feeUnit,
  }) {
    return WalletWithdrawFeeData(
      feeRate: json['fee']?.toString(),
      feeValue: 0,
      feeUnit: feeUnit ?? json['unit']?.toString(),
      feeSymbol: feeSymbol,
      feeError: json['risk']?.toString(),
    );
  }

  int gasPrice;
  int gasLimit;
  int nonce;

  final String feeRate;

  int get feeRateToInt => NumberUtil.getInt(feeRate);
  double get feeRateToDouble => NumberUtil.getDouble(feeRate);

  /// 矿工费分级
  final String feeLevel;

  /// Mainly use for Bitcoin (satoshi/byte)
  final String feeUnit;

  /// Fee in coin symbol
  final String feeSymbol;

  /// Error code from getFee API
  /// null is not error
  final String feeError;

  /// Fee in current chain symbol
  double feeValue;

  WalletWithdrawFeeData copyWith({
    String feeRate,
    String feeLevel,
    String feeUnit,
    String feeSymbol,
    String feeError,
    double feeValue,
    int gasPrice,
    int gasLimit,
    int nonce,
  }) {
    return WalletWithdrawFeeData(
      feeRate: feeRate ?? this.feeRate,
      feeLevel: feeLevel ?? this.feeLevel,
      feeUnit: feeUnit ?? this.feeUnit,
      feeSymbol: feeSymbol ?? this.feeSymbol,
      feeError: feeError ?? this.feeError,
      feeValue: feeValue ?? this.feeValue,
      gasPrice: gasPrice ?? this.gasPrice,
      gasLimit: gasLimit ?? this.gasLimit,
      nonce: nonce ?? this.nonce,
    );
  }
}

/// WithdrawData
///
class WalletWithdrawData {
  WalletWithdrawData({
    @required this.chain,
    @required this.symbol,
    @required this.fromAddress,
    @required this.contract,
    @required this.utxos,
    @required this.fee,
    @required this.feeDefault,
    this.toAddress,
  });

  final String chain;
  final String symbol;
  final String fromAddress;

  /// Fork ID or ETH Token Contract
  final String contract;

  /// fromAddress unspent utxos
  final List<Map<String, dynamic>> utxos;

  final WalletWithdrawFeeData feeDefault;

  /// Fee in current chain symbol
  WalletWithdrawFeeData fee;

  /// Used for bitcoin, the fee in satoshi/byte

  /// Used for ETH since we need the toAddress to get the fee
  String toAddress;

  bool get isDoubleTransaction => false;
  // bool get isDoubleTransaction =>
  //     feeError != null &&
  //     feeError == 'INTERACT_WITH_THE_SAME_WALLET_FREQUENTLY';

  /// Return true if the withdraw fee symbol is same as withdraw symbol
  /// Example:
  /// for ETH is true
  /// for USDT is false
  bool get isFeeOnSymbol => fee?.feeSymbol == symbol;

  String get displayFee => fee?.feeValue != null && fee.feeValue > 0
      ? NumberUtil.truncateDecimal<String>(fee.feeValue, 10)
      : '-';
}
