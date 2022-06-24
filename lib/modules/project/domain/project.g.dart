// GENERATED CODE - DO NOT MODIFY BY HAND

part of project_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProjectCreateMint> _$projectCreateMintSerializer =
    new _$ProjectCreateMintSerializer();
Serializer<ProjectConfig> _$projectConfigSerializer =
    new _$ProjectConfigSerializer();
Serializer<ProjectCreateParams> _$projectCreateParamsSerializer =
    new _$ProjectCreateParamsSerializer();
Serializer<ProjectInfo> _$projectInfoSerializer = new _$ProjectInfoSerializer();
Serializer<ProjectState> _$projectStateSerializer =
    new _$ProjectStateSerializer();

class _$ProjectCreateMintSerializer
    implements StructuredSerializer<ProjectCreateMint> {
  @override
  final Iterable<Type> types = const [ProjectCreateMint, _$ProjectCreateMint];
  @override
  final String wireName = 'ProjectCreateMint';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProjectCreateMint object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'index',
      serializers.serialize(object.index, specifiedType: const FullType(int)),
      'month',
      serializers.serialize(object.month,
          specifiedType: const FullType(String)),
      'ratio',
      serializers.serialize(object.ratio,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ProjectCreateMint deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectCreateMintBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'index':
          result.index = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'month':
          result.month = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'ratio':
          result.ratio = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectConfigSerializer implements StructuredSerializer<ProjectConfig> {
  @override
  final Iterable<Type> types = const [ProjectConfig, _$ProjectConfig];
  @override
  final String wireName = 'ProjectConfig';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProjectConfig object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.instructions;
    if (value != null) {
      result
        ..add('instructions')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  ProjectConfig deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'instructions':
          result.instructions = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectCreateParamsSerializer
    implements StructuredSerializer<ProjectCreateParams> {
  @override
  final Iterable<Type> types = const [
    ProjectCreateParams,
    _$ProjectCreateParams
  ];
  @override
  final String wireName = 'ProjectCreateParams';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ProjectCreateParams object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'projectName',
      serializers.serialize(object.projectName,
          specifiedType: const FullType(String)),
      'projectDescription',
      serializers.serialize(object.projectDescription,
          specifiedType: const FullType(String)),
      'coinName',
      serializers.serialize(object.coinName,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(String)),
      'issuerName',
      serializers.serialize(object.issuerName,
          specifiedType: const FullType(String)),
      'webUrl',
      serializers.serialize(object.webUrl,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'poolMinCurrency',
      serializers.serialize(object.poolMinCurrency,
          specifiedType: const FullType(String)),
      'poolCycle',
      serializers.serialize(object.poolCycle,
          specifiedType: const FullType(String)),
      'poolInitAmount',
      serializers.serialize(object.poolInitAmount,
          specifiedType: const FullType(String)),
      'poolEnable',
      serializers.serialize(object.poolEnable,
          specifiedType: const FullType(bool)),
      'remainPoolMonths',
      serializers.serialize(object.remainPoolMonths,
          specifiedType: const FullType(String)),
      'remainPoolAmount',
      serializers.serialize(object.remainPoolAmount,
          specifiedType: const FullType(String)),
      'minBalance',
      serializers.serialize(object.minBalance,
          specifiedType: const FullType(String)),
      'mintList',
      serializers.serialize(object.mintList,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ProjectCreateMint)])),
    ];
    Object? value;
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
    value = object.txId;
    if (value != null) {
      result
        ..add('txId')
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
    value = object.withdrawData;
    if (value != null) {
      result
        ..add('withdrawData')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(WalletWithdrawData)));
    }
    value = object.withdrawAmount;
    if (value != null) {
      result
        ..add('withdrawAmount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.submittedAt;
    if (value != null) {
      result
        ..add('submittedAt')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ProjectCreateParams deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectCreateParamsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'projectName':
          result.projectName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'projectDescription':
          result.projectDescription = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'coinName':
          result.coinName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'issuerName':
          result.issuerName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'webUrl':
          result.webUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'poolMinCurrency':
          result.poolMinCurrency = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'poolCycle':
          result.poolCycle = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'poolInitAmount':
          result.poolInitAmount = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'poolEnable':
          result.poolEnable = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'remainPoolMonths':
          result.remainPoolMonths = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'remainPoolAmount':
          result.remainPoolAmount = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'minBalance':
          result.minBalance = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'mintList':
          result.mintList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProjectCreateMint)]))!
              as BuiltList<Object?>);
          break;
        case 'chain':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'txId':
          result.txId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'withdrawData':
          result.withdrawData = serializers.deserialize(value,
                  specifiedType: const FullType(WalletWithdrawData))
              as WalletWithdrawData?;
          break;
        case 'withdrawAmount':
          result.withdrawAmount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'submittedAt':
          result.submittedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectInfoSerializer implements StructuredSerializer<ProjectInfo> {
  @override
  final Iterable<Type> types = const [ProjectInfo, _$ProjectInfo];
  @override
  final String wireName = 'ProjectInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProjectInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.symbol;
    if (value != null) {
      result
        ..add('currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.currencyPrice;
    if (value != null) {
      result
        ..add('currency_price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.initAmount;
    if (value != null) {
      result
        ..add('init_amount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.projectName;
    if (value != null) {
      result
        ..add('project_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.targetNumber;
    if (value != null) {
      result
        ..add('target_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.inviteNumber;
    if (value != null) {
      result
        ..add('invite_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.fork;
    if (value != null) {
      result
        ..add('fork')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.totalAmount;
    if (value != null) {
      result
        ..add('total_amount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ownerWebsite;
    if (value != null) {
      result
        ..add('owner_website')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ownerName;
    if (value != null) {
      result
        ..add('owner_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])));
    }
    value = object.projectDescription;
    if (value != null) {
      result
        ..add('project_description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.miningPoolStatus;
    if (value != null) {
      result
        ..add('mining_pool_status')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.iconUrl;
    if (value != null) {
      result
        ..add('iconUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProjectInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectInfoBuilder();

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
        case 'currency':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'currency_price':
          result.currencyPrice = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'init_amount':
          result.initAmount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'project_name':
          result.projectName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'target_number':
          result.targetNumber = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'invite_number':
          result.inviteNumber = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'fork':
          result.fork = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'total_amount':
          result.totalAmount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'owner_website':
          result.ownerWebsite = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'owner_name':
          result.ownerName.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'project_description':
          result.projectDescription.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'mining_pool_status':
          result.miningPoolStatus = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'iconUrl':
          result.iconUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectStateSerializer implements StructuredSerializer<ProjectState> {
  @override
  final Iterable<Type> types = const [ProjectState, _$ProjectState];
  @override
  final String wireName = 'ProjectState';

  @override
  Iterable<Object?> serialize(Serializers serializers, ProjectState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'projectList',
      serializers.serialize(object.projectList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ProjectInfo)])),
    ];
    Object? value;
    value = object.lastProjectCreateParams;
    if (value != null) {
      result
        ..add('lastProjectCreateParams')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ProjectCreateParams)));
    }
    value = object.projectConfig;
    if (value != null) {
      result
        ..add('projectConfig')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ProjectConfig)));
    }
    return result;
  }

  @override
  ProjectState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProjectStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'lastProjectCreateParams':
          result.lastProjectCreateParams.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ProjectCreateParams))!
              as ProjectCreateParams);
          break;
        case 'projectList':
          result.projectList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ProjectInfo)]))!
              as BuiltList<Object?>);
          break;
        case 'projectConfig':
          result.projectConfig.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProjectConfig))! as ProjectConfig);
          break;
      }
    }

    return result.build();
  }
}

