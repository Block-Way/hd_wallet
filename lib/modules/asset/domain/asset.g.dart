// GENERATED CODE - DO NOT MODIFY BY HAND

part of asset_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AssetCoin> _$assetCoinSerializer = new _$AssetCoinSerializer();
Serializer<AssetPrice> _$assetPriceSerializer = new _$AssetPriceSerializer();
Serializer<AssetAddress> _$assetAddressSerializer =
    new _$AssetAddressSerializer();
Serializer<AssetState> _$assetStateSerializer = new _$AssetStateSerializer();

class _$AssetCoinSerializer implements StructuredSerializer<AssetCoin> {
  @override
  final Iterable<Type> types = const [AssetCoin, _$AssetCoin];
  @override
  final String wireName = 'AssetCoin';

  @override
  Iterable<Object?> serialize(Serializers serializers, AssetCoin object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fullName;
    if (value != null) {
      result
        ..add('fullName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.chain;
    if (value != null) {
      result
        ..add('chain')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.symbol;
    if (value != null) {
      result
        ..add('symbol')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.iconOnline;
    if (value != null) {
      result
        ..add('iconOnline')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.iconLocal;
    if (value != null) {
      result
        ..add('iconLocal')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.chainPrecision;
    if (value != null) {
      result
        ..add('chainPrecision')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.displayPrecision;
    if (value != null) {
      result
        ..add('displayPrecision')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.balance;
    if (value != null) {
      result
        ..add('balance')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.balanceUnconfirmed;
    if (value != null) {
      result
        ..add('balanceUnconfirmed')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.balanceUpdateFailed;
    if (value != null) {
      result
        ..add('balanceUpdateFailed')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isEnabled;
    if (value != null) {
      result
        ..add('isEnabled')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isFixed;
    if (value != null) {
      result
        ..add('isFixed')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.contract;
    if (value != null) {
      result
        ..add('contract')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AssetCoin deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AssetCoinBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fullName':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'chain':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'iconOnline':
          result.iconOnline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'iconLocal':
          result.iconLocal = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'chainPrecision':
          result.chainPrecision = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'displayPrecision':
          result.displayPrecision = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'balanceUnconfirmed':
          result.balanceUnconfirmed = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'balanceUpdateFailed':
          result.balanceUpdateFailed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isEnabled':
          result.isEnabled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isFixed':
          result.isFixed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'contract':
          result.contract = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$AssetPriceSerializer implements StructuredSerializer<AssetPrice> {
  @override
  final Iterable<Type> types = const [AssetPrice, _$AssetPrice];
  @override
  final String wireName = 'AssetPrice';

  @override
  Iterable<Object?> serialize(Serializers serializers, AssetPrice object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'tradePairId',
      serializers.serialize(object.tradePairId,
          specifiedType: const FullType(String)),
      'precision',
      serializers.serialize(object.precision,
          specifiedType: const FullType(int)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'price24h',
      serializers.serialize(object.price24h,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  AssetPrice deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AssetPriceBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tradePairId':
          result.tradePairId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'precision':
          result.precision = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'price24h':
          result.price24h = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
      }
    }

    return result.build();
  }
}

class _$AssetAddressSerializer implements StructuredSerializer<AssetAddress> {
  @override
  final Iterable<Type> types = const [AssetAddress, _$AssetAddress];
  @override
  final String wireName = 'AssetAddress';

  @override
  Iterable<Object?> serialize(Serializers serializers, AssetAddress object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.chain;
    if (value != null) {
      result
        ..add('chain')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.comments;
    if (value != null) {
      result
        ..add('comments')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.symbol;
    if (value != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isLocal;
    if (value != null) {
      result
        ..add('isLocal')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  AssetAddress deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AssetAddressBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'chain':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'comments':
          result.comments = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'currency':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isLocal':
          result.isLocal = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$AssetStateSerializer implements StructuredSerializer<AssetState> {
  @override
  final Iterable<Type> types = const [AssetState, _$AssetState];
  @override
  final String wireName = 'AssetState';

  @override
  Iterable<Object?> serialize(Serializers serializers, AssetState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'coins',
      serializers.serialize(object.coins,
          specifiedType:
              const FullType(BuiltList, const [const FullType(AssetCoin)])),
      'hideInvitationShowcase',
      serializers.serialize(object.hideInvitationShowcase,
          specifiedType: const FullType(bool)),
      'hideInvitationNotice',
      serializers.serialize(object.hideInvitationNotice,
          specifiedType: const FullType(bool)),
      'hideSmallAssets',
      serializers.serialize(object.hideSmallAssets,
          specifiedType: const FullType(bool)),
      'isBalanceUpdating',
      serializers.serialize(object.isBalanceUpdating,
          specifiedType: const FullType(bool)),
      'hideDepositShowcase',
      serializers.serialize(object.hideDepositShowcase,
          specifiedType: const FullType(bool)),
      'hideWithdrawShowcase',
      serializers.serialize(object.hideWithdrawShowcase,
          specifiedType: const FullType(bool)),
      'coinsSearchTerm',
      serializers.serialize(object.coinsSearchTerm,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.addressList;
    if (value != null) {
      result
        ..add('addressList')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(AssetAddress)])));
    }
    value = object.addressRequestId;
    if (value != null) {
      result
        ..add('addressRequestId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AssetState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AssetStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'coins':
          result.coins.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AssetCoin)]))!
              as BuiltList<Object?>);
          break;
        case 'hideInvitationShowcase':
          result.hideInvitationShowcase = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideInvitationNotice':
          result.hideInvitationNotice = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideSmallAssets':
          result.hideSmallAssets = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isBalanceUpdating':
          result.isBalanceUpdating = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideDepositShowcase':
          result.hideDepositShowcase = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'hideWithdrawShowcase':
          result.hideWithdrawShowcase = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'coinsSearchTerm':
          result.coinsSearchTerm = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'addressList':
          result.addressList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AssetAddress)]))!
              as BuiltList<Object?>);
          break;
        case 'addressRequestId':
          result.addressRequestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$AssetDepositVM extends AssetDepositVM {
  factory _$AssetDepositVM([void Function(AssetDepositVMBuilder)? updates]) =>
      (new AssetDepositVMBuilder()..update(updates))._build();

  _$AssetDepositVM._() : super._();

  @override
  AssetDepositVM rebuild(void Function(AssetDepositVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetDepositVMBuilder toBuilder() =>
      new AssetDepositVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetDepositVM;
  }

  @override
  int get hashCode {
    return 86203629;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'AssetDepositVM').toString();
  }
}

class AssetDepositVMBuilder
    implements Builder<AssetDepositVM, AssetDepositVMBuilder> {
  _$AssetDepositVM? _$v;

  AssetDepositVMBuilder();

  @override
  void replace(AssetDepositVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetDepositVM;
  }

  @override
  void update(void Function(AssetDepositVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetDepositVM build() => _build();

  _$AssetDepositVM _build() {
    final _$result = _$v ?? new _$AssetDepositVM._();
    replace(_$result);
    return _$result;
  }
}

class _$AssetDetailVM extends AssetDetailVM {
  @override
  final Wallet? activeWallet;
  @override
  final Future<void> Function(AssetCoin coin, bool isRefresh) doLoadDetail;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;

  factory _$AssetDetailVM([void Function(AssetDetailVMBuilder)? updates]) =>
      (new AssetDetailVMBuilder()..update(updates))._build();

  _$AssetDetailVM._(
      {this.activeWallet,
      required this.doLoadDetail,
      required this.doUnlockWallet})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        doLoadDetail, r'AssetDetailVM', 'doLoadDetail');
    BuiltValueNullFieldError.checkNotNull(
        doUnlockWallet, r'AssetDetailVM', 'doUnlockWallet');
  }

  @override
  AssetDetailVM rebuild(void Function(AssetDetailVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetDetailVMBuilder toBuilder() => new AssetDetailVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetDetailVM && activeWallet == other.activeWallet;
  }

  @override
  int get hashCode {
    return $jf($jc(0, activeWallet.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetDetailVM')
          ..add('activeWallet', activeWallet)
          ..add('doLoadDetail', doLoadDetail)
          ..add('doUnlockWallet', doUnlockWallet))
        .toString();
  }
}

class AssetDetailVMBuilder
    implements Builder<AssetDetailVM, AssetDetailVMBuilder> {
  _$AssetDetailVM? _$v;

  Wallet? _activeWallet;
  Wallet? get activeWallet => _$this._activeWallet;
  set activeWallet(Wallet? activeWallet) => _$this._activeWallet = activeWallet;

  Future<void> Function(AssetCoin coin, bool isRefresh)? _doLoadDetail;
  Future<void> Function(AssetCoin coin, bool isRefresh)? get doLoadDetail =>
      _$this._doLoadDetail;
  set doLoadDetail(
          Future<void> Function(AssetCoin coin, bool isRefresh)?
              doLoadDetail) =>
      _$this._doLoadDetail = doLoadDetail;

  Future<WalletPrivateData> Function(String password)? _doUnlockWallet;
  Future<WalletPrivateData> Function(String password)? get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password)?
              doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  AssetDetailVMBuilder();

  AssetDetailVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _activeWallet = $v.activeWallet;
      _doLoadDetail = $v.doLoadDetail;
      _doUnlockWallet = $v.doUnlockWallet;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetDetailVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetDetailVM;
  }

  @override
  void update(void Function(AssetDetailVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetDetailVM build() => _build();

  _$AssetDetailVM _build() {
    final _$result = _$v ??
        new _$AssetDetailVM._(
            activeWallet: activeWallet,
            doLoadDetail: BuiltValueNullFieldError.checkNotNull(
                doLoadDetail, r'AssetDetailVM', 'doLoadDetail'),
            doUnlockWallet: BuiltValueNullFieldError.checkNotNull(
                doUnlockWallet, r'AssetDetailVM', 'doUnlockWallet'));
    replace(_$result);
    return _$result;
  }
}

class _$AssetAddressVM extends AssetAddressVM {
  @override
  final BuiltList<AssetAddress>? addressList;
  @override
  final Future<int> Function(
      {required AssetCoin coin,
      required String requestId,
      required bool isLocal}) loadAddressList;
  @override
  final void Function() clearAddressList;
  @override
  final Future<void> Function(AssetCoin coin, AssetAddress address)
      submitAddressAdd;
  @override
  final Future<void> Function(AssetCoin coin, AssetAddress address)
      submitAddressDelete;
  @override
  final Future<bool> Function({required String chain, required String address})
      validateAddress;

  factory _$AssetAddressVM([void Function(AssetAddressVMBuilder)? updates]) =>
      (new AssetAddressVMBuilder()..update(updates))._build();

  _$AssetAddressVM._(
      {this.addressList,
      required this.loadAddressList,
      required this.clearAddressList,
      required this.submitAddressAdd,
      required this.submitAddressDelete,
      required this.validateAddress})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        loadAddressList, r'AssetAddressVM', 'loadAddressList');
    BuiltValueNullFieldError.checkNotNull(
        clearAddressList, r'AssetAddressVM', 'clearAddressList');
    BuiltValueNullFieldError.checkNotNull(
        submitAddressAdd, r'AssetAddressVM', 'submitAddressAdd');
    BuiltValueNullFieldError.checkNotNull(
        submitAddressDelete, r'AssetAddressVM', 'submitAddressDelete');
    BuiltValueNullFieldError.checkNotNull(
        validateAddress, r'AssetAddressVM', 'validateAddress');
  }

  @override
  AssetAddressVM rebuild(void Function(AssetAddressVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetAddressVMBuilder toBuilder() =>
      new AssetAddressVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetAddressVM && addressList == other.addressList;
  }

  @override
  int get hashCode {
    return $jf($jc(0, addressList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetAddressVM')
          ..add('addressList', addressList)
          ..add('loadAddressList', loadAddressList)
          ..add('clearAddressList', clearAddressList)
          ..add('submitAddressAdd', submitAddressAdd)
          ..add('submitAddressDelete', submitAddressDelete)
          ..add('validateAddress', validateAddress))
        .toString();
  }
}

class AssetAddressVMBuilder
    implements Builder<AssetAddressVM, AssetAddressVMBuilder> {
  _$AssetAddressVM? _$v;

  ListBuilder<AssetAddress>? _addressList;
  ListBuilder<AssetAddress> get addressList =>
      _$this._addressList ??= new ListBuilder<AssetAddress>();
  set addressList(ListBuilder<AssetAddress>? addressList) =>
      _$this._addressList = addressList;

  Future<int> Function(
      {required AssetCoin coin,
      required String requestId,
      required bool isLocal})? _loadAddressList;
  Future<int> Function(
      {required AssetCoin coin,
      required String requestId,
      required bool isLocal})? get loadAddressList => _$this._loadAddressList;
  set loadAddressList(
          Future<int> Function(
                  {required AssetCoin coin,
                  required String requestId,
                  required bool isLocal})?
              loadAddressList) =>
      _$this._loadAddressList = loadAddressList;

  void Function()? _clearAddressList;
  void Function()? get clearAddressList => _$this._clearAddressList;
  set clearAddressList(void Function()? clearAddressList) =>
      _$this._clearAddressList = clearAddressList;

  Future<void> Function(AssetCoin coin, AssetAddress address)?
      _submitAddressAdd;
  Future<void> Function(AssetCoin coin, AssetAddress address)?
      get submitAddressAdd => _$this._submitAddressAdd;
  set submitAddressAdd(
          Future<void> Function(AssetCoin coin, AssetAddress address)?
              submitAddressAdd) =>
      _$this._submitAddressAdd = submitAddressAdd;

  Future<void> Function(AssetCoin coin, AssetAddress address)?
      _submitAddressDelete;
  Future<void> Function(AssetCoin coin, AssetAddress address)?
      get submitAddressDelete => _$this._submitAddressDelete;
  set submitAddressDelete(
          Future<void> Function(AssetCoin coin, AssetAddress address)?
              submitAddressDelete) =>
      _$this._submitAddressDelete = submitAddressDelete;

  Future<bool> Function({required String chain, required String address})?
      _validateAddress;
  Future<bool> Function({required String chain, required String address})?
      get validateAddress => _$this._validateAddress;
  set validateAddress(
          Future<bool> Function(
                  {required String chain, required String address})?
              validateAddress) =>
      _$this._validateAddress = validateAddress;

  AssetAddressVMBuilder();

  AssetAddressVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _addressList = $v.addressList?.toBuilder();
      _loadAddressList = $v.loadAddressList;
      _clearAddressList = $v.clearAddressList;
      _submitAddressAdd = $v.submitAddressAdd;
      _submitAddressDelete = $v.submitAddressDelete;
      _validateAddress = $v.validateAddress;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetAddressVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetAddressVM;
  }

  @override
  void update(void Function(AssetAddressVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetAddressVM build() => _build();

  _$AssetAddressVM _build() {
    _$AssetAddressVM _$result;
    try {
      _$result = _$v ??
          new _$AssetAddressVM._(
              addressList: _addressList?.build(),
              loadAddressList: BuiltValueNullFieldError.checkNotNull(
                  loadAddressList, r'AssetAddressVM', 'loadAddressList'),
              clearAddressList: BuiltValueNullFieldError.checkNotNull(
                  clearAddressList, r'AssetAddressVM', 'clearAddressList'),
              submitAddressAdd: BuiltValueNullFieldError.checkNotNull(
                  submitAddressAdd, r'AssetAddressVM', 'submitAddressAdd'),
              submitAddressDelete: BuiltValueNullFieldError.checkNotNull(
                  submitAddressDelete,
                  r'AssetAddressVM',
                  'submitAddressDelete'),
              validateAddress: BuiltValueNullFieldError.checkNotNull(
                  validateAddress, r'AssetAddressVM', 'validateAddress'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'addressList';
        _addressList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AssetAddressVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AssetListVM extends AssetListVM {
  @override
  final String fiatCurrency;
  @override
  final BuiltList<AssetCoin> coins;
  @override
  final bool isBalanceUpdating;
  @override
  final List<Wallet> wallets;
  @override
  final bool? hasWallet;
  @override
  final Wallet? activeWallet;
  @override
  final String activeWalletId;
  @override
  final WalletStatus activeWalletStatus;
  @override
  final Future<void> Function() doRefreshList;
  @override
  final Future<void> Function(Wallet wallet) doSwitchWallet;
  @override
  final Future<void> Function(Wallet wallet) doSyncWallet;
  @override
  final void Function(bool hide) doHideSmallAssets;

  factory _$AssetListVM([void Function(AssetListVMBuilder)? updates]) =>
      (new AssetListVMBuilder()..update(updates))._build();

  _$AssetListVM._(
      {required this.fiatCurrency,
      required this.coins,
      required this.isBalanceUpdating,
      required this.wallets,
      this.hasWallet,
      this.activeWallet,
      required this.activeWalletId,
      required this.activeWalletStatus,
      required this.doRefreshList,
      required this.doSwitchWallet,
      required this.doSyncWallet,
      required this.doHideSmallAssets})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        fiatCurrency, r'AssetListVM', 'fiatCurrency');
    BuiltValueNullFieldError.checkNotNull(coins, r'AssetListVM', 'coins');
    BuiltValueNullFieldError.checkNotNull(
        isBalanceUpdating, r'AssetListVM', 'isBalanceUpdating');
    BuiltValueNullFieldError.checkNotNull(wallets, r'AssetListVM', 'wallets');
    BuiltValueNullFieldError.checkNotNull(
        activeWalletId, r'AssetListVM', 'activeWalletId');
    BuiltValueNullFieldError.checkNotNull(
        activeWalletStatus, r'AssetListVM', 'activeWalletStatus');
    BuiltValueNullFieldError.checkNotNull(
        doRefreshList, r'AssetListVM', 'doRefreshList');
    BuiltValueNullFieldError.checkNotNull(
        doSwitchWallet, r'AssetListVM', 'doSwitchWallet');
    BuiltValueNullFieldError.checkNotNull(
        doSyncWallet, r'AssetListVM', 'doSyncWallet');
    BuiltValueNullFieldError.checkNotNull(
        doHideSmallAssets, r'AssetListVM', 'doHideSmallAssets');
  }

  @override
  AssetListVM rebuild(void Function(AssetListVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetListVMBuilder toBuilder() => new AssetListVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetListVM &&
        fiatCurrency == other.fiatCurrency &&
        coins == other.coins &&
        isBalanceUpdating == other.isBalanceUpdating &&
        wallets == other.wallets &&
        hasWallet == other.hasWallet &&
        activeWallet == other.activeWallet &&
        activeWalletId == other.activeWalletId &&
        activeWalletStatus == other.activeWalletStatus;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, fiatCurrency.hashCode), coins.hashCode),
                            isBalanceUpdating.hashCode),
                        wallets.hashCode),
                    hasWallet.hashCode),
                activeWallet.hashCode),
            activeWalletId.hashCode),
        activeWalletStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetListVM')
          ..add('fiatCurrency', fiatCurrency)
          ..add('coins', coins)
          ..add('isBalanceUpdating', isBalanceUpdating)
          ..add('wallets', wallets)
          ..add('hasWallet', hasWallet)
          ..add('activeWallet', activeWallet)
          ..add('activeWalletId', activeWalletId)
          ..add('activeWalletStatus', activeWalletStatus)
          ..add('doRefreshList', doRefreshList)
          ..add('doSwitchWallet', doSwitchWallet)
          ..add('doSyncWallet', doSyncWallet)
          ..add('doHideSmallAssets', doHideSmallAssets))
        .toString();
  }
}

class AssetListVMBuilder implements Builder<AssetListVM, AssetListVMBuilder> {
  _$AssetListVM? _$v;

  String? _fiatCurrency;
  String? get fiatCurrency => _$this._fiatCurrency;
  set fiatCurrency(String? fiatCurrency) => _$this._fiatCurrency = fiatCurrency;

  ListBuilder<AssetCoin>? _coins;
  ListBuilder<AssetCoin> get coins =>
      _$this._coins ??= new ListBuilder<AssetCoin>();
  set coins(ListBuilder<AssetCoin>? coins) => _$this._coins = coins;

  bool? _isBalanceUpdating;
  bool? get isBalanceUpdating => _$this._isBalanceUpdating;
  set isBalanceUpdating(bool? isBalanceUpdating) =>
      _$this._isBalanceUpdating = isBalanceUpdating;

  List<Wallet>? _wallets;
  List<Wallet>? get wallets => _$this._wallets;
  set wallets(List<Wallet>? wallets) => _$this._wallets = wallets;

  bool? _hasWallet;
  bool? get hasWallet => _$this._hasWallet;
  set hasWallet(bool? hasWallet) => _$this._hasWallet = hasWallet;

  Wallet? _activeWallet;
  Wallet? get activeWallet => _$this._activeWallet;
  set activeWallet(Wallet? activeWallet) => _$this._activeWallet = activeWallet;

  String? _activeWalletId;
  String? get activeWalletId => _$this._activeWalletId;
  set activeWalletId(String? activeWalletId) =>
      _$this._activeWalletId = activeWalletId;

  WalletStatus? _activeWalletStatus;
  WalletStatus? get activeWalletStatus => _$this._activeWalletStatus;
  set activeWalletStatus(WalletStatus? activeWalletStatus) =>
      _$this._activeWalletStatus = activeWalletStatus;

  Future<void> Function()? _doRefreshList;
  Future<void> Function()? get doRefreshList => _$this._doRefreshList;
  set doRefreshList(Future<void> Function()? doRefreshList) =>
      _$this._doRefreshList = doRefreshList;

  Future<void> Function(Wallet wallet)? _doSwitchWallet;
  Future<void> Function(Wallet wallet)? get doSwitchWallet =>
      _$this._doSwitchWallet;
  set doSwitchWallet(Future<void> Function(Wallet wallet)? doSwitchWallet) =>
      _$this._doSwitchWallet = doSwitchWallet;

  Future<void> Function(Wallet wallet)? _doSyncWallet;
  Future<void> Function(Wallet wallet)? get doSyncWallet =>
      _$this._doSyncWallet;
  set doSyncWallet(Future<void> Function(Wallet wallet)? doSyncWallet) =>
      _$this._doSyncWallet = doSyncWallet;

  void Function(bool hide)? _doHideSmallAssets;
  void Function(bool hide)? get doHideSmallAssets => _$this._doHideSmallAssets;
  set doHideSmallAssets(void Function(bool hide)? doHideSmallAssets) =>
      _$this._doHideSmallAssets = doHideSmallAssets;

  AssetListVMBuilder();

  AssetListVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fiatCurrency = $v.fiatCurrency;
      _coins = $v.coins.toBuilder();
      _isBalanceUpdating = $v.isBalanceUpdating;
      _wallets = $v.wallets;
      _hasWallet = $v.hasWallet;
      _activeWallet = $v.activeWallet;
      _activeWalletId = $v.activeWalletId;
      _activeWalletStatus = $v.activeWalletStatus;
      _doRefreshList = $v.doRefreshList;
      _doSwitchWallet = $v.doSwitchWallet;
      _doSyncWallet = $v.doSyncWallet;
      _doHideSmallAssets = $v.doHideSmallAssets;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetListVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetListVM;
  }

  @override
  void update(void Function(AssetListVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetListVM build() => _build();

  _$AssetListVM _build() {
    _$AssetListVM _$result;
    try {
      _$result = _$v ??
          new _$AssetListVM._(
              fiatCurrency: BuiltValueNullFieldError.checkNotNull(
                  fiatCurrency, r'AssetListVM', 'fiatCurrency'),
              coins: coins.build(),
              isBalanceUpdating: BuiltValueNullFieldError.checkNotNull(
                  isBalanceUpdating, r'AssetListVM', 'isBalanceUpdating'),
              wallets: BuiltValueNullFieldError.checkNotNull(
                  wallets, r'AssetListVM', 'wallets'),
              hasWallet: hasWallet,
              activeWallet: activeWallet,
              activeWalletId: BuiltValueNullFieldError.checkNotNull(
                  activeWalletId, r'AssetListVM', 'activeWalletId'),
              activeWalletStatus: BuiltValueNullFieldError.checkNotNull(
                  activeWalletStatus, r'AssetListVM', 'activeWalletStatus'),
              doRefreshList: BuiltValueNullFieldError.checkNotNull(
                  doRefreshList, r'AssetListVM', 'doRefreshList'),
              doSwitchWallet: BuiltValueNullFieldError.checkNotNull(
                  doSwitchWallet, r'AssetListVM', 'doSwitchWallet'),
              doSyncWallet: BuiltValueNullFieldError.checkNotNull(
                  doSyncWallet, r'AssetListVM', 'doSyncWallet'),
              doHideSmallAssets: BuiltValueNullFieldError.checkNotNull(doHideSmallAssets, r'AssetListVM', 'doHideSmallAssets'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coins';
        coins.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AssetListVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AssetManagementVM extends AssetManagementVM {
  @override
  final List<AssetCoin> coinsEnabled;
  @override
  final List<AssetCoin> coinsDisabled;
  @override
  final void Function(AssetCoin coin, bool isEnabled) doToggleCoin;
  @override
  final void Function(String term) doSearchCoin;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;
  @override
  final Future<bool> Function(WalletPrivateData data, String chain)
      updateCoinAddress;

  factory _$AssetManagementVM(
          [void Function(AssetManagementVMBuilder)? updates]) =>
      (new AssetManagementVMBuilder()..update(updates))._build();

  _$AssetManagementVM._(
      {required this.coinsEnabled,
      required this.coinsDisabled,
      required this.doToggleCoin,
      required this.doSearchCoin,
      required this.doUnlockWallet,
      required this.updateCoinAddress})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        coinsEnabled, r'AssetManagementVM', 'coinsEnabled');
    BuiltValueNullFieldError.checkNotNull(
        coinsDisabled, r'AssetManagementVM', 'coinsDisabled');
    BuiltValueNullFieldError.checkNotNull(
        doToggleCoin, r'AssetManagementVM', 'doToggleCoin');
    BuiltValueNullFieldError.checkNotNull(
        doSearchCoin, r'AssetManagementVM', 'doSearchCoin');
    BuiltValueNullFieldError.checkNotNull(
        doUnlockWallet, r'AssetManagementVM', 'doUnlockWallet');
    BuiltValueNullFieldError.checkNotNull(
        updateCoinAddress, r'AssetManagementVM', 'updateCoinAddress');
  }

  @override
  AssetManagementVM rebuild(void Function(AssetManagementVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetManagementVMBuilder toBuilder() =>
      new AssetManagementVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetManagementVM &&
        coinsEnabled == other.coinsEnabled &&
        coinsDisabled == other.coinsDisabled;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, coinsEnabled.hashCode), coinsDisabled.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetManagementVM')
          ..add('coinsEnabled', coinsEnabled)
          ..add('coinsDisabled', coinsDisabled)
          ..add('doToggleCoin', doToggleCoin)
          ..add('doSearchCoin', doSearchCoin)
          ..add('doUnlockWallet', doUnlockWallet)
          ..add('updateCoinAddress', updateCoinAddress))
        .toString();
  }
}

class AssetManagementVMBuilder
    implements Builder<AssetManagementVM, AssetManagementVMBuilder> {
  _$AssetManagementVM? _$v;

  List<AssetCoin>? _coinsEnabled;
  List<AssetCoin>? get coinsEnabled => _$this._coinsEnabled;
  set coinsEnabled(List<AssetCoin>? coinsEnabled) =>
      _$this._coinsEnabled = coinsEnabled;

  List<AssetCoin>? _coinsDisabled;
  List<AssetCoin>? get coinsDisabled => _$this._coinsDisabled;
  set coinsDisabled(List<AssetCoin>? coinsDisabled) =>
      _$this._coinsDisabled = coinsDisabled;

  void Function(AssetCoin coin, bool isEnabled)? _doToggleCoin;
  void Function(AssetCoin coin, bool isEnabled)? get doToggleCoin =>
      _$this._doToggleCoin;
  set doToggleCoin(
          void Function(AssetCoin coin, bool isEnabled)? doToggleCoin) =>
      _$this._doToggleCoin = doToggleCoin;

  void Function(String term)? _doSearchCoin;
  void Function(String term)? get doSearchCoin => _$this._doSearchCoin;
  set doSearchCoin(void Function(String term)? doSearchCoin) =>
      _$this._doSearchCoin = doSearchCoin;

  Future<WalletPrivateData> Function(String password)? _doUnlockWallet;
  Future<WalletPrivateData> Function(String password)? get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password)?
              doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  Future<bool> Function(WalletPrivateData data, String chain)?
      _updateCoinAddress;
  Future<bool> Function(WalletPrivateData data, String chain)?
      get updateCoinAddress => _$this._updateCoinAddress;
  set updateCoinAddress(
          Future<bool> Function(WalletPrivateData data, String chain)?
              updateCoinAddress) =>
      _$this._updateCoinAddress = updateCoinAddress;

  AssetManagementVMBuilder();

  AssetManagementVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coinsEnabled = $v.coinsEnabled;
      _coinsDisabled = $v.coinsDisabled;
      _doToggleCoin = $v.doToggleCoin;
      _doSearchCoin = $v.doSearchCoin;
      _doUnlockWallet = $v.doUnlockWallet;
      _updateCoinAddress = $v.updateCoinAddress;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetManagementVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetManagementVM;
  }

  @override
  void update(void Function(AssetManagementVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetManagementVM build() => _build();

  _$AssetManagementVM _build() {
    final _$result = _$v ??
        new _$AssetManagementVM._(
            coinsEnabled: BuiltValueNullFieldError.checkNotNull(
                coinsEnabled, r'AssetManagementVM', 'coinsEnabled'),
            coinsDisabled: BuiltValueNullFieldError.checkNotNull(
                coinsDisabled, r'AssetManagementVM', 'coinsDisabled'),
            doToggleCoin: BuiltValueNullFieldError.checkNotNull(
                doToggleCoin, r'AssetManagementVM', 'doToggleCoin'),
            doSearchCoin: BuiltValueNullFieldError.checkNotNull(
                doSearchCoin, r'AssetManagementVM', 'doSearchCoin'),
            doUnlockWallet: BuiltValueNullFieldError.checkNotNull(
                doUnlockWallet, r'AssetManagementVM', 'doUnlockWallet'),
            updateCoinAddress: BuiltValueNullFieldError.checkNotNull(
                updateCoinAddress, r'AssetManagementVM', 'updateCoinAddress'));
    replace(_$result);
    return _$result;
  }
}

class _$AssetTransactionVM extends AssetTransactionVM {
  @override
  final String Function(String chain, String symbol) getCoinName;
  @override
  final Future<Transaction> Function(Transaction transaction)
      getSingleTransaction;

  factory _$AssetTransactionVM(
          [void Function(AssetTransactionVMBuilder)? updates]) =>
      (new AssetTransactionVMBuilder()..update(updates))._build();

  _$AssetTransactionVM._(
      {required this.getCoinName, required this.getSingleTransaction})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        getCoinName, r'AssetTransactionVM', 'getCoinName');
    BuiltValueNullFieldError.checkNotNull(
        getSingleTransaction, r'AssetTransactionVM', 'getSingleTransaction');
  }

  @override
  AssetTransactionVM rebuild(
          void Function(AssetTransactionVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetTransactionVMBuilder toBuilder() =>
      new AssetTransactionVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetTransactionVM;
  }

  @override
  int get hashCode {
    return 952905995;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetTransactionVM')
          ..add('getCoinName', getCoinName)
          ..add('getSingleTransaction', getSingleTransaction))
        .toString();
  }
}

class AssetTransactionVMBuilder
    implements Builder<AssetTransactionVM, AssetTransactionVMBuilder> {
  _$AssetTransactionVM? _$v;

  String Function(String chain, String symbol)? _getCoinName;
  String Function(String chain, String symbol)? get getCoinName =>
      _$this._getCoinName;
  set getCoinName(String Function(String chain, String symbol)? getCoinName) =>
      _$this._getCoinName = getCoinName;

  Future<Transaction> Function(Transaction transaction)? _getSingleTransaction;
  Future<Transaction> Function(Transaction transaction)?
      get getSingleTransaction => _$this._getSingleTransaction;
  set getSingleTransaction(
          Future<Transaction> Function(Transaction transaction)?
              getSingleTransaction) =>
      _$this._getSingleTransaction = getSingleTransaction;

  AssetTransactionVMBuilder();

  AssetTransactionVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _getCoinName = $v.getCoinName;
      _getSingleTransaction = $v.getSingleTransaction;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetTransactionVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetTransactionVM;
  }

  @override
  void update(void Function(AssetTransactionVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetTransactionVM build() => _build();

  _$AssetTransactionVM _build() {
    final _$result = _$v ??
        new _$AssetTransactionVM._(
            getCoinName: BuiltValueNullFieldError.checkNotNull(
                getCoinName, r'AssetTransactionVM', 'getCoinName'),
            getSingleTransaction: BuiltValueNullFieldError.checkNotNull(
                getSingleTransaction,
                r'AssetTransactionVM',
                'getSingleTransaction'));
    replace(_$result);
    return _$result;
  }
}

class _$AssetWithdrawVM extends AssetWithdrawVM {
  @override
  final bool hideDepositShowcase;
  @override
  final bool hideWithdrawShowcase;
  @override
  final Future<WalletWithdrawData> Function(
          WithdrawBeforeParams params, WalletWithdrawData previousData)
      onWithdrawBefore;
  @override
  final Future<String> Function(
      WithdrawSubmitParams params, WalletPrivateData walletData,
      [Future<bool> Function() onFinalCheck]) submit;
  @override
  final double Function({required String chain, required String symbol})
      getCoinBalance;
  @override
  final AssetCoin Function({required String chain, required String symbol})
      getCoinInfo;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;

  factory _$AssetWithdrawVM([void Function(AssetWithdrawVMBuilder)? updates]) =>
      (new AssetWithdrawVMBuilder()..update(updates))._build();

  _$AssetWithdrawVM._(
      {required this.hideDepositShowcase,
      required this.hideWithdrawShowcase,
      required this.onWithdrawBefore,
      required this.submit,
      required this.getCoinBalance,
      required this.getCoinInfo,
      required this.doUnlockWallet})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        hideDepositShowcase, r'AssetWithdrawVM', 'hideDepositShowcase');
    BuiltValueNullFieldError.checkNotNull(
        hideWithdrawShowcase, r'AssetWithdrawVM', 'hideWithdrawShowcase');
    BuiltValueNullFieldError.checkNotNull(
        onWithdrawBefore, r'AssetWithdrawVM', 'onWithdrawBefore');
    BuiltValueNullFieldError.checkNotNull(submit, r'AssetWithdrawVM', 'submit');
    BuiltValueNullFieldError.checkNotNull(
        getCoinBalance, r'AssetWithdrawVM', 'getCoinBalance');
    BuiltValueNullFieldError.checkNotNull(
        getCoinInfo, r'AssetWithdrawVM', 'getCoinInfo');
    BuiltValueNullFieldError.checkNotNull(
        doUnlockWallet, r'AssetWithdrawVM', 'doUnlockWallet');
  }

  @override
  AssetWithdrawVM rebuild(void Function(AssetWithdrawVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetWithdrawVMBuilder toBuilder() =>
      new AssetWithdrawVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetWithdrawVM &&
        hideDepositShowcase == other.hideDepositShowcase &&
        hideWithdrawShowcase == other.hideWithdrawShowcase;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(0, hideDepositShowcase.hashCode), hideWithdrawShowcase.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetWithdrawVM')
          ..add('hideDepositShowcase', hideDepositShowcase)
          ..add('hideWithdrawShowcase', hideWithdrawShowcase)
          ..add('onWithdrawBefore', onWithdrawBefore)
          ..add('submit', submit)
          ..add('getCoinBalance', getCoinBalance)
          ..add('getCoinInfo', getCoinInfo)
          ..add('doUnlockWallet', doUnlockWallet))
        .toString();
  }
}

class AssetWithdrawVMBuilder
    implements Builder<AssetWithdrawVM, AssetWithdrawVMBuilder> {
  _$AssetWithdrawVM? _$v;

  bool? _hideDepositShowcase;
  bool? get hideDepositShowcase => _$this._hideDepositShowcase;
  set hideDepositShowcase(bool? hideDepositShowcase) =>
      _$this._hideDepositShowcase = hideDepositShowcase;

  bool? _hideWithdrawShowcase;
  bool? get hideWithdrawShowcase => _$this._hideWithdrawShowcase;
  set hideWithdrawShowcase(bool? hideWithdrawShowcase) =>
      _$this._hideWithdrawShowcase = hideWithdrawShowcase;

  Future<WalletWithdrawData> Function(
          WithdrawBeforeParams params, WalletWithdrawData previousData)?
      _onWithdrawBefore;
  Future<WalletWithdrawData> Function(
          WithdrawBeforeParams params, WalletWithdrawData previousData)?
      get onWithdrawBefore => _$this._onWithdrawBefore;
  set onWithdrawBefore(
          Future<WalletWithdrawData> Function(
                  WithdrawBeforeParams params, WalletWithdrawData previousData)?
              onWithdrawBefore) =>
      _$this._onWithdrawBefore = onWithdrawBefore;

  Future<String> Function(
      WithdrawSubmitParams params, WalletPrivateData walletData,
      [Future<bool> Function() onFinalCheck])? _submit;
  Future<String> Function(
      WithdrawSubmitParams params, WalletPrivateData walletData,
      [Future<bool> Function() onFinalCheck])? get submit => _$this._submit;
  set submit(
          Future<String> Function(
                  WithdrawSubmitParams params, WalletPrivateData walletData,
                  [Future<bool> Function() onFinalCheck])?
              submit) =>
      _$this._submit = submit;

  double Function({required String chain, required String symbol})?
      _getCoinBalance;
  double Function({required String chain, required String symbol})?
      get getCoinBalance => _$this._getCoinBalance;
  set getCoinBalance(
          double Function({required String chain, required String symbol})?
              getCoinBalance) =>
      _$this._getCoinBalance = getCoinBalance;

  AssetCoin Function({required String chain, required String symbol})?
      _getCoinInfo;
  AssetCoin Function({required String chain, required String symbol})?
      get getCoinInfo => _$this._getCoinInfo;
  set getCoinInfo(
          AssetCoin Function({required String chain, required String symbol})?
              getCoinInfo) =>
      _$this._getCoinInfo = getCoinInfo;

  Future<WalletPrivateData> Function(String password)? _doUnlockWallet;
  Future<WalletPrivateData> Function(String password)? get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password)?
              doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  AssetWithdrawVMBuilder();

  AssetWithdrawVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hideDepositShowcase = $v.hideDepositShowcase;
      _hideWithdrawShowcase = $v.hideWithdrawShowcase;
      _onWithdrawBefore = $v.onWithdrawBefore;
      _submit = $v.submit;
      _getCoinBalance = $v.getCoinBalance;
      _getCoinInfo = $v.getCoinInfo;
      _doUnlockWallet = $v.doUnlockWallet;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetWithdrawVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetWithdrawVM;
  }

  @override
  void update(void Function(AssetWithdrawVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetWithdrawVM build() => _build();

  _$AssetWithdrawVM _build() {
    final _$result = _$v ??
        new _$AssetWithdrawVM._(
            hideDepositShowcase: BuiltValueNullFieldError.checkNotNull(
                hideDepositShowcase, r'AssetWithdrawVM', 'hideDepositShowcase'),
            hideWithdrawShowcase: BuiltValueNullFieldError.checkNotNull(
                hideWithdrawShowcase,
                r'AssetWithdrawVM',
                'hideWithdrawShowcase'),
            onWithdrawBefore: BuiltValueNullFieldError.checkNotNull(
                onWithdrawBefore, r'AssetWithdrawVM', 'onWithdrawBefore'),
            submit: BuiltValueNullFieldError.checkNotNull(
                submit, r'AssetWithdrawVM', 'submit'),
            getCoinBalance: BuiltValueNullFieldError.checkNotNull(
                getCoinBalance, r'AssetWithdrawVM', 'getCoinBalance'),
            getCoinInfo: BuiltValueNullFieldError.checkNotNull(
                getCoinInfo, r'AssetWithdrawVM', 'getCoinInfo'),
            doUnlockWallet: BuiltValueNullFieldError.checkNotNull(
                doUnlockWallet, r'AssetWithdrawVM', 'doUnlockWallet'));
    replace(_$result);
    return _$result;
  }
}

class _$AssetCoin extends AssetCoin {
  @override
  final String? name;
  @override
  final String? fullName;
  @override
  final String? chain;
  @override
  final String? symbol;
  @override
  final String? address;
  @override
  final String? iconOnline;
  @override
  final String? iconLocal;
  @override
  final int? chainPrecision;
  @override
  final int? displayPrecision;
  @override
  final double? balance;
  @override
  final double? balanceUnconfirmed;
  @override
  final bool? balanceUpdateFailed;
  @override
  final bool? isEnabled;
  @override
  final bool? isFixed;
  @override
  final String? contract;

  factory _$AssetCoin([void Function(AssetCoinBuilder)? updates]) =>
      (new AssetCoinBuilder()..update(updates))._build();

  _$AssetCoin._(
      {this.name,
      this.fullName,
      this.chain,
      this.symbol,
      this.address,
      this.iconOnline,
      this.iconLocal,
      this.chainPrecision,
      this.displayPrecision,
      this.balance,
      this.balanceUnconfirmed,
      this.balanceUpdateFailed,
      this.isEnabled,
      this.isFixed,
      this.contract})
      : super._();

  @override
  AssetCoin rebuild(void Function(AssetCoinBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetCoinBuilder toBuilder() => new AssetCoinBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetCoin &&
        name == other.name &&
        fullName == other.fullName &&
        chain == other.chain &&
        symbol == other.symbol &&
        address == other.address &&
        iconOnline == other.iconOnline &&
        iconLocal == other.iconLocal &&
        chainPrecision == other.chainPrecision &&
        displayPrecision == other.displayPrecision &&
        balance == other.balance &&
        balanceUnconfirmed == other.balanceUnconfirmed &&
        balanceUpdateFailed == other.balanceUpdateFailed &&
        isEnabled == other.isEnabled &&
        isFixed == other.isFixed &&
        contract == other.contract;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(0,
                                                                name.hashCode),
                                                            fullName.hashCode),
                                                        chain.hashCode),
                                                    symbol.hashCode),
                                                address.hashCode),
                                            iconOnline.hashCode),
                                        iconLocal.hashCode),
                                    chainPrecision.hashCode),
                                displayPrecision.hashCode),
                            balance.hashCode),
                        balanceUnconfirmed.hashCode),
                    balanceUpdateFailed.hashCode),
                isEnabled.hashCode),
            isFixed.hashCode),
        contract.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetCoin')
          ..add('name', name)
          ..add('fullName', fullName)
          ..add('chain', chain)
          ..add('symbol', symbol)
          ..add('address', address)
          ..add('iconOnline', iconOnline)
          ..add('iconLocal', iconLocal)
          ..add('chainPrecision', chainPrecision)
          ..add('displayPrecision', displayPrecision)
          ..add('balance', balance)
          ..add('balanceUnconfirmed', balanceUnconfirmed)
          ..add('balanceUpdateFailed', balanceUpdateFailed)
          ..add('isEnabled', isEnabled)
          ..add('isFixed', isFixed)
          ..add('contract', contract))
        .toString();
  }
}

