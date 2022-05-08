part of wallet_domain_module;

class WithdrawBeforeParams {
  WithdrawBeforeParams({
    @required this.chain,
    @required this.symbol,
    @required this.fromAddress,
    @required this.chainPrecision,
    this.contractOrForkId,
    this.toAddress,
    this.amount,
    this.txData,
  });

  final String chain;
  final String symbol;
  final String fromAddress;

  final int chainPrecision;

  /// [ETH or BCC Only]:  token contract/fork
  final String contractOrForkId;

  /// [ETH and BTC Only]: need toAddress to check for GAS fee
  final String toAddress;

  /// [BTC Only]: need to check for fee
  final double amount;

  /// [BBC Only]: transaction data, need for calculate the fee
  final String txData;
}

class WalletActionWithdrawBefore extends _BaseAction {
  WalletActionWithdrawBefore({
    this.params,
    this.completer,
    this.previousData,
    this.ignoreAddressCheck = false,
  });

  final WithdrawBeforeParams params;
  final WalletWithdrawData previousData;
  final Completer<WalletWithdrawData> completer;
  final bool ignoreAddressCheck;

  @override
  Future<AppState> reduce() async {
    final toAddress = params.toAddress;
    final chain = params.chain;

    // Validate toAddress
    if (ignoreAddressCheck != true &&
        toAddress != null &&
        toAddress.isNotEmpty) {
      await WalletRepository().validateAddress(
        chain: chain,
        address: toAddress,
      );
    }

    _BaseAction action;
    switch (chain) {
      case 'BTC':
        action = WalletActionBTCTxBefore(params, completer, previousData);
        break;
      case 'ETH':
        action = WalletActionETHTxBefore(params, completer);
        break;
      case 'BBC':
        //action = WalletActionBBCTxBefore(params, completer);
        action = WalletActionETHTxBefore(params, completer);
        break;
      case 'TRX':
        action = WalletActionTRXTxBefore(params, completer);
        break;
      default:
        completer.complete();
    }
    if (action != null) {
      await store.dispatchFuture(action, notify: false);
    }
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    // Customize errors
    if (error is PlatformException && error.code == 'AddressError') {
      completer.completeError(WalletAddressError());
      return error;
    }
    completer.completeError(error);
    CrashesReport().reportEvent(
      'WalletLog_10_WithdrawBefore',
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

//  ▼▼▼▼▼▼ Chains Implementations ▼▼▼▼▼▼  //

class WalletActionBTCTxBefore extends _BaseAction {
  WalletActionBTCTxBefore(
    this.params,
    this.completer, [
    this.perviousData,
  ]);
  static const chain = 'BTC';

  final WithdrawBeforeParams params;
  final WalletWithdrawData perviousData;
  final Completer<WalletWithdrawData> completer;

  @override
  Future<AppState> reduce() async {
    final toAddress = params.fromAddress;
    final fromAddress = params.fromAddress;
    final symbol = params.symbol;

    var data = perviousData;
    if (perviousData == null || perviousData?.utxos == null) {
      final utxosRequest = Completer<List<Map<String, dynamic>>>();
      final balance = state.walletState.activeWallet.getCoinBalance(
        chain: params.chain,
        symbol: symbol,
      );
      dispatch(WalletActionGetUnspent(
        chain: chain,
        symbol: symbol,
        address: fromAddress,
        completer: utxosRequest,
        balance: balance,
      ));
      final unspent = await utxosRequest.future;

      final feeJson = await WalletRepository().getFee(
        chain: chain,
        symbol: symbol,
        toAddress: toAddress,
        fromAddress: fromAddress,
      );

      final fee = WalletWithdrawFeeData.fromJson(
        json: feeJson,
        feeSymbol: 'BTC',
      );

      data = WalletWithdrawData(
        chain: chain,
        symbol: 'BTC',
        toAddress: toAddress,
        fromAddress: fromAddress,
        fee: fee,
        feeDefault: fee,
        utxos: unspent,
        contract: params.contractOrForkId,
      );
    }

    // Update fee with BTC value
    data.fee.feeValue = await WalletFeeUtils.getBTCFeeValue(
      satoshi: data.fee.feeRateToInt,
      fromAddress: fromAddress,
    );

    completer.complete(data);
    return null;
  }
}

class WalletActionETHTxBefore extends _BaseAction {
  WalletActionETHTxBefore(
    this.params,
    this.completer,
  );

  static const chain = 'ETH';

  final WithdrawBeforeParams params;
  final Completer<WalletWithdrawData> completer;

  @override
  Future<AppState> reduce() async {
    final symbol = params.symbol;
    final toAddress = params.toAddress;
    final fromAddress = params.fromAddress;

    final feeJson = await WalletRepository().getFee(
      chain: chain,
      symbol: symbol,
      toAddress: toAddress,
      fromAddress: fromAddress,
    );

    final nonce = NumberUtil.getInt(feeJson['nonce']);
    final gasPrice = NumberUtil.getInt(feeJson['gas_price']);
    final gasLimit = NumberUtil.getInt(feeJson['gas_limit']);
    // Since API do not return the rate, we need to add it
    feeJson['fee'] = WalletFeeUtils.getETHFeeRate(gasPrice);

    final fee = WalletWithdrawFeeData.fromJson(
      json: feeJson,
      feeSymbol: 'HAH',
      feeUnit: 'HAH',
    )
      ..nonce = nonce
      ..gasLimit = gasLimit
      ..gasPrice = gasPrice
      ..feeValue = WalletFeeUtils.getETHFeeValue(
        gasPrice: gasPrice,
        gasLimit: gasLimit,
        chainPrecision: params.chainPrecision,
      );

    final info = WalletWithdrawData(
      chain: chain,
      symbol: symbol,
      toAddress: toAddress,
      fromAddress: fromAddress,
      fee: fee,
      feeDefault: fee,
      utxos: [], // ETH don't have unspent
      contract: params.contractOrForkId,
    );

    completer.complete(info);
    return null;
  }
}

class WalletActionBBCTxBefore extends _BaseAction {
  WalletActionBBCTxBefore(
    this.params,
    this.completer,
  );
  static const chain = 'BBC';

  final WithdrawBeforeParams params;
  final Completer<WalletWithdrawData> completer;

  @override
  Future<AppState> reduce() async {
    final symbol = params.symbol;
    final toAddress = params.toAddress;
    final fromAddress = params.fromAddress;

    final utxosRequest = Completer<List<Map<String, dynamic>>>();
    final balance = state.walletState.activeWallet.getCoinBalance(
      chain: params.chain,
      symbol: symbol,
    );

    dispatch(WalletActionGetUnspent(
      chain: chain,
      symbol: symbol,
      address: fromAddress,
      completer: utxosRequest,
      balance: balance,
    ));
    final unspent = await utxosRequest.future;

    final feeJson = await WalletRepository().getFee(
      chain: chain,
      symbol: symbol,
      data: params.txData,
      toAddress: toAddress,
      fromAddress: fromAddress,
    );

    final fee = WalletWithdrawFeeData.fromJson(
      json: feeJson,
      feeSymbol: feeJson['unit']?.toString() ?? symbol,
    );
    fee.feeValue = WalletFeeUtils.getBBCFeeValue(
      bbc: fee.feeRateToDouble,
      chainPrecision: params.chainPrecision,
    );

    final info = WalletWithdrawData(
      chain: chain,
      symbol: symbol,
      toAddress: toAddress,
      fromAddress: fromAddress,
      fee: fee,
      feeDefault: fee,
      utxos: unspent,
      contract: params.contractOrForkId,
    );

    completer.complete(info);
    return null;
  }
}

class WalletActionTRXTxBefore extends _BaseAction {
  WalletActionTRXTxBefore(
    this.params,
    this.completer,
  );
  static const chain = 'TRX';

  final WithdrawBeforeParams params;
  final Completer<WalletWithdrawData> completer;

  @override
  Future<AppState> reduce() async {
    final symbol = params.symbol;
    final toAddress = params.toAddress;
    final fromAddress = params.fromAddress;

    final feeJson = await WalletRepository().getFee(
      chain: chain,
      symbol: symbol,
      data: params.txData,
      toAddress: toAddress,
      fromAddress: fromAddress,
    );

    final fee = WalletWithdrawFeeData.fromJson(
      json: feeJson,
      feeSymbol: 'TRX',
    );
    fee.feeValue = WalletFeeUtils.getTRXFeeValue(
      sun: fee.feeRateToInt,
      chainPrecision: params.chainPrecision,
    );

    final info = WalletWithdrawData(
      chain: chain,
      symbol: symbol,
      toAddress: toAddress,
      fromAddress: fromAddress,
      fee: fee,
      feeDefault: fee,
      utxos: [],
      contract: params.contractOrForkId,
    );

    completer.complete(info);
    return null;
  }
}