class _$ProjectApplyVM extends ProjectApplyVM {
  @override
  final ProjectCreateParams? lastProjectCreateParams;
  @override
  final String? projectRules;
  @override
  final double Function({required String chain, required String symbol})
      getCoinBalance;
  @override
  final AssetCoin Function({required String chain, required String symbol})
      getCoinInfo;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockHDWallet;
  @override
  final Future<void> Function(
          {required ProjectCreateParams params,
          required Future<WalletPrivateData> Function() onUnlockWallet,
          required Future<bool> Function(ProjectCreateParams) onConfirmData,
          required void Function(String txId) onSuccessTransaction})
      doSubmitProject;
  @override
  final Future<void> Function(ProjectCreateParams params) doSubmitCreateProject;
  @override
  final Future<void> Function(ProjectCreateParams params) doSaveToCache;
  @override
  final Future<void> Function() getProjectConfig;

  factory _$ProjectApplyVM([void Function(ProjectApplyVMBuilder)? updates]) =>
      (new ProjectApplyVMBuilder()..update(updates))._build();

  _$ProjectApplyVM._(
      {this.lastProjectCreateParams,
      this.projectRules,
      required this.getCoinBalance,
      required this.getCoinInfo,
      required this.doUnlockHDWallet,
      required this.doSubmitProject,
      required this.doSubmitCreateProject,
      required this.doSaveToCache,
      required this.getProjectConfig})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        getCoinBalance, r'ProjectApplyVM', 'getCoinBalance');
    BuiltValueNullFieldError.checkNotNull(
        getCoinInfo, r'ProjectApplyVM', 'getCoinInfo');
    BuiltValueNullFieldError.checkNotNull(
        doUnlockHDWallet, r'ProjectApplyVM', 'doUnlockHDWallet');
    BuiltValueNullFieldError.checkNotNull(
        doSubmitProject, r'ProjectApplyVM', 'doSubmitProject');
    BuiltValueNullFieldError.checkNotNull(
        doSubmitCreateProject, r'ProjectApplyVM', 'doSubmitCreateProject');
    BuiltValueNullFieldError.checkNotNull(
        doSaveToCache, r'ProjectApplyVM', 'doSaveToCache');
    BuiltValueNullFieldError.checkNotNull(
        getProjectConfig, r'ProjectApplyVM', 'getProjectConfig');
  }

  @override
  ProjectApplyVM rebuild(void Function(ProjectApplyVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectApplyVMBuilder toBuilder() =>
      new ProjectApplyVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is ProjectApplyVM &&
        lastProjectCreateParams == other.lastProjectCreateParams &&
        projectRules == other.projectRules &&
        doSubmitCreateProject == _$dynamicOther.doSubmitCreateProject;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, lastProjectCreateParams.hashCode), projectRules.hashCode),
        doSubmitCreateProject.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectApplyVM')
          ..add('lastProjectCreateParams', lastProjectCreateParams)
          ..add('projectRules', projectRules)
          ..add('getCoinBalance', getCoinBalance)
          ..add('getCoinInfo', getCoinInfo)
          ..add('doUnlockHDWallet', doUnlockHDWallet)
          ..add('doSubmitProject', doSubmitProject)
          ..add('doSubmitCreateProject', doSubmitCreateProject)
          ..add('doSaveToCache', doSaveToCache)
          ..add('getProjectConfig', getProjectConfig))
        .toString();
  }
}