class AssetCoinBuilder implements Builder<AssetCoin, AssetCoinBuilder> {
  _$AssetCoin? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(String? chain) => _$this._chain = chain;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _iconOnline;
  String? get iconOnline => _$this._iconOnline;
  set iconOnline(String? iconOnline) => _$this._iconOnline = iconOnline;

  String? _iconLocal;
  String? get iconLocal => _$this._iconLocal;
  set iconLocal(String? iconLocal) => _$this._iconLocal = iconLocal;

  int? _chainPrecision;
  int? get chainPrecision => _$this._chainPrecision;
  set chainPrecision(int? chainPrecision) =>
      _$this._chainPrecision = chainPrecision;

  int? _displayPrecision;
  int? get displayPrecision => _$this._displayPrecision;
  set displayPrecision(int? displayPrecision) =>
      _$this._displayPrecision = displayPrecision;

  double? _balance;
  double? get balance => _$this._balance;
  set balance(double? balance) => _$this._balance = balance;

  double? _balanceUnconfirmed;
  double? get balanceUnconfirmed => _$this._balanceUnconfirmed;
  set balanceUnconfirmed(double? balanceUnconfirmed) =>
      _$this._balanceUnconfirmed = balanceUnconfirmed;

  bool? _balanceUpdateFailed;
  bool? get balanceUpdateFailed => _$this._balanceUpdateFailed;
  set balanceUpdateFailed(bool? balanceUpdateFailed) =>
      _$this._balanceUpdateFailed = balanceUpdateFailed;

