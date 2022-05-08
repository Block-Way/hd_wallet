// GENERATED CODE - DO NOT MODIFY BY HAND

part of swap_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SwapConfig> _$swapConfigSerializer = new _$SwapConfigSerializer();
Serializer<SwapConfigCoin> _$swapConfigCoinSerializer =
    new _$SwapConfigCoinSerializer();
Serializer<SwapState> _$swapStateSerializer = new _$SwapStateSerializer();

class _$SwapConfigSerializer implements StructuredSerializer<SwapConfig> {
  @override
  final Iterable<Type> types = const [SwapConfig, _$SwapConfig];
  @override
  final String wireName = 'SwapConfig';

  @override
  Iterable<Object> serialize(Serializers serializers, SwapConfig object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.tradePairs != null) {
      result
        ..add('tradePairs')
        ..add(serializers.serialize(object.tradePairs,
            specifiedType: const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(SwapConfigCoin)])
            ])));
    }
    return result;
  }

  @override
  SwapConfig deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SwapConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'tradePairs':
          result.tradePairs.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    BuiltList, const [const FullType(SwapConfigCoin)])
              ])) as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SwapConfigCoinSerializer
    implements StructuredSerializer<SwapConfigCoin> {
  @override
  final Iterable<Type> types = const [SwapConfigCoin, _$SwapConfigCoin];
  @override
  final String wireName = 'SwapConfigCoin';

  @override
  Iterable<Object> serialize(Serializers serializers, SwapConfigCoin object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'transfer_min',
      serializers.serialize(object.transferMin,
          specifiedType: const FullType(double)),
      'transfer_max',
      serializers.serialize(object.transferMax,
          specifiedType: const FullType(double)),
    ];
    if (object.address != null) {
      result
        ..add('address')
        ..add(serializers.serialize(object.address,
            specifiedType: const FullType(String)));
    }
    if (object.chain != null) {
      result
        ..add('chain')
        ..add(serializers.serialize(object.chain,
            specifiedType: const FullType(String)));
    }
    if (object.symbol != null) {
      result
        ..add('symbol')
        ..add(serializers.serialize(object.symbol,
            specifiedType: const FullType(String)));
    }
    if (object.transferFee != null) {
      result
        ..add('transfer_fee')
        ..add(serializers.serialize(object.transferFee,
            specifiedType: const FullType(double)));
    }
    if (object.enabled != null) {
      result
        ..add('enabled')
        ..add(serializers.serialize(object.enabled,
            specifiedType: const FullType(bool)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SwapConfigCoin deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SwapConfigCoinBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'chain':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'transfer_min':
          result.transferMin = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'transfer_max':
          result.transferMax = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'transfer_fee':
          result.transferFee = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'enabled':
          result.enabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SwapStateSerializer implements StructuredSerializer<SwapState> {
  @override
  final Iterable<Type> types = const [SwapState, _$SwapState];
  @override
  final String wireName = 'SwapState';

  @override
  Iterable<Object> serialize(Serializers serializers, SwapState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.config != null) {
      result
        ..add('config')
        ..add(serializers.serialize(object.config,
            specifiedType: const FullType(SwapConfig)));
    }
    if (object.configState != null) {
      result
        ..add('configState')
        ..add(serializers.serialize(object.configState,
            specifiedType: const FullType(int)));
    }
    if (object.swaps != null) {
      result
        ..add('swaps')
        ..add(serializers.serialize(object.swaps,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Swap)])));
    }
    return result;
  }

  @override
  SwapState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SwapStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'config':
          result.config.replace(serializers.deserialize(value,
              specifiedType: const FullType(SwapConfig)) as SwapConfig);
          break;
        case 'configState':
          result.configState = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'swaps':
          result.swaps.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Swap)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SwapCreateVM extends SwapCreateVM {
  @override
  final double Function({@required String chain, @required String symbol})
      getCoinBalance;
  @override
  final AssetCoin Function({@required String chain, @required String symbol})
      getCoinInfo;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;
  @override
  final List<MapEntry<SwapConfigCoin, SwapConfigCoin>> Function()
      getEnabledTradePairs;
  @override
  final Future<double> Function(
      {@required String chain, @required String symbol}) getApproveBalance;
  @override
  final Future<Transaction> Function(
      {@required String chain,
      @required String symbol,
      @required String fromAddress,
      @required int chainPrecision,
      @required String txId}) getTransactionInfo;
  @override
  final Future<void> Function(
      {AssetCoin outCoinInfo,
      SwapConfigCoin outCoinConfig,
      Future<WalletPrivateData> Function() onUnlockWallet,
      Future<bool> Function(
              {@required WalletTemplateData approveData,
              @required double currentBalance,
              @required double approveAmount,
              @required bool needReset})
          onConfirmSubmit,
      void Function(String) onSuccessTransaction}) doApproveSwap;
  @override
  final Future<void> Function(
      {String amount,
      AssetCoin inCoinInfo,
      AssetCoin outCoinInfo,
      SwapConfigCoin inCoinConfig,
      SwapConfigCoin outCoinConfig,
      Future<WalletPrivateData> Function() onUnlockWallet,
      Future<bool> Function() onNoticeDoubleTransaction,
      Future<bool> Function(SwapCreateParams) onConfirmSubmit,
      void Function(String) onSuccessTransaction}) doSubmitSwap;

  factory _$SwapCreateVM([void Function(SwapCreateVMBuilder) updates]) =>
      (new SwapCreateVMBuilder()..update(updates)).build();

  _$SwapCreateVM._(
      {this.getCoinBalance,
      this.getCoinInfo,
      this.doUnlockWallet,
      this.getEnabledTradePairs,
      this.getApproveBalance,
      this.getTransactionInfo,
      this.doApproveSwap,
      this.doSubmitSwap})
      : super._() {
    if (getCoinBalance == null) {
      throw new BuiltValueNullFieldError('SwapCreateVM', 'getCoinBalance');
    }
    if (getCoinInfo == null) {
      throw new BuiltValueNullFieldError('SwapCreateVM', 'getCoinInfo');
    }
    if (doUnlockWallet == null) {
      throw new BuiltValueNullFieldError('SwapCreateVM', 'doUnlockWallet');
    }
    if (getEnabledTradePairs == null) {
      throw new BuiltValueNullFieldError(
          'SwapCreateVM', 'getEnabledTradePairs');
    }
    if (getApproveBalance == null) {
      throw new BuiltValueNullFieldError('SwapCreateVM', 'getApproveBalance');
    }
    if (getTransactionInfo == null) {
      throw new BuiltValueNullFieldError('SwapCreateVM', 'getTransactionInfo');
    }
    if (doApproveSwap == null) {
      throw new BuiltValueNullFieldError('SwapCreateVM', 'doApproveSwap');
    }
    if (doSubmitSwap == null) {
      throw new BuiltValueNullFieldError('SwapCreateVM', 'doSubmitSwap');
    }
  }

  @override
  SwapCreateVM rebuild(void Function(SwapCreateVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SwapCreateVMBuilder toBuilder() => new SwapCreateVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwapCreateVM;
  }

  @override
  int get hashCode {
    return 163385258;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SwapCreateVM')
          ..add('getCoinBalance', getCoinBalance)
          ..add('getCoinInfo', getCoinInfo)
          ..add('doUnlockWallet', doUnlockWallet)
          ..add('getEnabledTradePairs', getEnabledTradePairs)
          ..add('getApproveBalance', getApproveBalance)
          ..add('getTransactionInfo', getTransactionInfo)
          ..add('doApproveSwap', doApproveSwap)
          ..add('doSubmitSwap', doSubmitSwap))
        .toString();
  }
}

