// GENERATED CODE - DO NOT MODIFY BY HAND

part of admission_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AdmissionInfo> _$admissionInfoSerializer =
    new _$AdmissionInfoSerializer();
Serializer<AdmissionConfig> _$admissionConfigSerializer =
    new _$AdmissionConfigSerializer();
Serializer<AdmissionCondition> _$admissionConditionSerializer =
    new _$AdmissionConditionSerializer();

class _$AdmissionInfoSerializer implements StructuredSerializer<AdmissionInfo> {
  @override
  final Iterable<Type> types = const [AdmissionInfo, _$AdmissionInfo];
  @override
  final String wireName = 'AdmissionInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, AdmissionInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.describe;
    if (value != null) {
      result
        ..add('describe')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.endTime;
    if (value != null) {
      result
        ..add('end_time')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.startTime;
    if (value != null) {
      result
        ..add('start_time')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.condition;
    if (value != null) {
      result
        ..add('condition')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(AdmissionCondition)])));
    }
    value = object.ecological;
    if (value != null) {
      result
        ..add('ecological')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])));
    }
    return result;
  }

  @override
  AdmissionInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdmissionInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'describe':
          result.describe = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'end_time':
          result.endTime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'start_time':
          result.startTime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'condition':
          result.condition.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AdmissionCondition)]))!
              as BuiltList<Object?>);
          break;
        case 'ecological':
          result.ecological.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$AdmissionConfigSerializer
    implements StructuredSerializer<AdmissionConfig> {
  @override
  final Iterable<Type> types = const [AdmissionConfig, _$AdmissionConfig];
  @override
  final String wireName = 'AdmissionConfig';

  @override
  Iterable<Object?> serialize(Serializers serializers, AdmissionConfig object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.fork;
    if (value != null) {
      result
        ..add('fork')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.homeList;
    if (value != null) {
      result
        ..add('home_list')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.projects;
    if (value != null) {
      result
        ..add('ecological')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(AdmissionInfo)])));
    }
    return result;
  }

  @override
  AdmissionConfig deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdmissionConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'fork':
          result.fork = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'home_list':
          result.homeList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'ecological':
          result.projects.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AdmissionInfo)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$AdmissionConditionSerializer
    implements StructuredSerializer<AdmissionCondition> {
  @override
  final Iterable<Type> types = const [AdmissionCondition, _$AdmissionCondition];
  @override
  final String wireName = 'AdmissionCondition';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AdmissionCondition object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.address;
    if (value != null) {
      result
        ..add('black_hole_address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transferData;
    if (value != null) {
      result
        ..add('black_hole_transfer_data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.transferCount;
    if (value != null) {
      result
        ..add('black_hole_transfer_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.transferProgress;
    if (value != null) {
      result
        ..add('black_hole_transfer_progress')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.transferCurrency;
    if (value != null) {
      result
        ..add('black_hole_transfer_currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])
            ])));
    }
    return result;
  }

  @override
  AdmissionCondition deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdmissionConditionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'black_hole_address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'black_hole_transfer_data':
          result.transferData = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'black_hole_transfer_count':
          result.transferCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'black_hole_transfer_progress':
          result.transferProgress = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'black_hole_transfer_currency':
          result.transferCurrency.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltMap,
                    const [const FullType(String), const FullType(String)])
              ]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$AdmissionCreateVM extends AdmissionCreateVM {
  @override
  final String? walletId;
  @override
  final Future<WalletWithdrawData> Function(
          WithdrawBeforeParams params, WalletWithdrawData previousData)
      onWithdrawBefore;
  @override
  final Future<String> Function(
      WithdrawSubmitParams params, WalletPrivateData walletData,
      [Future<bool> Function() onConfirmSubmit]) submit;
  @override
  final Future<void> Function(
      {required AssetCoin coinInfo,
      required String toAddress,
      required String txData,
      required String amount,
      required Future<WalletPrivateData> Function() onUnlockWallet,
      required void Function(String txId) onSuccessTransaction,
      required Future<bool> Function(WalletWithdrawData withdrawData)
          onConfirmParams,
      Future<bool> Function()? onConfirmSubmit}) doSubmitAdmission;
  @override
  final double Function({required String chain, required String symbol})
      getCoinBalance;
  @override
  final AssetCoin Function({required String chain, required String symbol})
      getCoinInfo;
  @override
  final AssetCoin Function(String fork) getCoinInfoByFork;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;

  factory _$AdmissionCreateVM(
          [void Function(AdmissionCreateVMBuilder)? updates]) =>
      (new AdmissionCreateVMBuilder()..update(updates))._build();

  _$AdmissionCreateVM._(
      {this.walletId,
      required this.onWithdrawBefore,
      required this.submit,
      required this.doSubmitAdmission,
      required this.getCoinBalance,
      required this.getCoinInfo,
      required this.getCoinInfoByFork,
      required this.doUnlockWallet})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        onWithdrawBefore, r'AdmissionCreateVM', 'onWithdrawBefore');
    BuiltValueNullFieldError.checkNotNull(
        submit, r'AdmissionCreateVM', 'submit');
    BuiltValueNullFieldError.checkNotNull(
        doSubmitAdmission, r'AdmissionCreateVM', 'doSubmitAdmission');
    BuiltValueNullFieldError.checkNotNull(
        getCoinBalance, r'AdmissionCreateVM', 'getCoinBalance');
    BuiltValueNullFieldError.checkNotNull(
        getCoinInfo, r'AdmissionCreateVM', 'getCoinInfo');
    BuiltValueNullFieldError.checkNotNull(
        getCoinInfoByFork, r'AdmissionCreateVM', 'getCoinInfoByFork');
    BuiltValueNullFieldError.checkNotNull(
        doUnlockWallet, r'AdmissionCreateVM', 'doUnlockWallet');
  }

  @override
  AdmissionCreateVM rebuild(void Function(AdmissionCreateVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdmissionCreateVMBuilder toBuilder() =>
      new AdmissionCreateVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdmissionCreateVM && walletId == other.walletId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, walletId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdmissionCreateVM')
          ..add('walletId', walletId)
          ..add('onWithdrawBefore', onWithdrawBefore)
          ..add('submit', submit)
          ..add('doSubmitAdmission', doSubmitAdmission)
          ..add('getCoinBalance', getCoinBalance)
          ..add('getCoinInfo', getCoinInfo)
          ..add('getCoinInfoByFork', getCoinInfoByFork)
          ..add('doUnlockWallet', doUnlockWallet))
        .toString();
  }
}