  bool? _isEnabled;
  bool? get isEnabled => _$this._isEnabled;
  set isEnabled(bool? isEnabled) => _$this._isEnabled = isEnabled;

  bool? _isFixed;
  bool? get isFixed => _$this._isFixed;
  set isFixed(bool? isFixed) => _$this._isFixed = isFixed;

  String? _contract;
  String? get contract => _$this._contract;
  set contract(String? contract) => _$this._contract = contract;

  AssetCoinBuilder();

  AssetCoinBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _fullName = $v.fullName;
      _chain = $v.chain;
      _symbol = $v.symbol;
      _address = $v.address;
      _iconOnline = $v.iconOnline;
      _iconLocal = $v.iconLocal;
      _chainPrecision = $v.chainPrecision;
      _displayPrecision = $v.displayPrecision;
      _balance = $v.balance;
      _balanceUnconfirmed = $v.balanceUnconfirmed;
      _balanceUpdateFailed = $v.balanceUpdateFailed;
      _isEnabled = $v.isEnabled;
      _isFixed = $v.isFixed;
      _contract = $v.contract;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetCoin other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetCoin;
  }

  @override
  void update(void Function(AssetCoinBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetCoin build() => _build();

  _$AssetCoin _build() {
    final _$result = _$v ??
        new _$AssetCoin._(
            name: name,
            fullName: fullName,
            chain: chain,
            symbol: symbol,
            address: address,
            iconOnline: iconOnline,
            iconLocal: iconLocal,
            chainPrecision: chainPrecision,
            displayPrecision: displayPrecision,
            balance: balance,
            balanceUnconfirmed: balanceUnconfirmed,
            balanceUpdateFailed: balanceUpdateFailed,
            isEnabled: isEnabled,
            isFixed: isFixed,
            contract: contract);
    replace(_$result);
    return _$result;
  }
}

class _$AssetPrice extends AssetPrice {
  @override
  final String tradePairId;
  @override
  final int precision;
  @override
  final double price;
  @override
  final double price24h;

  factory _$AssetPrice([void Function(AssetPriceBuilder)? updates]) =>
      (new AssetPriceBuilder()..update(updates))._build();

  _$AssetPrice._(
      {required this.tradePairId,
      required this.precision,
      required this.price,
      required this.price24h})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        tradePairId, r'AssetPrice', 'tradePairId');
    BuiltValueNullFieldError.checkNotNull(
        precision, r'AssetPrice', 'precision');
    BuiltValueNullFieldError.checkNotNull(price, r'AssetPrice', 'price');
    BuiltValueNullFieldError.checkNotNull(price24h, r'AssetPrice', 'price24h');
  }

  @override
  AssetPrice rebuild(void Function(AssetPriceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetPriceBuilder toBuilder() => new AssetPriceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetPrice &&
        tradePairId == other.tradePairId &&
        precision == other.precision &&
        price == other.price &&
        price24h == other.price24h;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, tradePairId.hashCode), precision.hashCode),
            price.hashCode),
        price24h.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetPrice')
          ..add('tradePairId', tradePairId)
          ..add('precision', precision)
          ..add('price', price)
          ..add('price24h', price24h))
        .toString();
  }
}