class ProjectApplyVMBuilder
    implements Builder<ProjectApplyVM, ProjectApplyVMBuilder> {
  _$ProjectApplyVM? _$v;

  ProjectCreateParamsBuilder? _lastProjectCreateParams;
  ProjectCreateParamsBuilder get lastProjectCreateParams =>
      _$this._lastProjectCreateParams ??= new ProjectCreateParamsBuilder();
  set lastProjectCreateParams(
          ProjectCreateParamsBuilder? lastProjectCreateParams) =>
      _$this._lastProjectCreateParams = lastProjectCreateParams;

  String? _projectRules;
  String? get projectRules => _$this._projectRules;
  set projectRules(String? projectRules) => _$this._projectRules = projectRules;

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

  Future<WalletPrivateData> Function(String password)? _doUnlockHDWallet;
  Future<WalletPrivateData> Function(String password)? get doUnlockHDWallet =>
      _$this._doUnlockHDWallet;
  set doUnlockHDWallet(
          Future<WalletPrivateData> Function(String password)?
              doUnlockHDWallet) =>
      _$this._doUnlockHDWallet = doUnlockHDWallet;

  Future<void> Function(
          {required ProjectCreateParams params,
          required Future<WalletPrivateData> Function() onUnlockWallet,
          required Future<bool> Function(ProjectCreateParams) onConfirmData,
          required void Function(String txId) onSuccessTransaction})?
      _doSubmitProject;
  Future<void> Function(
          {required ProjectCreateParams params,
          required Future<WalletPrivateData> Function() onUnlockWallet,
          required Future<bool> Function(ProjectCreateParams) onConfirmData,
          required void Function(String txId) onSuccessTransaction})?
      get doSubmitProject => _$this._doSubmitProject;
  set doSubmitProject(
          Future<void> Function(
                  {required ProjectCreateParams params,
                  required Future<WalletPrivateData> Function() onUnlockWallet,
                  required Future<bool> Function(ProjectCreateParams)
                      onConfirmData,
                  required void Function(String txId) onSuccessTransaction})?
              doSubmitProject) =>
      _$this._doSubmitProject = doSubmitProject;

  Future<void> Function(ProjectCreateParams params)? _doSubmitCreateProject;
  Future<void> Function(ProjectCreateParams params)?
      get doSubmitCreateProject => _$this._doSubmitCreateProject;
  set doSubmitCreateProject(
          Future<void> Function(ProjectCreateParams params)?
              doSubmitCreateProject) =>
      _$this._doSubmitCreateProject = doSubmitCreateProject;

  Future<void> Function(ProjectCreateParams params)? _doSaveToCache;
  Future<void> Function(ProjectCreateParams params)? get doSaveToCache =>
      _$this._doSaveToCache;
  set doSaveToCache(
          Future<void> Function(ProjectCreateParams params)? doSaveToCache) =>
      _$this._doSaveToCache = doSaveToCache;

  Future<void> Function()? _getProjectConfig;
  Future<void> Function()? get getProjectConfig => _$this._getProjectConfig;
  set getProjectConfig(Future<void> Function()? getProjectConfig) =>
      _$this._getProjectConfig = getProjectConfig;

  ProjectApplyVMBuilder();

  ProjectApplyVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastProjectCreateParams = $v.lastProjectCreateParams?.toBuilder();
      _projectRules = $v.projectRules;
      _getCoinBalance = $v.getCoinBalance;
      _getCoinInfo = $v.getCoinInfo;
      _doUnlockHDWallet = $v.doUnlockHDWallet;
      _doSubmitProject = $v.doSubmitProject;
      _doSubmitCreateProject = $v.doSubmitCreateProject;
      _doSaveToCache = $v.doSaveToCache;
      _getProjectConfig = $v.getProjectConfig;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectApplyVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectApplyVM;
  }

  @override
  void update(void Function(ProjectApplyVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectApplyVM build() => _build();

  _$ProjectApplyVM _build() {
    _$ProjectApplyVM _$result;
    try {
      _$result = _$v ??
          new _$ProjectApplyVM._(
              lastProjectCreateParams: _lastProjectCreateParams?.build(),
              projectRules: projectRules,
              getCoinBalance: BuiltValueNullFieldError.checkNotNull(
                  getCoinBalance, r'ProjectApplyVM', 'getCoinBalance'),
              getCoinInfo: BuiltValueNullFieldError.checkNotNull(
                  getCoinInfo, r'ProjectApplyVM', 'getCoinInfo'),
              doUnlockHDWallet: BuiltValueNullFieldError.checkNotNull(
                  doUnlockHDWallet, r'ProjectApplyVM', 'doUnlockHDWallet'),
              doSubmitProject: BuiltValueNullFieldError.checkNotNull(
                  doSubmitProject, r'ProjectApplyVM', 'doSubmitProject'),
              doSubmitCreateProject: BuiltValueNullFieldError.checkNotNull(
                  doSubmitCreateProject,
                  r'ProjectApplyVM',
                  'doSubmitCreateProject'),
              doSaveToCache: BuiltValueNullFieldError.checkNotNull(
                  doSaveToCache, r'ProjectApplyVM', 'doSaveToCache'),
              getProjectConfig: BuiltValueNullFieldError.checkNotNull(
                  getProjectConfig, r'ProjectApplyVM', 'getProjectConfig'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lastProjectCreateParams';
        _lastProjectCreateParams?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProjectApplyVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProjectDetailVM extends ProjectDetailVM {
  @override
  final Future<ProjectInfo> Function(int projectId) getProjectDetail;
  @override
  final Future<void> Function(int id) setActivePool;

  factory _$ProjectDetailVM([void Function(ProjectDetailVMBuilder)? updates]) =>
      (new ProjectDetailVMBuilder()..update(updates))._build();

  _$ProjectDetailVM._(
      {required this.getProjectDetail, required this.setActivePool})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        getProjectDetail, r'ProjectDetailVM', 'getProjectDetail');
    BuiltValueNullFieldError.checkNotNull(
        setActivePool, r'ProjectDetailVM', 'setActivePool');
  }

  @override
  ProjectDetailVM rebuild(void Function(ProjectDetailVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectDetailVMBuilder toBuilder() =>
      new ProjectDetailVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectDetailVM;
  }

  @override
  int get hashCode {
    return 924508676;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectDetailVM')
          ..add('getProjectDetail', getProjectDetail)
          ..add('setActivePool', setActivePool))
        .toString();
  }
}

class ProjectDetailVMBuilder
    implements Builder<ProjectDetailVM, ProjectDetailVMBuilder> {
  _$ProjectDetailVM? _$v;

  Future<ProjectInfo> Function(int projectId)? _getProjectDetail;
  Future<ProjectInfo> Function(int projectId)? get getProjectDetail =>
      _$this._getProjectDetail;
  set getProjectDetail(
          Future<ProjectInfo> Function(int projectId)? getProjectDetail) =>
      _$this._getProjectDetail = getProjectDetail;

  Future<void> Function(int id)? _setActivePool;
  Future<void> Function(int id)? get setActivePool => _$this._setActivePool;
  set setActivePool(Future<void> Function(int id)? setActivePool) =>
      _$this._setActivePool = setActivePool;

  ProjectDetailVMBuilder();

  ProjectDetailVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _getProjectDetail = $v.getProjectDetail;
      _setActivePool = $v.setActivePool;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectDetailVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectDetailVM;
  }

  @override
  void update(void Function(ProjectDetailVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectDetailVM build() => _build();

  _$ProjectDetailVM _build() {
    final _$result = _$v ??
        new _$ProjectDetailVM._(
            getProjectDetail: BuiltValueNullFieldError.checkNotNull(
                getProjectDetail, r'ProjectDetailVM', 'getProjectDetail'),
            setActivePool: BuiltValueNullFieldError.checkNotNull(
                setActivePool, r'ProjectDetailVM', 'setActivePool'));
    replace(_$result);
    return _$result;
  }
}

class _$ProjectListVM extends ProjectListVM {
  @override
  final BuiltList<ProjectInfo> projectsList;
  @override
  final Future<int> Function({required bool isRefresh, required int skip})
      loadData;

  factory _$ProjectListVM([void Function(ProjectListVMBuilder)? updates]) =>
      (new ProjectListVMBuilder()..update(updates))._build();

  _$ProjectListVM._({required this.projectsList, required this.loadData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        projectsList, r'ProjectListVM', 'projectsList');
    BuiltValueNullFieldError.checkNotNull(
        loadData, r'ProjectListVM', 'loadData');
  }

  @override
  ProjectListVM rebuild(void Function(ProjectListVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectListVMBuilder toBuilder() => new ProjectListVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectListVM && projectsList == other.projectsList;
  }

  @override
  int get hashCode {
    return $jf($jc(0, projectsList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectListVM')
          ..add('projectsList', projectsList)
          ..add('loadData', loadData))
        .toString();
  }
}

class ProjectListVMBuilder
    implements Builder<ProjectListVM, ProjectListVMBuilder> {
  _$ProjectListVM? _$v;

  ListBuilder<ProjectInfo>? _projectsList;
  ListBuilder<ProjectInfo> get projectsList =>
      _$this._projectsList ??= new ListBuilder<ProjectInfo>();
  set projectsList(ListBuilder<ProjectInfo>? projectsList) =>
      _$this._projectsList = projectsList;

  Future<int> Function({required bool isRefresh, required int skip})? _loadData;
  Future<int> Function({required bool isRefresh, required int skip})?
      get loadData => _$this._loadData;
  set loadData(
          Future<int> Function({required bool isRefresh, required int skip})?
              loadData) =>
      _$this._loadData = loadData;

  ProjectListVMBuilder();

  ProjectListVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _projectsList = $v.projectsList.toBuilder();
      _loadData = $v.loadData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectListVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectListVM;
  }

  @override
  void update(void Function(ProjectListVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectListVM build() => _build();

  _$ProjectListVM _build() {
    _$ProjectListVM _$result;
    try {
      _$result = _$v ??
          new _$ProjectListVM._(
              projectsList: projectsList.build(),
              loadData: BuiltValueNullFieldError.checkNotNull(
                  loadData, r'ProjectListVM', 'loadData'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'projectsList';
        projectsList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProjectListVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProjectCreateMint extends ProjectCreateMint {
  @override
  final int index;
  @override
  final String month;
  @override
  final String ratio;

  factory _$ProjectCreateMint(
          [void Function(ProjectCreateMintBuilder)? updates]) =>
      (new ProjectCreateMintBuilder()..update(updates))._build();

  _$ProjectCreateMint._(
      {required this.index, required this.month, required this.ratio})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(index, r'ProjectCreateMint', 'index');
    BuiltValueNullFieldError.checkNotNull(month, r'ProjectCreateMint', 'month');
    BuiltValueNullFieldError.checkNotNull(ratio, r'ProjectCreateMint', 'ratio');
  }

  @override
  ProjectCreateMint rebuild(void Function(ProjectCreateMintBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectCreateMintBuilder toBuilder() =>
      new ProjectCreateMintBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectCreateMint &&
        index == other.index &&
        month == other.month &&
        ratio == other.ratio;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, index.hashCode), month.hashCode), ratio.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectCreateMint')
          ..add('index', index)
          ..add('month', month)
          ..add('ratio', ratio))
        .toString();
  }
}

class ProjectCreateMintBuilder
    implements Builder<ProjectCreateMint, ProjectCreateMintBuilder> {
  _$ProjectCreateMint? _$v;

  int? _index;
  int? get index => _$this._index;
  set index(int? index) => _$this._index = index;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  String? _ratio;
  String? get ratio => _$this._ratio;
  set ratio(String? ratio) => _$this._ratio = ratio;

  ProjectCreateMintBuilder();

  ProjectCreateMintBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _index = $v.index;
      _month = $v.month;
      _ratio = $v.ratio;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectCreateMint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectCreateMint;
  }

  @override
  void update(void Function(ProjectCreateMintBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectCreateMint build() => _build();

  _$ProjectCreateMint _build() {
    final _$result = _$v ??
        new _$ProjectCreateMint._(
            index: BuiltValueNullFieldError.checkNotNull(
                index, r'ProjectCreateMint', 'index'),
            month: BuiltValueNullFieldError.checkNotNull(
                month, r'ProjectCreateMint', 'month'),
            ratio: BuiltValueNullFieldError.checkNotNull(
                ratio, r'ProjectCreateMint', 'ratio'));
    replace(_$result);
    return _$result;
  }
}

class _$ProjectConfig extends ProjectConfig {
  @override
  final String? instructions;
  @override
  final double? id;

  factory _$ProjectConfig([void Function(ProjectConfigBuilder)? updates]) =>
      (new ProjectConfigBuilder()..update(updates))._build();

  _$ProjectConfig._({this.instructions, this.id}) : super._();

  @override
  ProjectConfig rebuild(void Function(ProjectConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectConfigBuilder toBuilder() => new ProjectConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectConfig &&
        instructions == other.instructions &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, instructions.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectConfig')
          ..add('instructions', instructions)
          ..add('id', id))
        .toString();
  }
}

class ProjectConfigBuilder
    implements Builder<ProjectConfig, ProjectConfigBuilder> {
  _$ProjectConfig? _$v;

  String? _instructions;
  String? get instructions => _$this._instructions;
  set instructions(String? instructions) => _$this._instructions = instructions;

  double? _id;
  double? get id => _$this._id;
  set id(double? id) => _$this._id = id;

  ProjectConfigBuilder();

  ProjectConfigBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _instructions = $v.instructions;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectConfig other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectConfig;
  }

  @override
  void update(void Function(ProjectConfigBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectConfig build() => _build();

  _$ProjectConfig _build() {
    final _$result =
        _$v ?? new _$ProjectConfig._(instructions: instructions, id: id);
    replace(_$result);
    return _$result;
  }
}

class _$ProjectCreateParams extends ProjectCreateParams {
  @override
  final String projectName;
  @override
  final String projectDescription;
  @override
  final String coinName;
  @override
  final String price;
  @override
  final String amount;
  @override
  final String issuerName;
  @override
  final String webUrl;
  @override
  final String email;
  @override
  final String poolMinCurrency;
  @override
  final String poolCycle;
  @override
  final String poolInitAmount;
  @override
  final bool poolEnable;
  @override
  final String remainPoolMonths;
  @override
  final String remainPoolAmount;
  @override
  final String minBalance;
  @override
  final BuiltList<ProjectCreateMint> mintList;
  @override
  final String? chain;
  @override
  final String? symbol;
  @override
  final String? txId;
  @override
  final String? address;
  @override
  final WalletWithdrawData? withdrawData;
  @override
  final double? withdrawAmount;
  @override
  final int? submittedAt;

  factory _$ProjectCreateParams(
          [void Function(ProjectCreateParamsBuilder)? updates]) =>
      (new ProjectCreateParamsBuilder()..update(updates))._build();

  _$ProjectCreateParams._(
      {required this.projectName,
      required this.projectDescription,
      required this.coinName,
      required this.price,
      required this.amount,
      required this.issuerName,
      required this.webUrl,
      required this.email,
      required this.poolMinCurrency,
      required this.poolCycle,
      required this.poolInitAmount,
      required this.poolEnable,
      required this.remainPoolMonths,
      required this.remainPoolAmount,
      required this.minBalance,
      required this.mintList,
      this.chain,
      this.symbol,
      this.txId,
      this.address,
      this.withdrawData,
      this.withdrawAmount,
      this.submittedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        projectName, r'ProjectCreateParams', 'projectName');
    BuiltValueNullFieldError.checkNotNull(
        projectDescription, r'ProjectCreateParams', 'projectDescription');
    BuiltValueNullFieldError.checkNotNull(
        coinName, r'ProjectCreateParams', 'coinName');
    BuiltValueNullFieldError.checkNotNull(
        price, r'ProjectCreateParams', 'price');
    BuiltValueNullFieldError.checkNotNull(
        amount, r'ProjectCreateParams', 'amount');
    BuiltValueNullFieldError.checkNotNull(
        issuerName, r'ProjectCreateParams', 'issuerName');
    BuiltValueNullFieldError.checkNotNull(
        webUrl, r'ProjectCreateParams', 'webUrl');
    BuiltValueNullFieldError.checkNotNull(
        email, r'ProjectCreateParams', 'email');
    BuiltValueNullFieldError.checkNotNull(
        poolMinCurrency, r'ProjectCreateParams', 'poolMinCurrency');
    BuiltValueNullFieldError.checkNotNull(
        poolCycle, r'ProjectCreateParams', 'poolCycle');
    BuiltValueNullFieldError.checkNotNull(
        poolInitAmount, r'ProjectCreateParams', 'poolInitAmount');
    BuiltValueNullFieldError.checkNotNull(
        poolEnable, r'ProjectCreateParams', 'poolEnable');
    BuiltValueNullFieldError.checkNotNull(
        remainPoolMonths, r'ProjectCreateParams', 'remainPoolMonths');
    BuiltValueNullFieldError.checkNotNull(
        remainPoolAmount, r'ProjectCreateParams', 'remainPoolAmount');
    BuiltValueNullFieldError.checkNotNull(
        minBalance, r'ProjectCreateParams', 'minBalance');
    BuiltValueNullFieldError.checkNotNull(
        mintList, r'ProjectCreateParams', 'mintList');
  }

  @override
  ProjectCreateParams rebuild(
          void Function(ProjectCreateParamsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectCreateParamsBuilder toBuilder() =>
      new ProjectCreateParamsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectCreateParams &&
        projectName == other.projectName &&
        projectDescription == other.projectDescription &&
        coinName == other.coinName &&
        price == other.price &&
        amount == other.amount &&
        issuerName == other.issuerName &&
        webUrl == other.webUrl &&
        email == other.email &&
        poolMinCurrency == other.poolMinCurrency &&
        poolCycle == other.poolCycle &&
        poolInitAmount == other.poolInitAmount &&
        poolEnable == other.poolEnable &&
        remainPoolMonths == other.remainPoolMonths &&
        remainPoolAmount == other.remainPoolAmount &&
        minBalance == other.minBalance &&
        mintList == other.mintList &&
        chain == other.chain &&
        symbol == other.symbol &&
        txId == other.txId &&
        address == other.address &&
        withdrawData == other.withdrawData &&
        withdrawAmount == other.withdrawAmount &&
        submittedAt == other.submittedAt;
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
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc(0, projectName.hashCode), projectDescription.hashCode), coinName.hashCode), price.hashCode),
                                                                                amount.hashCode),
                                                                            issuerName.hashCode),
                                                                        webUrl.hashCode),
                                                                    email.hashCode),
                                                                poolMinCurrency.hashCode),
                                                            poolCycle.hashCode),
                                                        poolInitAmount.hashCode),
                                                    poolEnable.hashCode),
                                                remainPoolMonths.hashCode),
                                            remainPoolAmount.hashCode),
                                        minBalance.hashCode),
                                    mintList.hashCode),
                                chain.hashCode),
                            symbol.hashCode),
                        txId.hashCode),
                    address.hashCode),
                withdrawData.hashCode),
            withdrawAmount.hashCode),
        submittedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectCreateParams')
          ..add('projectName', projectName)
          ..add('projectDescription', projectDescription)
          ..add('coinName', coinName)
          ..add('price', price)
          ..add('amount', amount)
          ..add('issuerName', issuerName)
          ..add('webUrl', webUrl)
          ..add('email', email)
          ..add('poolMinCurrency', poolMinCurrency)
          ..add('poolCycle', poolCycle)
          ..add('poolInitAmount', poolInitAmount)
          ..add('poolEnable', poolEnable)
          ..add('remainPoolMonths', remainPoolMonths)
          ..add('remainPoolAmount', remainPoolAmount)
          ..add('minBalance', minBalance)
          ..add('mintList', mintList)
          ..add('chain', chain)
          ..add('symbol', symbol)
          ..add('txId', txId)
          ..add('address', address)
          ..add('withdrawData', withdrawData)
          ..add('withdrawAmount', withdrawAmount)
          ..add('submittedAt', submittedAt))
        .toString();
  }
}