class SwapCreateVMBuilder
    implements Builder<SwapCreateVM, SwapCreateVMBuilder> {
  _$SwapCreateVM _$v;

  double Function({@required String chain, @required String symbol})
      _getCoinBalance;
  double Function({@required String chain, @required String symbol})
      get getCoinBalance => _$this._getCoinBalance;
  set getCoinBalance(
          double Function({@required String chain, @required String symbol})
              getCoinBalance) =>
      _$this._getCoinBalance = getCoinBalance;

  AssetCoin Function({@required String chain, @required String symbol})
      _getCoinInfo;
  AssetCoin Function({@required String chain, @required String symbol})
      get getCoinInfo => _$this._getCoinInfo;
  set getCoinInfo(
          AssetCoin Function({@required String chain, @required String symbol})
              getCoinInfo) =>
      _$this._getCoinInfo = getCoinInfo;

  Future<WalletPrivateData> Function(String password) _doUnlockWallet;
  Future<WalletPrivateData> Function(String password) get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password) doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  List<MapEntry<SwapConfigCoin, SwapConfigCoin>> Function()
      _getEnabledTradePairs;
  List<MapEntry<SwapConfigCoin, SwapConfigCoin>> Function()
      get getEnabledTradePairs => _$this._getEnabledTradePairs;
  set getEnabledTradePairs(
          List<MapEntry<SwapConfigCoin, SwapConfigCoin>> Function()
              getEnabledTradePairs) =>
      _$this._getEnabledTradePairs = getEnabledTradePairs;

  Future<double> Function({@required String chain, @required String symbol})
      _getApproveBalance;
  Future<double> Function({@required String chain, @required String symbol})
      get getApproveBalance => _$this._getApproveBalance;
  set getApproveBalance(
          Future<double> Function(
                  {@required String chain, @required String symbol})
              getApproveBalance) =>
      _$this._getApproveBalance = getApproveBalance;

  Future<Transaction> Function(
      {@required String chain,
      @required String symbol,
      @required String fromAddress,
      @required int chainPrecision,
      @required String txId}) _getTransactionInfo;
  Future<Transaction> Function(
          {@required String chain,
          @required String symbol,
          @required String fromAddress,
          @required int chainPrecision,
          @required String txId})
      get getTransactionInfo => _$this._getTransactionInfo;
  set getTransactionInfo(
          Future<Transaction> Function(
                  {@required String chain,
                  @required String symbol,
                  @required String fromAddress,
                  @required int chainPrecision,
                  @required String txId})
              getTransactionInfo) =>
      _$this._getTransactionInfo = getTransactionInfo;

  Future<void> Function(
      {AssetCoin outCoinInfo,
      SwapConfigCoin outCoinConfig,
      Future<WalletPrivateData> Function() onUnlockWallet,
      Future<bool> Function(
              {@required WalletTemplateData approveData,
              @required double currentBalance,
              @required double approveAmount,
              @required bool needReset})
          onConfirmSubmit,
      void Function(String) onSuccessTransaction}) _doApproveSwap;
  Future<void> Function(
          {AssetCoin outCoinInfo,
          SwapConfigCoin outCoinConfig,
          Future<WalletPrivateData> Function() onUnlockWallet,
          Future<bool> Function(
                  {@required WalletTemplateData approveData,
                  @required double currentBalance,
                  @required double approveAmount,
                  @required bool needReset})
              onConfirmSubmit,
          void Function(String) onSuccessTransaction})
      get doApproveSwap => _$this._doApproveSwap;
  set doApproveSwap(
          Future<void> Function(
                  {AssetCoin outCoinInfo,
                  SwapConfigCoin outCoinConfig,
                  Future<WalletPrivateData> Function() onUnlockWallet,
                  Future<bool> Function(
                          {@required WalletTemplateData approveData,
                          @required double currentBalance,
                          @required double approveAmount,
                          @required bool needReset})
                      onConfirmSubmit,
                  void Function(String) onSuccessTransaction})
              doApproveSwap) =>
      _$this._doApproveSwap = doApproveSwap;

  Future<void> Function(
      {String amount,
      AssetCoin inCoinInfo,
      AssetCoin outCoinInfo,
      SwapConfigCoin inCoinConfig,
      SwapConfigCoin outCoinConfig,
      Future<WalletPrivateData> Function() onUnlockWallet,
      Future<bool> Function() onNoticeDoubleTransaction,
      Future<bool> Function(SwapCreateParams) onConfirmSubmit,
      void Function(String) onSuccessTransaction}) _doSubmitSwap;
  Future<void> Function(
          {String amount,
          AssetCoin inCoinInfo,
          AssetCoin outCoinInfo,
          SwapConfigCoin inCoinConfig,
          SwapConfigCoin outCoinConfig,
          Future<WalletPrivateData> Function() onUnlockWallet,
          Future<bool> Function() onNoticeDoubleTransaction,
          Future<bool> Function(SwapCreateParams) onConfirmSubmit,
          void Function(String) onSuccessTransaction})
      get doSubmitSwap => _$this._doSubmitSwap;
  set doSubmitSwap(
          Future<void> Function(
                  {String amount,
                  AssetCoin inCoinInfo,
                  AssetCoin outCoinInfo,
                  SwapConfigCoin inCoinConfig,
                  SwapConfigCoin outCoinConfig,
                  Future<WalletPrivateData> Function() onUnlockWallet,
                  Future<bool> Function() onNoticeDoubleTransaction,
                  Future<bool> Function(SwapCreateParams) onConfirmSubmit,
                  void Function(String) onSuccessTransaction})
              doSubmitSwap) =>
      _$this._doSubmitSwap = doSubmitSwap;

  SwapCreateVMBuilder();

  SwapCreateVMBuilder get _$this {
    if (_$v != null) {
      _getCoinBalance = _$v.getCoinBalance;
      _getCoinInfo = _$v.getCoinInfo;
      _doUnlockWallet = _$v.doUnlockWallet;
      _getEnabledTradePairs = _$v.getEnabledTradePairs;
      _getApproveBalance = _$v.getApproveBalance;
      _getTransactionInfo = _$v.getTransactionInfo;
      _doApproveSwap = _$v.doApproveSwap;
      _doSubmitSwap = _$v.doSubmitSwap;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwapCreateVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SwapCreateVM;
  }

  @override
  void update(void Function(SwapCreateVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SwapCreateVM build() {
    final _$result = _$v ??
        new _$SwapCreateVM._(
            getCoinBalance: getCoinBalance,
            getCoinInfo: getCoinInfo,
            doUnlockWallet: doUnlockWallet,
            getEnabledTradePairs: getEnabledTradePairs,
            getApproveBalance: getApproveBalance,
            getTransactionInfo: getTransactionInfo,
            doApproveSwap: doApproveSwap,
            doSubmitSwap: doSubmitSwap);
    replace(_$result);
    return _$result;
  }
}

class _$SwapListVM extends SwapListVM {
  @override
  final BuiltList<Swap> swapList;
  @override
  final Future<int> Function(int skip, int page) loadData;
  @override
  final Future<void> Function(Swap item) doReSubmit;

  factory _$SwapListVM([void Function(SwapListVMBuilder) updates]) =>
      (new SwapListVMBuilder()..update(updates)).build();

  _$SwapListVM._({this.swapList, this.loadData, this.doReSubmit}) : super._() {
    if (loadData == null) {
      throw new BuiltValueNullFieldError('SwapListVM', 'loadData');
    }
    if (doReSubmit == null) {
      throw new BuiltValueNullFieldError('SwapListVM', 'doReSubmit');
    }
  }

  @override
  SwapListVM rebuild(void Function(SwapListVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SwapListVMBuilder toBuilder() => new SwapListVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwapListVM && swapList == other.swapList;
  }

  @override
  int get hashCode {
    return $jf($jc(0, swapList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SwapListVM')
          ..add('swapList', swapList)
          ..add('loadData', loadData)
          ..add('doReSubmit', doReSubmit))
        .toString();
  }
}

class SwapListVMBuilder implements Builder<SwapListVM, SwapListVMBuilder> {
  _$SwapListVM _$v;

  ListBuilder<Swap> _swapList;
  ListBuilder<Swap> get swapList =>
      _$this._swapList ??= new ListBuilder<Swap>();
  set swapList(ListBuilder<Swap> swapList) => _$this._swapList = swapList;

  Future<int> Function(int skip, int page) _loadData;
  Future<int> Function(int skip, int page) get loadData => _$this._loadData;
  set loadData(Future<int> Function(int skip, int page) loadData) =>
      _$this._loadData = loadData;

  Future<void> Function(Swap item) _doReSubmit;
  Future<void> Function(Swap item) get doReSubmit => _$this._doReSubmit;
  set doReSubmit(Future<void> Function(Swap item) doReSubmit) =>
      _$this._doReSubmit = doReSubmit;

  SwapListVMBuilder();

  SwapListVMBuilder get _$this {
    if (_$v != null) {
      _swapList = _$v.swapList?.toBuilder();
      _loadData = _$v.loadData;
      _doReSubmit = _$v.doReSubmit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwapListVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SwapListVM;
  }

  @override
  void update(void Function(SwapListVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SwapListVM build() {
    _$SwapListVM _$result;
    try {
      _$result = _$v ??
          new _$SwapListVM._(
              swapList: _swapList?.build(),
              loadData: loadData,
              doReSubmit: doReSubmit);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'swapList';
        _swapList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SwapListVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SwapConfig extends SwapConfig {
  @override
  final BuiltList<BuiltList<SwapConfigCoin>> tradePairs;

  factory _$SwapConfig([void Function(SwapConfigBuilder) updates]) =>
      (new SwapConfigBuilder()..update(updates)).build();

  _$SwapConfig._({this.tradePairs}) : super._();

  @override
  SwapConfig rebuild(void Function(SwapConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SwapConfigBuilder toBuilder() => new SwapConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwapConfig && tradePairs == other.tradePairs;
  }

  @override
  int get hashCode {
    return $jf($jc(0, tradePairs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SwapConfig')
          ..add('tradePairs', tradePairs))
        .toString();
  }
}

class SwapConfigBuilder implements Builder<SwapConfig, SwapConfigBuilder> {
  _$SwapConfig _$v;

  ListBuilder<BuiltList<SwapConfigCoin>> _tradePairs;
  ListBuilder<BuiltList<SwapConfigCoin>> get tradePairs =>
      _$this._tradePairs ??= new ListBuilder<BuiltList<SwapConfigCoin>>();
  set tradePairs(ListBuilder<BuiltList<SwapConfigCoin>> tradePairs) =>
      _$this._tradePairs = tradePairs;

  SwapConfigBuilder();

  SwapConfigBuilder get _$this {
    if (_$v != null) {
      _tradePairs = _$v.tradePairs?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwapConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SwapConfig;
  }

  @override
  void update(void Function(SwapConfigBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SwapConfig build() {
    _$SwapConfig _$result;
    try {
      _$result = _$v ?? new _$SwapConfig._(tradePairs: _tradePairs?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tradePairs';
        _tradePairs?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SwapConfig', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SwapConfigCoin extends SwapConfigCoin {
  @override
  final String address;
  @override
  final String chain;
  @override
  final String symbol;
  @override
  final double transferMin;
  @override
  final double transferMax;
  @override
  final double transferFee;
  @override
  final bool enabled;
  @override
  final String name;

  factory _$SwapConfigCoin([void Function(SwapConfigCoinBuilder) updates]) =>
      (new SwapConfigCoinBuilder()..update(updates)).build();

  _$SwapConfigCoin._(
      {this.address,
      this.chain,
      this.symbol,
      this.transferMin,
      this.transferMax,
      this.transferFee,
      this.enabled,
      this.name})
      : super._() {
    if (transferMin == null) {
      throw new BuiltValueNullFieldError('SwapConfigCoin', 'transferMin');
    }
    if (transferMax == null) {
      throw new BuiltValueNullFieldError('SwapConfigCoin', 'transferMax');
    }
  }

  @override
  SwapConfigCoin rebuild(void Function(SwapConfigCoinBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SwapConfigCoinBuilder toBuilder() =>
      new SwapConfigCoinBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwapConfigCoin &&
        address == other.address &&
        chain == other.chain &&
        symbol == other.symbol &&
        transferMin == other.transferMin &&
        transferMax == other.transferMax &&
        transferFee == other.transferFee &&
        enabled == other.enabled &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, address.hashCode), chain.hashCode),
                            symbol.hashCode),
                        transferMin.hashCode),
                    transferMax.hashCode),
                transferFee.hashCode),
            enabled.hashCode),
        name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SwapConfigCoin')
          ..add('address', address)
          ..add('chain', chain)
          ..add('symbol', symbol)
          ..add('transferMin', transferMin)
          ..add('transferMax', transferMax)
          ..add('transferFee', transferFee)
          ..add('enabled', enabled)
          ..add('name', name))
        .toString();
  }
}

class SwapConfigCoinBuilder
    implements Builder<SwapConfigCoin, SwapConfigCoinBuilder> {
  _$SwapConfigCoin _$v;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _chain;
  String get chain => _$this._chain;
  set chain(String chain) => _$this._chain = chain;

  String _symbol;
  String get symbol => _$this._symbol;
  set symbol(String symbol) => _$this._symbol = symbol;

  double _transferMin;
  double get transferMin => _$this._transferMin;
  set transferMin(double transferMin) => _$this._transferMin = transferMin;

  double _transferMax;
  double get transferMax => _$this._transferMax;
  set transferMax(double transferMax) => _$this._transferMax = transferMax;

  double _transferFee;
  double get transferFee => _$this._transferFee;
  set transferFee(double transferFee) => _$this._transferFee = transferFee;

  bool _enabled;
  bool get enabled => _$this._enabled;
  set enabled(bool enabled) => _$this._enabled = enabled;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  SwapConfigCoinBuilder();

  SwapConfigCoinBuilder get _$this {
    if (_$v != null) {
      _address = _$v.address;
      _chain = _$v.chain;
      _symbol = _$v.symbol;
      _transferMin = _$v.transferMin;
      _transferMax = _$v.transferMax;
      _transferFee = _$v.transferFee;
      _enabled = _$v.enabled;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwapConfigCoin other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SwapConfigCoin;
  }

  @override
  void update(void Function(SwapConfigCoinBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SwapConfigCoin build() {
    final _$result = _$v ??
        new _$SwapConfigCoin._(
            address: address,
            chain: chain,
            symbol: symbol,
            transferMin: transferMin,
            transferMax: transferMax,
            transferFee: transferFee,
            enabled: enabled,
            name: name);
    replace(_$result);
    return _$result;
  }
}

class _$SwapState extends SwapState {
  @override
  final SwapConfig config;
  @override
  final int configState;
  @override
  final BuiltList<Swap> swaps;

  factory _$SwapState([void Function(SwapStateBuilder) updates]) =>
      (new SwapStateBuilder()..update(updates)).build();

  _$SwapState._({this.config, this.configState, this.swaps}) : super._();

  @override
  SwapState rebuild(void Function(SwapStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SwapStateBuilder toBuilder() => new SwapStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwapState &&
        config == other.config &&
        configState == other.configState &&
        swaps == other.swaps;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, config.hashCode), configState.hashCode), swaps.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SwapState')
          ..add('config', config)
          ..add('configState', configState)
          ..add('swaps', swaps))
        .toString();
  }
}

class SwapStateBuilder implements Builder<SwapState, SwapStateBuilder> {
  _$SwapState _$v;

  SwapConfigBuilder _config;
  SwapConfigBuilder get config => _$this._config ??= new SwapConfigBuilder();
  set config(SwapConfigBuilder config) => _$this._config = config;

  int _configState;
  int get configState => _$this._configState;
  set configState(int configState) => _$this._configState = configState;

  ListBuilder<Swap> _swaps;
  ListBuilder<Swap> get swaps => _$this._swaps ??= new ListBuilder<Swap>();
  set swaps(ListBuilder<Swap> swaps) => _$this._swaps = swaps;

  SwapStateBuilder();

  SwapStateBuilder get _$this {
    if (_$v != null) {
      _config = _$v.config?.toBuilder();
      _configState = _$v.configState;
      _swaps = _$v.swaps?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwapState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SwapState;
  }

  @override
  void update(void Function(SwapStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SwapState build() {
    _$SwapState _$result;
    try {
      _$result = _$v ??
          new _$SwapState._(
              config: _config?.build(),
              configState: configState,
              swaps: _swaps?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();

        _$failedField = 'swaps';
        _swaps?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SwapState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SwapStatusAdapter extends TypeAdapter<SwapStatus> {
  @override
  final int typeId = 40;

  @override
  SwapStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SwapStatus.pending;
      case 1:
        return SwapStatus.confirming;
      case 2:
        return SwapStatus.success;
      case 3:
        return SwapStatus.abnormalData;
      case 4:
        return SwapStatus.failed;
      case 5:
        return SwapStatus.noTxid;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, SwapStatus obj) {
    switch (obj) {
      case SwapStatus.pending:
        writer.writeByte(0);
        break;
      case SwapStatus.confirming:
        writer.writeByte(1);
        break;
      case SwapStatus.success:
        writer.writeByte(2);
        break;
      case SwapStatus.abnormalData:
        writer.writeByte(3);
        break;
      case SwapStatus.failed:
        writer.writeByte(4);
        break;
      case SwapStatus.noTxid:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwapStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SwapAdapter extends TypeAdapter<Swap> {
  @override
  final int typeId = 41;

  @override
  Swap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Swap()
      ..txId = fields[0] as String
      ..toAddress = fields[1] as String
      ..fromAddress = fields[2] as String
      ..outSymbol = fields[4] as String
      ..outChain = fields[5] as String
      ..outAmount = fields[6] as String
      ..inSymbol = fields[7] as String
      ..inChain = fields[8] as String
      ..inAmount = fields[9] as String
      ..transferFee = fields[10] as double
      ..createdAt = fields[11] as int
      ..updatedAt = fields[12] as int
      ..status = fields[20] as SwapStatus;
  }

  @override
  void write(BinaryWriter writer, Swap obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.txId)
      ..writeByte(1)
      ..write(obj.toAddress)
      ..writeByte(2)
      ..write(obj.fromAddress)
      ..writeByte(4)
      ..write(obj.outSymbol)
      ..writeByte(5)
      ..write(obj.outChain)
      ..writeByte(6)
      ..write(obj.outAmount)
      ..writeByte(7)
      ..write(obj.inSymbol)
      ..writeByte(8)
      ..write(obj.inChain)
      ..writeByte(9)
      ..write(obj.inAmount)
      ..writeByte(10)
      ..write(obj.transferFee)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(20)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