class AssetPriceBuilder implements Builder<AssetPrice, AssetPriceBuilder> {
  _$AssetPrice? _$v;

  String? _tradePairId;
  String? get tradePairId => _$this._tradePairId;
  set tradePairId(String? tradePairId) => _$this._tradePairId = tradePairId;

  int? _precision;
  int? get precision => _$this._precision;
  set precision(int? precision) => _$this._precision = precision;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  double? _price24h;
  double? get price24h => _$this._price24h;
  set price24h(double? price24h) => _$this._price24h = price24h;

  AssetPriceBuilder();

  AssetPriceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tradePairId = $v.tradePairId;
      _precision = $v.precision;
      _price = $v.price;
      _price24h = $v.price24h;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetPrice other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetPrice;
  }

  @override
  void update(void Function(AssetPriceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetPrice build() => _build();

  _$AssetPrice _build() {
    final _$result = _$v ??
        new _$AssetPrice._(
            tradePairId: BuiltValueNullFieldError.checkNotNull(
                tradePairId, r'AssetPrice', 'tradePairId'),
            precision: BuiltValueNullFieldError.checkNotNull(
                precision, r'AssetPrice', 'precision'),
            price: BuiltValueNullFieldError.checkNotNull(
                price, r'AssetPrice', 'price'),
            price24h: BuiltValueNullFieldError.checkNotNull(
                price24h, r'AssetPrice', 'price24h'));
    replace(_$result);
    return _$result;
  }
}

class _$AssetAddress extends AssetAddress {
  @override
  final String? id;
  @override
  final String? address;
  @override
  final String? chain;
  @override
  final String? comments;
  @override
  final String? symbol;
  @override
  final bool? isLocal;

  factory _$AssetAddress([void Function(AssetAddressBuilder)? updates]) =>
      (new AssetAddressBuilder()..update(updates))._build();

  _$AssetAddress._(
      {this.id,
      this.address,
      this.chain,
      this.comments,
      this.symbol,
      this.isLocal})
      : super._();

  @override
  AssetAddress rebuild(void Function(AssetAddressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetAddressBuilder toBuilder() => new AssetAddressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetAddress &&
        id == other.id &&
        address == other.address &&
        chain == other.chain &&
        comments == other.comments &&
        symbol == other.symbol &&
        isLocal == other.isLocal;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), address.hashCode), chain.hashCode),
                comments.hashCode),
            symbol.hashCode),
        isLocal.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetAddress')
          ..add('id', id)
          ..add('address', address)
          ..add('chain', chain)
          ..add('comments', comments)
          ..add('symbol', symbol)
          ..add('isLocal', isLocal))
        .toString();
  }
}