class ProjectCreateParamsBuilder
    implements Builder<ProjectCreateParams, ProjectCreateParamsBuilder> {
  _$ProjectCreateParams? _$v;

  String? _projectName;
  String? get projectName => _$this._projectName;
  set projectName(String? projectName) => _$this._projectName = projectName;

  String? _projectDescription;
  String? get projectDescription => _$this._projectDescription;
  set projectDescription(String? projectDescription) =>
      _$this._projectDescription = projectDescription;

  String? _coinName;
  String? get coinName => _$this._coinName;
  set coinName(String? coinName) => _$this._coinName = coinName;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _issuerName;
  String? get issuerName => _$this._issuerName;
  set issuerName(String? issuerName) => _$this._issuerName = issuerName;

  String? _webUrl;
  String? get webUrl => _$this._webUrl;
  set webUrl(String? webUrl) => _$this._webUrl = webUrl;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _poolMinCurrency;
  String? get poolMinCurrency => _$this._poolMinCurrency;
  set poolMinCurrency(String? poolMinCurrency) =>
      _$this._poolMinCurrency = poolMinCurrency;

  String? _poolCycle;
  String? get poolCycle => _$this._poolCycle;
  set poolCycle(String? poolCycle) => _$this._poolCycle = poolCycle;

  String? _poolInitAmount;
  String? get poolInitAmount => _$this._poolInitAmount;
  set poolInitAmount(String? poolInitAmount) =>
      _$this._poolInitAmount = poolInitAmount;

  bool? _poolEnable;
  bool? get poolEnable => _$this._poolEnable;
  set poolEnable(bool? poolEnable) => _$this._poolEnable = poolEnable;

  String? _remainPoolMonths;
  String? get remainPoolMonths => _$this._remainPoolMonths;
  set remainPoolMonths(String? remainPoolMonths) =>
      _$this._remainPoolMonths = remainPoolMonths;

  String? _remainPoolAmount;
  String? get remainPoolAmount => _$this._remainPoolAmount;
  set remainPoolAmount(String? remainPoolAmount) =>
      _$this._remainPoolAmount = remainPoolAmount;

  String? _minBalance;
  String? get minBalance => _$this._minBalance;
  set minBalance(String? minBalance) => _$this._minBalance = minBalance;

  ListBuilder<ProjectCreateMint>? _mintList;
  ListBuilder<ProjectCreateMint> get mintList =>
      _$this._mintList ??= new ListBuilder<ProjectCreateMint>();
  set mintList(ListBuilder<ProjectCreateMint>? mintList) =>
      _$this._mintList = mintList;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(String? chain) => _$this._chain = chain;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _txId;
  String? get txId => _$this._txId;
  set txId(String? txId) => _$this._txId = txId;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  WalletWithdrawData? _withdrawData;
  WalletWithdrawData? get withdrawData => _$this._withdrawData;
  set withdrawData(WalletWithdrawData? withdrawData) =>
      _$this._withdrawData = withdrawData;

  double? _withdrawAmount;
  double? get withdrawAmount => _$this._withdrawAmount;
  set withdrawAmount(double? withdrawAmount) =>
      _$this._withdrawAmount = withdrawAmount;

  int? _submittedAt;
  int? get submittedAt => _$this._submittedAt;
  set submittedAt(int? submittedAt) => _$this._submittedAt = submittedAt;

  ProjectCreateParamsBuilder();

  ProjectCreateParamsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _projectName = $v.projectName;
      _projectDescription = $v.projectDescription;
      _coinName = $v.coinName;
      _price = $v.price;
      _amount = $v.amount;
      _issuerName = $v.issuerName;
      _webUrl = $v.webUrl;
      _email = $v.email;
      _poolMinCurrency = $v.poolMinCurrency;
      _poolCycle = $v.poolCycle;
      _poolInitAmount = $v.poolInitAmount;
      _poolEnable = $v.poolEnable;
      _remainPoolMonths = $v.remainPoolMonths;
      _remainPoolAmount = $v.remainPoolAmount;
      _minBalance = $v.minBalance;
      _mintList = $v.mintList.toBuilder();
      _chain = $v.chain;
      _symbol = $v.symbol;
      _txId = $v.txId;
      _address = $v.address;
      _withdrawData = $v.withdrawData;
      _withdrawAmount = $v.withdrawAmount;
      _submittedAt = $v.submittedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectCreateParams other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectCreateParams;
  }

  @override
  void update(void Function(ProjectCreateParamsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectCreateParams build() => _build();

  _$ProjectCreateParams _build() {
    _$ProjectCreateParams _$result;
    try {
      _$result = _$v ??
          new _$ProjectCreateParams._(
              projectName: BuiltValueNullFieldError.checkNotNull(
                  projectName, r'ProjectCreateParams', 'projectName'),
              projectDescription: BuiltValueNullFieldError.checkNotNull(
                  projectDescription,
                  r'ProjectCreateParams',
                  'projectDescription'),
              coinName: BuiltValueNullFieldError.checkNotNull(
                  coinName, r'ProjectCreateParams', 'coinName'),
              price: BuiltValueNullFieldError.checkNotNull(
                  price, r'ProjectCreateParams', 'price'),
              amount: BuiltValueNullFieldError.checkNotNull(
                  amount, r'ProjectCreateParams', 'amount'),
              issuerName: BuiltValueNullFieldError.checkNotNull(
                  issuerName, r'ProjectCreateParams', 'issuerName'),
              webUrl: BuiltValueNullFieldError.checkNotNull(
                  webUrl, r'ProjectCreateParams', 'webUrl'),
              email: BuiltValueNullFieldError.checkNotNull(email, r'ProjectCreateParams', 'email'),
              poolMinCurrency: BuiltValueNullFieldError.checkNotNull(poolMinCurrency, r'ProjectCreateParams', 'poolMinCurrency'),
              poolCycle: BuiltValueNullFieldError.checkNotNull(poolCycle, r'ProjectCreateParams', 'poolCycle'),
              poolInitAmount: BuiltValueNullFieldError.checkNotNull(poolInitAmount, r'ProjectCreateParams', 'poolInitAmount'),
              poolEnable: BuiltValueNullFieldError.checkNotNull(poolEnable, r'ProjectCreateParams', 'poolEnable'),
              remainPoolMonths: BuiltValueNullFieldError.checkNotNull(remainPoolMonths, r'ProjectCreateParams', 'remainPoolMonths'),
              remainPoolAmount: BuiltValueNullFieldError.checkNotNull(remainPoolAmount, r'ProjectCreateParams', 'remainPoolAmount'),
              minBalance: BuiltValueNullFieldError.checkNotNull(minBalance, r'ProjectCreateParams', 'minBalance'),
              mintList: mintList.build(),
              chain: chain,
              symbol: symbol,
              txId: txId,
              address: address,
              withdrawData: withdrawData,
              withdrawAmount: withdrawAmount,
              submittedAt: submittedAt);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mintList';
        mintList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProjectCreateParams', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProjectInfo extends ProjectInfo {
  @override
  final int? id;
  @override
  final String? symbol;
  @override
  final String? currencyPrice;
  @override
  final String? initAmount;
  @override
  final String? projectName;
  @override
  final double? targetNumber;
  @override
  final double? inviteNumber;
  @override
  final String? fork;
  @override
  final String? totalAmount;
  @override
  final String? ownerWebsite;
  @override
  final BuiltMap<String, String>? ownerName;
  @override
  final BuiltMap<String, String>? projectDescription;
  @override
  final int? status;
  @override
  final int? miningPoolStatus;
  @override
  final String? iconUrl;

  factory _$ProjectInfo([void Function(ProjectInfoBuilder)? updates]) =>
      (new ProjectInfoBuilder()..update(updates))._build();

  _$ProjectInfo._(
      {this.id,
      this.symbol,
      this.currencyPrice,
      this.initAmount,
      this.projectName,
      this.targetNumber,
      this.inviteNumber,
      this.fork,
      this.totalAmount,
      this.ownerWebsite,
      this.ownerName,
      this.projectDescription,
      this.status,
      this.miningPoolStatus,
      this.iconUrl})
      : super._();

  @override
  ProjectInfo rebuild(void Function(ProjectInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectInfoBuilder toBuilder() => new ProjectInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectInfo &&
        id == other.id &&
        symbol == other.symbol &&
        currencyPrice == other.currencyPrice &&
        initAmount == other.initAmount &&
        projectName == other.projectName &&
        targetNumber == other.targetNumber &&
        inviteNumber == other.inviteNumber &&
        fork == other.fork &&
        totalAmount == other.totalAmount &&
        ownerWebsite == other.ownerWebsite &&
        ownerName == other.ownerName &&
        projectDescription == other.projectDescription &&
        status == other.status &&
        miningPoolStatus == other.miningPoolStatus &&
        iconUrl == other.iconUrl;
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
                                                        $jc($jc(0, id.hashCode),
                                                            symbol.hashCode),
                                                        currencyPrice.hashCode),
                                                    initAmount.hashCode),
                                                projectName.hashCode),
                                            targetNumber.hashCode),
                                        inviteNumber.hashCode),
                                    fork.hashCode),
                                totalAmount.hashCode),
                            ownerWebsite.hashCode),
                        ownerName.hashCode),
                    projectDescription.hashCode),
                status.hashCode),
            miningPoolStatus.hashCode),
        iconUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectInfo')
          ..add('id', id)
          ..add('symbol', symbol)
          ..add('currencyPrice', currencyPrice)
          ..add('initAmount', initAmount)
          ..add('projectName', projectName)
          ..add('targetNumber', targetNumber)
          ..add('inviteNumber', inviteNumber)
          ..add('fork', fork)
          ..add('totalAmount', totalAmount)
          ..add('ownerWebsite', ownerWebsite)
          ..add('ownerName', ownerName)
          ..add('projectDescription', projectDescription)
          ..add('status', status)
          ..add('miningPoolStatus', miningPoolStatus)
          ..add('iconUrl', iconUrl))
        .toString();
  }
}