class AdmissionCreateVMBuilder
    implements Builder<AdmissionCreateVM, AdmissionCreateVMBuilder> {
  _$AdmissionCreateVM? _$v;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

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
      [Future<bool> Function() onConfirmSubmit])? _submit;
  Future<String> Function(
      WithdrawSubmitParams params, WalletPrivateData walletData,
      [Future<bool> Function() onConfirmSubmit])? get submit => _$this._submit;
  set submit(
          Future<String> Function(
                  WithdrawSubmitParams params, WalletPrivateData walletData,
                  [Future<bool> Function() onConfirmSubmit])?
              submit) =>
      _$this._submit = submit;

  Future<void> Function(
      {required AssetCoin coinInfo,
      required String toAddress,
      required String txData,
      required String amount,
      required Future<WalletPrivateData> Function() onUnlockWallet,
      required void Function(String txId) onSuccessTransaction,
      required Future<bool> Function(WalletWithdrawData withdrawData)
          onConfirmParams,
      Future<bool> Function()? onConfirmSubmit})? _doSubmitAdmission;
  Future<void> Function(
          {required AssetCoin coinInfo,
          required String toAddress,
          required String txData,
          required String amount,
          required Future<WalletPrivateData> Function() onUnlockWallet,
          required void Function(String txId) onSuccessTransaction,
          required Future<bool> Function(WalletWithdrawData withdrawData)
              onConfirmParams,
          Future<bool> Function()? onConfirmSubmit})?
      get doSubmitAdmission => _$this._doSubmitAdmission;
  set doSubmitAdmission(
          Future<void> Function(
                  {required AssetCoin coinInfo,
                  required String toAddress,
                  required String txData,
                  required String amount,
                  required Future<WalletPrivateData> Function() onUnlockWallet,
                  required void Function(String txId) onSuccessTransaction,
                  required Future<bool> Function(
                          WalletWithdrawData withdrawData)
                      onConfirmParams,
                  Future<bool> Function()? onConfirmSubmit})?
              doSubmitAdmission) =>
      _$this._doSubmitAdmission = doSubmitAdmission;

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

  AssetCoin Function(String fork)? _getCoinInfoByFork;
  AssetCoin Function(String fork)? get getCoinInfoByFork =>
      _$this._getCoinInfoByFork;
  set getCoinInfoByFork(AssetCoin Function(String fork)? getCoinInfoByFork) =>
      _$this._getCoinInfoByFork = getCoinInfoByFork;

  Future<WalletPrivateData> Function(String password)? _doUnlockWallet;
  Future<WalletPrivateData> Function(String password)? get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password)?
              doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  AdmissionCreateVMBuilder();

  AdmissionCreateVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _walletId = $v.walletId;
      _onWithdrawBefore = $v.onWithdrawBefore;
      _submit = $v.submit;
      _doSubmitAdmission = $v.doSubmitAdmission;
      _getCoinBalance = $v.getCoinBalance;
      _getCoinInfo = $v.getCoinInfo;
      _getCoinInfoByFork = $v.getCoinInfoByFork;
      _doUnlockWallet = $v.doUnlockWallet;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdmissionCreateVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdmissionCreateVM;
  }

  @override
  void update(void Function(AdmissionCreateVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdmissionCreateVM build() => _build();

  _$AdmissionCreateVM _build() {
    final _$result = _$v ??
        new _$AdmissionCreateVM._(
            walletId: walletId,
            onWithdrawBefore: BuiltValueNullFieldError.checkNotNull(
                onWithdrawBefore, r'AdmissionCreateVM', 'onWithdrawBefore'),
            submit: BuiltValueNullFieldError.checkNotNull(
                submit, r'AdmissionCreateVM', 'submit'),
            doSubmitAdmission: BuiltValueNullFieldError.checkNotNull(
                doSubmitAdmission, r'AdmissionCreateVM', 'doSubmitAdmission'),
            getCoinBalance: BuiltValueNullFieldError.checkNotNull(
                getCoinBalance, r'AdmissionCreateVM', 'getCoinBalance'),
            getCoinInfo: BuiltValueNullFieldError.checkNotNull(
                getCoinInfo, r'AdmissionCreateVM', 'getCoinInfo'),
            getCoinInfoByFork: BuiltValueNullFieldError.checkNotNull(
                getCoinInfoByFork, r'AdmissionCreateVM', 'getCoinInfoByFork'),
            doUnlockWallet: BuiltValueNullFieldError.checkNotNull(
                doUnlockWallet, r'AdmissionCreateVM', 'doUnlockWallet'));
    replace(_$result);
    return _$result;
  }
}

class _$AdmissionInfo extends AdmissionInfo {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? describe;
  @override
  final int? endTime;
  @override
  final int? startTime;
  @override
  final BuiltList<AdmissionCondition>? condition;
  @override
  final BuiltMap<String, String>? ecological;

  factory _$AdmissionInfo([void Function(AdmissionInfoBuilder)? updates]) =>
      (new AdmissionInfoBuilder()..update(updates))._build();

  _$AdmissionInfo._(
      {this.id,
      this.name,
      this.describe,
      this.endTime,
      this.startTime,
      this.condition,
      this.ecological})
      : super._();

  @override
  AdmissionInfo rebuild(void Function(AdmissionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdmissionInfoBuilder toBuilder() => new AdmissionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdmissionInfo &&
        id == other.id &&
        name == other.name &&
        describe == other.describe &&
        endTime == other.endTime &&
        startTime == other.startTime &&
        condition == other.condition &&
        ecological == other.ecological;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), name.hashCode),
                        describe.hashCode),
                    endTime.hashCode),
                startTime.hashCode),
            condition.hashCode),
        ecological.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdmissionInfo')
          ..add('id', id)
          ..add('name', name)
          ..add('describe', describe)
          ..add('endTime', endTime)
          ..add('startTime', startTime)
          ..add('condition', condition)
          ..add('ecological', ecological))
        .toString();
  }
}