class AssetAddressBuilder
    implements Builder<AssetAddress, AssetAddressBuilder> {
  _$AssetAddress? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(String? chain) => _$this._chain = chain;

  String? _comments;
  String? get comments => _$this._comments;
  set comments(String? comments) => _$this._comments = comments;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  bool? _isLocal;
  bool? get isLocal => _$this._isLocal;
  set isLocal(bool? isLocal) => _$this._isLocal = isLocal;

  AssetAddressBuilder();

  AssetAddressBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _address = $v.address;
      _chain = $v.chain;
      _comments = $v.comments;
      _symbol = $v.symbol;
      _isLocal = $v.isLocal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetAddress other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetAddress;
  }

  @override
  void update(void Function(AssetAddressBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetAddress build() => _build();

  _$AssetAddress _build() {
    final _$result = _$v ??
        new _$AssetAddress._(
            id: id,
            address: address,
            chain: chain,
            comments: comments,
            symbol: symbol,
            isLocal: isLocal);
    replace(_$result);
    return _$result;
  }
}

class _$AssetState extends AssetState {
  @override
  final BuiltList<AssetCoin> coins;
  @override
  final bool hideInvitationShowcase;
  @override
  final bool hideInvitationNotice;
  @override
  final bool hideSmallAssets;
  @override
  final bool isBalanceUpdating;
  @override
  final bool hideDepositShowcase;
  @override
  final bool hideWithdrawShowcase;
  @override
  final String coinsSearchTerm;
  @override
  final BuiltList<AssetAddress>? addressList;
  @override
  final String? addressRequestId;

  factory _$AssetState([void Function(AssetStateBuilder)? updates]) =>
      (new AssetStateBuilder()..update(updates))._build();

  _$AssetState._(
      {required this.coins,
      required this.hideInvitationShowcase,
      required this.hideInvitationNotice,
      required this.hideSmallAssets,
      required this.isBalanceUpdating,
      required this.hideDepositShowcase,
      required this.hideWithdrawShowcase,
      required this.coinsSearchTerm,
      this.addressList,
      this.addressRequestId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(coins, r'AssetState', 'coins');
    BuiltValueNullFieldError.checkNotNull(
        hideInvitationShowcase, r'AssetState', 'hideInvitationShowcase');
    BuiltValueNullFieldError.checkNotNull(
        hideInvitationNotice, r'AssetState', 'hideInvitationNotice');
    BuiltValueNullFieldError.checkNotNull(
        hideSmallAssets, r'AssetState', 'hideSmallAssets');
    BuiltValueNullFieldError.checkNotNull(
        isBalanceUpdating, r'AssetState', 'isBalanceUpdating');
    BuiltValueNullFieldError.checkNotNull(
        hideDepositShowcase, r'AssetState', 'hideDepositShowcase');
    BuiltValueNullFieldError.checkNotNull(
        hideWithdrawShowcase, r'AssetState', 'hideWithdrawShowcase');
    BuiltValueNullFieldError.checkNotNull(
        coinsSearchTerm, r'AssetState', 'coinsSearchTerm');
  }

  @override
  AssetState rebuild(void Function(AssetStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetStateBuilder toBuilder() => new AssetStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetState &&
        coins == other.coins &&
        hideInvitationShowcase == other.hideInvitationShowcase &&
        hideInvitationNotice == other.hideInvitationNotice &&
        hideSmallAssets == other.hideSmallAssets &&
        isBalanceUpdating == other.isBalanceUpdating &&
        hideDepositShowcase == other.hideDepositShowcase &&
        hideWithdrawShowcase == other.hideWithdrawShowcase &&
        coinsSearchTerm == other.coinsSearchTerm &&
        addressList == other.addressList &&
        addressRequestId == other.addressRequestId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, coins.hashCode),
                                        hideInvitationShowcase.hashCode),
                                    hideInvitationNotice.hashCode),
                                hideSmallAssets.hashCode),
                            isBalanceUpdating.hashCode),
                        hideDepositShowcase.hashCode),
                    hideWithdrawShowcase.hashCode),
                coinsSearchTerm.hashCode),
            addressList.hashCode),
        addressRequestId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetState')
          ..add('coins', coins)
          ..add('hideInvitationShowcase', hideInvitationShowcase)
          ..add('hideInvitationNotice', hideInvitationNotice)
          ..add('hideSmallAssets', hideSmallAssets)
          ..add('isBalanceUpdating', isBalanceUpdating)
          ..add('hideDepositShowcase', hideDepositShowcase)
          ..add('hideWithdrawShowcase', hideWithdrawShowcase)
          ..add('coinsSearchTerm', coinsSearchTerm)
          ..add('addressList', addressList)
          ..add('addressRequestId', addressRequestId))
        .toString();
  }
}