class ProjectInfoBuilder implements Builder<ProjectInfo, ProjectInfoBuilder> {
  _$ProjectInfo? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _currencyPrice;
  String? get currencyPrice => _$this._currencyPrice;
  set currencyPrice(String? currencyPrice) =>
      _$this._currencyPrice = currencyPrice;

  String? _initAmount;
  String? get initAmount => _$this._initAmount;
  set initAmount(String? initAmount) => _$this._initAmount = initAmount;

  String? _projectName;
  String? get projectName => _$this._projectName;
  set projectName(String? projectName) => _$this._projectName = projectName;

  double? _targetNumber;
  double? get targetNumber => _$this._targetNumber;
  set targetNumber(double? targetNumber) => _$this._targetNumber = targetNumber;

  double? _inviteNumber;
  double? get inviteNumber => _$this._inviteNumber;
  set inviteNumber(double? inviteNumber) => _$this._inviteNumber = inviteNumber;

  String? _fork;
  String? get fork => _$this._fork;
  set fork(String? fork) => _$this._fork = fork;

  String? _totalAmount;
  String? get totalAmount => _$this._totalAmount;
  set totalAmount(String? totalAmount) => _$this._totalAmount = totalAmount;

  String? _ownerWebsite;
  String? get ownerWebsite => _$this._ownerWebsite;
  set ownerWebsite(String? ownerWebsite) => _$this._ownerWebsite = ownerWebsite;