class AdmissionInfoBuilder
    implements Builder<AdmissionInfo, AdmissionInfoBuilder> {
  _$AdmissionInfo? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _describe;
  String? get describe => _$this._describe;
  set describe(String? describe) => _$this._describe = describe;

  int? _endTime;
  int? get endTime => _$this._endTime;
  set endTime(int? endTime) => _$this._endTime = endTime;

  int? _startTime;
  int? get startTime => _$this._startTime;
  set startTime(int? startTime) => _$this._startTime = startTime;

  ListBuilder<AdmissionCondition>? _condition;
  ListBuilder<AdmissionCondition> get condition =>
      _$this._condition ??= new ListBuilder<AdmissionCondition>();
  set condition(ListBuilder<AdmissionCondition>? condition) =>
      _$this._condition = condition;

  MapBuilder<String, String>? _ecological;
  MapBuilder<String, String> get ecological =>
      _$this._ecological ??= new MapBuilder<String, String>();
  set ecological(MapBuilder<String, String>? ecological) =>
      _$this._ecological = ecological;

  AdmissionInfoBuilder();

  AdmissionInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _describe = $v.describe;
      _endTime = $v.endTime;
      _startTime = $v.startTime;
      _condition = $v.condition?.toBuilder();
      _ecological = $v.ecological?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdmissionInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdmissionInfo;
  }

  @override
  void update(void Function(AdmissionInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdmissionInfo build() => _build();

  _$AdmissionInfo _build() {
    _$AdmissionInfo _$result;
    try {
      _$result = _$v ??
          new _$AdmissionInfo._(
              id: id,
              name: name,
              describe: describe,
              endTime: endTime,
              startTime: startTime,
              condition: _condition?.build(),
              ecological: _ecological?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'condition';
        _condition?.build();
        _$failedField = 'ecological';
        _ecological?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AdmissionInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AdmissionConfig extends AdmissionConfig {
  @override
  final String? fork;
  @override
  final BuiltList<int>? homeList;
  @override
  final BuiltList<AdmissionInfo>? projects;

  factory _$AdmissionConfig([void Function(AdmissionConfigBuilder)? updates]) =>
      (new AdmissionConfigBuilder()..update(updates))._build();

  _$AdmissionConfig._({this.fork, this.homeList, this.projects}) : super._();

  @override
  AdmissionConfig rebuild(void Function(AdmissionConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdmissionConfigBuilder toBuilder() =>
      new AdmissionConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdmissionConfig &&
        fork == other.fork &&
        homeList == other.homeList &&
        projects == other.projects;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, fork.hashCode), homeList.hashCode), projects.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdmissionConfig')
          ..add('fork', fork)
          ..add('homeList', homeList)
          ..add('projects', projects))
        .toString();
  }
}

class AdmissionConfigBuilder
    implements Builder<AdmissionConfig, AdmissionConfigBuilder> {
  _$AdmissionConfig? _$v;

  String? _fork;
  String? get fork => _$this._fork;
  set fork(String? fork) => _$this._fork = fork;

  ListBuilder<int>? _homeList;
  ListBuilder<int> get homeList => _$this._homeList ??= new ListBuilder<int>();
  set homeList(ListBuilder<int>? homeList) => _$this._homeList = homeList;

  ListBuilder<AdmissionInfo>? _projects;
  ListBuilder<AdmissionInfo> get projects =>
      _$this._projects ??= new ListBuilder<AdmissionInfo>();
  set projects(ListBuilder<AdmissionInfo>? projects) =>
      _$this._projects = projects;

  AdmissionConfigBuilder();

  AdmissionConfigBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fork = $v.fork;
      _homeList = $v.homeList?.toBuilder();
      _projects = $v.projects?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdmissionConfig other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdmissionConfig;
  }

  @override
  void update(void Function(AdmissionConfigBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdmissionConfig build() => _build();

  _$AdmissionConfig _build() {
    _$AdmissionConfig _$result;
    try {
      _$result = _$v ??
          new _$AdmissionConfig._(
              fork: fork,
              homeList: _homeList?.build(),
              projects: _projects?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'homeList';
        _homeList?.build();
        _$failedField = 'projects';
        _projects?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AdmissionConfig', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AdmissionCondition extends AdmissionCondition {
  @override
  final String? address;
  @override
  final String? transferData;
  @override
  final int? transferCount;
  @override
  final int? transferProgress;
  @override
  final BuiltMap<String, BuiltMap<String, String>>? transferCurrency;

  factory _$AdmissionCondition(
          [void Function(AdmissionConditionBuilder)? updates]) =>
      (new AdmissionConditionBuilder()..update(updates))._build();

  _$AdmissionCondition._(
      {this.address,
      this.transferData,
      this.transferCount,
      this.transferProgress,
      this.transferCurrency})
      : super._();

  @override
  AdmissionCondition rebuild(
          void Function(AdmissionConditionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdmissionConditionBuilder toBuilder() =>
      new AdmissionConditionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdmissionCondition &&
        address == other.address &&
        transferData == other.transferData &&
        transferCount == other.transferCount &&
        transferProgress == other.transferProgress &&
        transferCurrency == other.transferCurrency;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, address.hashCode), transferData.hashCode),
                transferCount.hashCode),
            transferProgress.hashCode),
        transferCurrency.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdmissionCondition')
          ..add('address', address)
          ..add('transferData', transferData)
          ..add('transferCount', transferCount)
          ..add('transferProgress', transferProgress)
          ..add('transferCurrency', transferCurrency))
        .toString();
  }
}

class AdmissionConditionBuilder
    implements Builder<AdmissionCondition, AdmissionConditionBuilder> {
  _$AdmissionCondition? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _transferData;
  String? get transferData => _$this._transferData;
  set transferData(String? transferData) => _$this._transferData = transferData;

  int? _transferCount;
  int? get transferCount => _$this._transferCount;
  set transferCount(int? transferCount) =>
      _$this._transferCount = transferCount;

  int? _transferProgress;
  int? get transferProgress => _$this._transferProgress;
  set transferProgress(int? transferProgress) =>
      _$this._transferProgress = transferProgress;

  MapBuilder<String, BuiltMap<String, String>>? _transferCurrency;
  MapBuilder<String, BuiltMap<String, String>> get transferCurrency =>
      _$this._transferCurrency ??=
          new MapBuilder<String, BuiltMap<String, String>>();
  set transferCurrency(
          MapBuilder<String, BuiltMap<String, String>>? transferCurrency) =>
      _$this._transferCurrency = transferCurrency;

  AdmissionConditionBuilder();

  AdmissionConditionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _transferData = $v.transferData;
      _transferCount = $v.transferCount;
      _transferProgress = $v.transferProgress;
      _transferCurrency = $v.transferCurrency?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdmissionCondition other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdmissionCondition;
  }

  @override
  void update(void Function(AdmissionConditionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdmissionCondition build() => _build();

  _$AdmissionCondition _build() {
    _$AdmissionCondition _$result;
    try {
      _$result = _$v ??
          new _$AdmissionCondition._(
              address: address,
              transferData: transferData,
              transferCount: transferCount,
              transferProgress: transferProgress,
              transferCurrency: _transferCurrency?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transferCurrency';
        _transferCurrency?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AdmissionCondition', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AdmissionState extends AdmissionState {
  @override
  final AdmissionConfig? config;
  @override
  final int? configState;
  @override
  final BuiltList<AdmissionInfo>? admissionList;

  factory _$AdmissionState([void Function(AdmissionStateBuilder)? updates]) =>
      (new AdmissionStateBuilder()..update(updates))._build();

  _$AdmissionState._({this.config, this.configState, this.admissionList})
      : super._();

  @override
  AdmissionState rebuild(void Function(AdmissionStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdmissionStateBuilder toBuilder() =>
      new AdmissionStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdmissionState &&
        config == other.config &&
        configState == other.configState &&
        admissionList == other.admissionList;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, config.hashCode), configState.hashCode),
        admissionList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdmissionState')
          ..add('config', config)
          ..add('configState', configState)
          ..add('admissionList', admissionList))
        .toString();
  }
}

class AdmissionStateBuilder
    implements Builder<AdmissionState, AdmissionStateBuilder> {
  _$AdmissionState? _$v;

  AdmissionConfigBuilder? _config;
  AdmissionConfigBuilder get config =>
      _$this._config ??= new AdmissionConfigBuilder();
  set config(AdmissionConfigBuilder? config) => _$this._config = config;

  int? _configState;
  int? get configState => _$this._configState;
  set configState(int? configState) => _$this._configState = configState;

  ListBuilder<AdmissionInfo>? _admissionList;
  ListBuilder<AdmissionInfo> get admissionList =>
      _$this._admissionList ??= new ListBuilder<AdmissionInfo>();
  set admissionList(ListBuilder<AdmissionInfo>? admissionList) =>
      _$this._admissionList = admissionList;

  AdmissionStateBuilder();

  AdmissionStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _config = $v.config?.toBuilder();
      _configState = $v.configState;
      _admissionList = $v.admissionList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdmissionState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdmissionState;
  }

  @override
  void update(void Function(AdmissionStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdmissionState build() => _build();

  _$AdmissionState _build() {
    _$AdmissionState _$result;
    try {
      _$result = _$v ??
          new _$AdmissionState._(
              config: _config?.build(),
              configState: configState,
              admissionList: _admissionList?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();

        _$failedField = 'admissionList';
        _admissionList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AdmissionState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