class AssetStateBuilder implements Builder<AssetState, AssetStateBuilder> {
  _$AssetState? _$v;

  ListBuilder<AssetCoin>? _coins;
  ListBuilder<AssetCoin> get coins =>
      _$this._coins ??= new ListBuilder<AssetCoin>();
  set coins(ListBuilder<AssetCoin>? coins) => _$this._coins = coins;

  bool? _hideInvitationShowcase;
  bool? get hideInvitationShowcase => _$this._hideInvitationShowcase;
  set hideInvitationShowcase(bool? hideInvitationShowcase) =>
      _$this._hideInvitationShowcase = hideInvitationShowcase;

  bool? _hideInvitationNotice;
  bool? get hideInvitationNotice => _$this._hideInvitationNotice;
  set hideInvitationNotice(bool? hideInvitationNotice) =>
      _$this._hideInvitationNotice = hideInvitationNotice;

  bool? _hideSmallAssets;
  bool? get hideSmallAssets => _$this._hideSmallAssets;
  set hideSmallAssets(bool? hideSmallAssets) =>
      _$this._hideSmallAssets = hideSmallAssets;

  bool? _isBalanceUpdating;
  bool? get isBalanceUpdating => _$this._isBalanceUpdating;
  set isBalanceUpdating(bool? isBalanceUpdating) =>
      _$this._isBalanceUpdating = isBalanceUpdating;