  MapBuilder<String, String>? _ownerName;
  MapBuilder<String, String> get ownerName =>
      _$this._ownerName ??= new MapBuilder<String, String>();
  set ownerName(MapBuilder<String, String>? ownerName) =>
      _$this._ownerName = ownerName;

  MapBuilder<String, String>? _projectDescription;
  MapBuilder<String, String> get projectDescription =>
      _$this._projectDescription ??= new MapBuilder<String, String>();
  set projectDescription(MapBuilder<String, String>? projectDescription) =>
      _$this._projectDescription = projectDescription;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  int? _miningPoolStatus;
  int? get miningPoolStatus => _$this._miningPoolStatus;
  set miningPoolStatus(int? miningPoolStatus) =>
      _$this._miningPoolStatus = miningPoolStatus;

  String? _iconUrl;
  String? get iconUrl => _$this._iconUrl;
  set iconUrl(String? iconUrl) => _$this._iconUrl = iconUrl;

  ProjectInfoBuilder();

  ProjectInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _symbol = $v.symbol;
      _currencyPrice = $v.currencyPrice;
      _initAmount = $v.initAmount;
      _projectName = $v.projectName;
      _targetNumber = $v.targetNumber;
      _inviteNumber = $v.inviteNumber;
      _fork = $v.fork;
      _totalAmount = $v.totalAmount;
      _ownerWebsite = $v.ownerWebsite;
      _ownerName = $v.ownerName?.toBuilder();
      _projectDescription = $v.projectDescription?.toBuilder();
      _status = $v.status;
      _miningPoolStatus = $v.miningPoolStatus;
      _iconUrl = $v.iconUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectInfo;
  }

  @override
  void update(void Function(ProjectInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectInfo build() => _build();

  _$ProjectInfo _build() {
    _$ProjectInfo _$result;
    try {
      _$result = _$v ??
          new _$ProjectInfo._(
              id: id,
              symbol: symbol,
              currencyPrice: currencyPrice,
              initAmount: initAmount,
              projectName: projectName,
              targetNumber: targetNumber,
              inviteNumber: inviteNumber,
              fork: fork,
              totalAmount: totalAmount,
              ownerWebsite: ownerWebsite,
              ownerName: _ownerName?.build(),
              projectDescription: _projectDescription?.build(),
              status: status,
              miningPoolStatus: miningPoolStatus,
              iconUrl: iconUrl);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ownerName';
        _ownerName?.build();
        _$failedField = 'projectDescription';
        _projectDescription?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProjectInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProjectState extends ProjectState {
  @override
  final ProjectCreateParams? lastProjectCreateParams;
  @override
  final BuiltList<ProjectInfo> projectList;
  @override
  final ProjectConfig? projectConfig;

  factory _$ProjectState([void Function(ProjectStateBuilder)? updates]) =>
      (new ProjectStateBuilder()..update(updates))._build();

  _$ProjectState._(
      {this.lastProjectCreateParams,
      required this.projectList,
      this.projectConfig})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        projectList, r'ProjectState', 'projectList');
  }

  @override
  ProjectState rebuild(void Function(ProjectStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProjectStateBuilder toBuilder() => new ProjectStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProjectState &&
        lastProjectCreateParams == other.lastProjectCreateParams &&
        projectList == other.projectList &&
        projectConfig == other.projectConfig;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, lastProjectCreateParams.hashCode), projectList.hashCode),
        projectConfig.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProjectState')
          ..add('lastProjectCreateParams', lastProjectCreateParams)
          ..add('projectList', projectList)
          ..add('projectConfig', projectConfig))
        .toString();
  }
}

