part of wallet_domain_module;

String generatePrivateKey() {
  //final timestamp = DateTime.now().microsecondsSinceEpoch;
  //final timestampByte = hex.decode(timestamp.toString());
  //final randomByte = PrivateKey.randomBytes(24).extractSync();
  //final result = hex.encode(timestampByte + randomByte);
  //return result;
  throw 'err';
  return '';
}

class DexCreateOrderParams {
  DexCreateOrderParams({
    required this.chain,
    required this.symbol,
    required this.price,
    required this.amount,
    required this.total,
    required this.sellAddress,
    required this.sellContract,
    required this.sellChainPrecision,
    required this.buyAddress,
    required this.buyContract,
    required this.buyChainPrecision,
    required this.tradePairId,
    required this.isBuy,
    required this.matchFee,
    required this.maxBlockHeight,
    required this.minBlockHeight,
    required this.currentHeight,
    required this.matchAddress,
    required this.dealAddress,
    required this.withdrawData,
  });

  final double amount;

  /// To Buy Receiving Address
  /// address from witch the coin are received
  final String buyAddress;

  final int buyChainPrecision;
  final String buyContract;
  final String chain;
  final int currentHeight;
  final String dealAddress;
  final bool isBuy;
  final String matchAddress;

  /// from api, in percentage
  final int matchFee;

  final int maxBlockHeight;
  final int minBlockHeight;
  final double price;

  /// From: Seller address
  /// address from witch the coin are sent out
  final String sellAddress;

  final int sellChainPrecision;
  final String sellContract;
  final String symbol;
  late WalletTemplateData templateData;
  final double total;
  final String tradePairId;
  WalletWithdrawData withdrawData;

  String get displayMatchFee => (matchFee / 100).toString();

  int get validHeight => currentHeight + maxBlockHeight;

  double get payAmount => isBuy ? total : amount;

  /// If true, this chain used API to create Order transaction RawTx
  bool get isChainUseApiRawTx => ['ETH', 'TRX'].contains(chain);
}

class WalletActionCreateDexOrderTemplate extends _BaseAction {
  WalletActionCreateDexOrderTemplate(
    this.params,
    this.completer,
  );

  final Completer<WalletTemplateData> completer;
  final DexCreateOrderParams params;

  @override
  Future<AppState?> reduce() async {
    final chain = params.chain;

    late _BaseAction action;
    switch (chain) {
      case 'ETH':
      case 'TRX':
        action = _WalletActionCreateDexOrderTemplateApi(params, completer);
        break;
      default:
        completer.completeError(
          'WalletActionCreateDexOrderTemplate Not Implemented',
        );
    }
    if (action != null) {
      await store.dispatchAsync(action, notify: false);
    }
    return null;
  }

  @override
  Object? wrapError(dynamic error) {
    // Customize errors
    if (error is PlatformException && error.code == 'AddressError') {
      completer.completeError(WalletAddressError());
      return error;
    }
    completer.completeError(error as Object);
    CrashesReport().reportEvent(
      'WalletLog_11_DexCreateOrder',
      error,
      StackTrace.current,
      {
        'chain': params.chain,
        'symbol': params.symbol,
      },
    );
    return error;
  }
}

class _WalletActionCreateDexOrderTemplateApi extends _BaseAction {
  _WalletActionCreateDexOrderTemplateApi(
    this.params,
    this.completer,
  );

  final Completer<WalletTemplateData> completer;
  final DexCreateOrderParams params;

  @override
  Future<AppState?> reduce() async {
    final primaryKey = generatePrivateKey();

    final buyAmount = NumberUtil.getAmountAsInt(
      params.amount,
      params.buyChainPrecision,
    );

    final sellAmount = NumberUtil.getAmountAsInt(
      params.total,
      params.sellChainPrecision,
    );

    final transInfo = await WalletRepository().dexCreateApiOrderTransaction(
      chain: params.chain,
      symbol: params.symbol,
      buyAmount: buyAmount,
      sellAmount: sellAmount,
      fee: params.matchFee,
      validHeight: params.validHeight,
      sellAddress: params.sellAddress,
      recvAddress: params.buyAddress,
      matchAddress: params.matchAddress,
      dealAddress: params.dealAddress,
      sellContract: params.sellContract, // USDT(ETH) contract
      buyContract: params.buyContract, //
      primaryKey: primaryKey,
    );

    completer.complete(WalletTemplateData(
      chain: params.chain,
      symbol: params.symbol,
      templateHex: primaryKey,
      templateData: transInfo,
      templateAddress: params.sellAddress,
    ));
    return null;
  }
}