  bool? _hideDepositShowcase;
  bool? get hideDepositShowcase => _$this._hideDepositShowcase;
  set hideDepositShowcase(bool? hideDepositShowcase) =>
      _$this._hideDepositShowcase = hideDepositShowcase;

  bool? _hideWithdrawShowcase;
  bool? get hideWithdrawShowcase => _$this._hideWithdrawShowcase;
  set hideWithdrawShowcase(bool? hideWithdrawShowcase) =>
      _$this._hideWithdrawShowcase = hideWithdrawShowcase;

  String? _coinsSearchTerm;
  String? get coinsSearchTerm => _$this._coinsSearchTerm;
  set coinsSearchTerm(String? coinsSearchTerm) =>
      _$this._coinsSearchTerm = coinsSearchTerm;

  ListBuilder<AssetAddress>? _addressList;
  ListBuilder<AssetAddress> get addressList =>
      _$this._addressList ??= new ListBuilder<AssetAddress>();
  set addressList(ListBuilder<AssetAddress>? addressList) =>
      _$this._addressList = addressList;

  String? _addressRequestId;
  String? get addressRequestId => _$this._addressRequestId;
  set addressRequestId(String? addressRequestId) =>
      _$this._addressRequestId = addressRequestId;

  AssetStateBuilder();

  AssetStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coins = $v.coins.toBuilder();
      _hideInvitationShowcase = $v.hideInvitationShowcase;
      _hideInvitationNotice = $v.hideInvitationNotice;
      _hideSmallAssets = $v.hideSmallAssets;
      _isBalanceUpdating = $v.isBalanceUpdating;
      _hideDepositShowcase = $v.hideDepositShowcase;
      _hideWithdrawShowcase = $v.hideWithdrawShowcase;
      _coinsSearchTerm = $v.coinsSearchTerm;
      _addressList = $v.addressList?.toBuilder();
      _addressRequestId = $v.addressRequestId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssetState;
  }

  @override
  void update(void Function(AssetStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetState build() => _build();

  _$AssetState _build() {
    _$AssetState _$result;
    try {
      _$result = _$v ??
          new _$AssetState._(
              coins: coins.build(),
              hideInvitationShowcase: BuiltValueNullFieldError.checkNotNull(
                  hideInvitationShowcase, r'AssetState', 'hideInvitationShowcase'),
              hideInvitationNotice: BuiltValueNullFieldError.checkNotNull(
                  hideInvitationNotice, r'AssetState', 'hideInvitationNotice'),
              hideSmallAssets: BuiltValueNullFieldError.checkNotNull(
                  hideSmallAssets, r'AssetState', 'hideSmallAssets'),
              isBalanceUpdating: BuiltValueNullFieldError.checkNotNull(
                  isBalanceUpdating, r'AssetState', 'isBalanceUpdating'),
              hideDepositShowcase: BuiltValueNullFieldError.checkNotNull(
                  hideDepositShowcase, r'AssetState', 'hideDepositShowcase'),
              hideWithdrawShowcase: BuiltValueNullFieldError.checkNotNull(
                  hideWithdrawShowcase, r'AssetState', 'hideWithdrawShowcase'),
              coinsSearchTerm: BuiltValueNullFieldError.checkNotNull(
                  coinsSearchTerm, r'AssetState', 'coinsSearchTerm'),
              addressList: _addressList?.build(),
              addressRequestId: addressRequestId);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coins';
        coins.build();

        _$failedField = 'addressList';
        _addressList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AssetState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PricesAdapter extends TypeAdapter<Prices> {
  @override
  final int typeId = 20;

  @override
  Prices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prices()
      ..coinPrices = (fields[0] as Map?)?.cast<String, double>()
      ..fiatPrices = (fields[1] as Map?)?.cast<String, double>()
      ..createdAt = fields[2] as DateTime?
      ..updatedAt = fields[3] as DateTime?
      ..coinUpdatedAt = fields[4] as DateTime?
      ..fiatUpdatedAt = fields[5] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Prices obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.coinPrices)
      ..writeByte(1)
      ..write(obj.fiatPrices)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.coinUpdatedAt)
      ..writeByte(5)
      ..write(obj.fiatUpdatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PricesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 21;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction()
      ..txId = fields[0] as String?
      ..chain = fields[1] as String?
      ..symbol = fields[2] as String?
      ..confirmations = fields[3] as int?
      ..timestamp = fields[4] as int?
      ..blockHeight = fields[5] as int?
      ..failed = fields[6] as bool?
      ..toAddress = fields[7] as String?
      ..fromAddress = fields[8] as String?
      ..amount = fields[9] as double?
      ..fee = fields[10] as double?
      ..feeSymbol = fields[11] as String?
      ..contract = fields[12] as String?
      ..type = fields[13] as TransactionType?;
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.txId)
      ..writeByte(1)
      ..write(obj.chain)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.confirmations)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.blockHeight)
      ..writeByte(6)
      ..write(obj.failed)
      ..writeByte(7)
      ..write(obj.toAddress)
      ..writeByte(8)
      ..write(obj.fromAddress)
      ..writeByte(9)
      ..write(obj.amount)
      ..writeByte(10)
      ..write(obj.fee)
      ..writeByte(11)
      ..write(obj.feeSymbol)
      ..writeByte(12)
      ..write(obj.contract)
      ..writeByte(13)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final int typeId = 22;

  @override
  TransactionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionType.deposit;
      case 1:
        return TransactionType.withdraw;
      case 2:
        return TransactionType.contractCall;
      case 3:
        return TransactionType.approveCall;
      default:
        return TransactionType.deposit;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    switch (obj) {
      case TransactionType.deposit:
        writer.writeByte(0);
        break;
      case TransactionType.withdraw:
        writer.writeByte(1);
        break;
      case TransactionType.contractCall:
        writer.writeByte(2);
        break;
      case TransactionType.approveCall:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