class ProjectStateBuilder
    implements Builder<ProjectState, ProjectStateBuilder> {
  _$ProjectState? _$v;

  ProjectCreateParamsBuilder? _lastProjectCreateParams;
  ProjectCreateParamsBuilder get lastProjectCreateParams =>
      _$this._lastProjectCreateParams ??= new ProjectCreateParamsBuilder();
  set lastProjectCreateParams(
          ProjectCreateParamsBuilder? lastProjectCreateParams) =>
      _$this._lastProjectCreateParams = lastProjectCreateParams;

  ListBuilder<ProjectInfo>? _projectList;
  ListBuilder<ProjectInfo> get projectList =>
      _$this._projectList ??= new ListBuilder<ProjectInfo>();
  set projectList(ListBuilder<ProjectInfo>? projectList) =>
      _$this._projectList = projectList;

  ProjectConfigBuilder? _projectConfig;
  ProjectConfigBuilder get projectConfig =>
      _$this._projectConfig ??= new ProjectConfigBuilder();
  set projectConfig(ProjectConfigBuilder? projectConfig) =>
      _$this._projectConfig = projectConfig;

  ProjectStateBuilder();

  ProjectStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastProjectCreateParams = $v.lastProjectCreateParams?.toBuilder();
      _projectList = $v.projectList.toBuilder();
      _projectConfig = $v.projectConfig?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProjectState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProjectState;
  }

  @override
  void update(void Function(ProjectStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProjectState build() => _build();

  _$ProjectState _build() {
    _$ProjectState _$result;
    try {
      _$result = _$v ??
          new _$ProjectState._(
              lastProjectCreateParams: _lastProjectCreateParams?.build(),
              projectList: projectList.build(),
              projectConfig: _projectConfig?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lastProjectCreateParams';
        _lastProjectCreateParams?.build();
        _$failedField = 'projectList';
        projectList.build();
        _$failedField = 'projectConfig';
        _projectConfig?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProjectState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
