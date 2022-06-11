// GENERATED CODE - DO NOT MODIFY BY HAND

part of common_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Config> _$configSerializer = new _$ConfigSerializer();
Serializer<ConfigCoin> _$configCoinSerializer = new _$ConfigCoinSerializer();
Serializer<ConfigCoinFee> _$configCoinFeeSerializer =
    new _$ConfigCoinFeeSerializer();
Serializer<ConfigOtc> _$configOtcSerializer = new _$ConfigOtcSerializer();
Serializer<ConfigSystem> _$configSystemSerializer =
    new _$ConfigSystemSerializer();
Serializer<ConfigSystemApp> _$configSystemAppSerializer =
    new _$ConfigSystemAppSerializer();
Serializer<ConfigUpdate> _$configUpdateSerializer =
    new _$ConfigUpdateSerializer();
Serializer<ConfigUpdateData> _$configUpdateDataSerializer =
    new _$ConfigUpdateDataSerializer();
Serializer<CommonState> _$commonStateSerializer = new _$CommonStateSerializer();

class _$ConfigSerializer implements StructuredSerializer<Config> {
  @override
  final Iterable<Type> types = const [Config, _$Config];
  @override
  final String wireName = 'Config';

  @override
  Iterable<Object?> serialize(Serializers serializers, Config object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'currency',
      serializers.serialize(object.coins,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(ConfigCoin)])),
      'otc_on_chain',
      serializers.serialize(object.otc,
          specifiedType: const FullType(ConfigOtc)),
      'version',
      serializers.serialize(object.version,
          specifiedType: const FullType(ConfigUpdate)),
    ];
    Object? value;
    value = object.system;
    if (value != null) {
      result
        ..add('system_store')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ConfigSystem)));
    }
    return result;
  }

  @override
  Config deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'currency':
          result.coins.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(ConfigCoin)
              ]))!);
          break;
        case 'otc_on_chain':
          result.otc.replace(serializers.deserialize(value,
              specifiedType: const FullType(ConfigOtc))! as ConfigOtc);
          break;
        case 'system_store':
          result.system.replace(serializers.deserialize(value,
              specifiedType: const FullType(ConfigSystem))! as ConfigSystem);
          break;
        case 'version':
          result.version.replace(serializers.deserialize(value,
              specifiedType: const FullType(ConfigUpdate))! as ConfigUpdate);
          break;
      }
    }

    return result.build();
  }
}

class _$ConfigCoinSerializer implements StructuredSerializer<ConfigCoin> {
  @override
  final Iterable<Type> types = const [ConfigCoin, _$ConfigCoin];
  @override
  final String wireName = 'ConfigCoin';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConfigCoin object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'api_name',
      serializers.serialize(object.symbol,
          specifiedType: const FullType(String)),
      'net_type',
      serializers.serialize(object.chain,
          specifiedType: const FullType(String)),
      'english_name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'full_name',
      serializers.serialize(object.fullName,
          specifiedType: const FullType(String)),
      'icon_url',
      serializers.serialize(object.icon, specifiedType: const FullType(String)),
      'transfer_fee',
      serializers.serialize(object.transferFee,
          specifiedType: const FullType(double)),
      'display_precision',
      serializers.serialize(object.displayPrecision,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.contract;
    if (value != null) {
      result
        ..add('anchor')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.chainPrecision;
    if (value != null) {
      result
        ..add('chain_precision')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.transferMinQuota;
    if (value != null) {
      result
        ..add('transfer_min_quota')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.defiReward;
    if (value != null) {
      result
        ..add('defi_reward')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.hdWalletFeeLevel;
    if (value != null) {
      result
        ..add('hd_wallet_fee_level')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ConfigCoinFee)));
    }
    return result;
  }

  @override
  ConfigCoin deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigCoinBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'api_name':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'net_type':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'english_name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'full_name':
          result.fullName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'icon_url':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'anchor':
          result.contract = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'transfer_fee':
          result.transferFee = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'chain_precision':
          result.chainPrecision = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'display_precision':
          result.displayPrecision = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'transfer_min_quota':
          result.transferMinQuota = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'defi_reward':
          result.defiReward = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'hd_wallet_fee_level':
          result.hdWalletFeeLevel.replace(serializers.deserialize(value,
              specifiedType: const FullType(ConfigCoinFee))! as ConfigCoinFee);
          break;
      }
    }

    return result.build();
  }
}

class _$ConfigCoinFeeSerializer implements StructuredSerializer<ConfigCoinFee> {
  @override
  final Iterable<Type> types = const [ConfigCoinFee, _$ConfigCoinFee];
  @override
  final String wireName = 'ConfigCoinFee';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConfigCoinFee object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'enable',
      serializers.serialize(object.enable, specifiedType: const FullType(bool)),
      'level',
      serializers.serialize(object.level,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(double)])),
    ];

    return result;
  }

  @override
  ConfigCoinFee deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigCoinFeeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'enable':
          result.enable = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'level':
          result.level.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(double)]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$ConfigOtcSerializer implements StructuredSerializer<ConfigOtc> {
  @override
  final Iterable<Type> types = const [ConfigOtc, _$ConfigOtc];
  @override
  final String wireName = 'ConfigOtc';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConfigOtc object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'system_otc_address',
      serializers.serialize(object.systemOtcAddress,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'system_deposit_address',
      serializers.serialize(object.systemDepositAddress,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.enable;
    if (value != null) {
      result
        ..add('enable')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.maxAds;
    if (value != null) {
      result
        ..add('max_ads')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.tradePairs;
    if (value != null) {
      result
        ..add('trade_pair')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)])
            ])));
    }
    value = object.depositAmount;
    if (value != null) {
      result
        ..add('deposit_fee')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.depositCurrency;
    if (value != null) {
      result
        ..add('deposit_currency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ConfigOtc deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigOtcBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'enable':
          result.enable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'max_ads':
          result.maxAds = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'trade_pair':
          result.tradePairs.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ]))!);
          break;
        case 'deposit_fee':
          result.depositAmount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'deposit_currency':
          result.depositCurrency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'system_otc_address':
          result.systemOtcAddress.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'system_deposit_address':
          result.systemDepositAddress = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ConfigSystemSerializer implements StructuredSerializer<ConfigSystem> {
  @override
  final Iterable<Type> types = const [ConfigSystem, _$ConfigSystem];
  @override
  final String wireName = 'ConfigSystem';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConfigSystem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.config;
    if (value != null) {
      result
        ..add('config')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(ConfigSystemApp)
            ])));
    }
    return result;
  }

  @override
  ConfigSystem deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigSystemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'config':
          result.config.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(ConfigSystemApp)
              ]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$ConfigSystemAppSerializer
    implements StructuredSerializer<ConfigSystemApp> {
  @override
  final Iterable<Type> types = const [ConfigSystemApp, _$ConfigSystemApp];
  @override
  final String wireName = 'ConfigSystemApp';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConfigSystemApp object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.enable;
    if (value != null) {
      result
        ..add('enable')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ConfigSystemApp deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigSystemAppBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'enable':
          result.enable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$ConfigUpdateSerializer implements StructuredSerializer<ConfigUpdate> {
  @override
  final Iterable<Type> types = const [ConfigUpdate, _$ConfigUpdate];
  @override
  final String wireName = 'ConfigUpdate';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConfigUpdate object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.needUpdate;
    if (value != null) {
      result
        ..add('update')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ConfigUpdateData)));
    }
    return result;
  }

  @override
  ConfigUpdate deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigUpdateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'update':
          result.needUpdate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(ConfigUpdateData))!
              as ConfigUpdateData);
          break;
      }
    }

    return result.build();
  }
}

class _$ConfigUpdateDataSerializer
    implements StructuredSerializer<ConfigUpdateData> {
  @override
  final Iterable<Type> types = const [ConfigUpdateData, _$ConfigUpdateData];
  @override
  final String wireName = 'ConfigUpdateData';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConfigUpdateData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.version;
    if (value != null) {
      result
        ..add('version')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.forceUpdate;
    if (value != null) {
      result
        ..add('force_update')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.downloadUrl;
    if (value != null) {
      result
        ..add('download_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.disabledModules;
    if (value != null) {
      result
        ..add('disable_functions')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])));
    }
    return result;
  }

  @override
  ConfigUpdateData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConfigUpdateDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'version':
          result.version = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'force_update':
          result.forceUpdate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'download_url':
          result.downloadUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'disable_functions':
          result.disabledModules.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$CommonStateSerializer implements StructuredSerializer<CommonState> {
  @override
  final Iterable<Type> types = const [CommonState, _$CommonState];
  @override
  final String wireName = 'CommonState';

  @override
  Iterable<Object?> serialize(Serializers serializers, CommonState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.config;
    if (value != null) {
      result
        ..add('config')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Config)));
    }
    value = object.configState;
    if (value != null) {
      result
        ..add('configState')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.appInfo;
    if (value != null) {
      result
        ..add('appInfo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(PackageInfo)));
    }
    value = object.deviceId;
    if (value != null) {
      result
        ..add('deviceId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.language;
    if (value != null) {
      result
        ..add('language')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fiatCurrency;
    if (value != null) {
      result
        ..add('fiatCurrency')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.newVersion;
    if (value != null) {
      result
        ..add('newVersion')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ConfigUpdate)));
    }
    return result;
  }

  @override
  CommonState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommonStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'config':
          result.config.replace(serializers.deserialize(value,
              specifiedType: const FullType(Config))! as Config);
          break;
        case 'configState':
          result.configState = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'appInfo':
          result.appInfo = serializers.deserialize(value,
              specifiedType: const FullType(PackageInfo)) as PackageInfo?;
          break;
        case 'deviceId':
          result.deviceId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'language':
          result.language = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'fiatCurrency':
          result.fiatCurrency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'newVersion':
          result.newVersion.replace(serializers.deserialize(value,
              specifiedType: const FullType(ConfigUpdate))! as ConfigUpdate);
          break;
      }
    }

    return result.build();
  }
}

class _$AppCommonVM extends AppCommonVM {
  @override
  final List<String> debugStrings;
  @override
  final bool hasWallet;
  @override
  final String activeWalletId;
  @override
  final String activeWalletName;
  @override
  final String fiatCurrency;
  @override
  final String appVersion;
  @override
  final String appVersionBeta;
  @override
  final bool hasNewVersion;
  @override
  final Future<ConfigUpdateData> Function(bool checkBeta) doCheckForUpdates;
  @override
  final Future<void> Function(String language) doChangeLanguage;

  factory _$AppCommonVM([void Function(AppCommonVMBuilder)? updates]) =>
      (new AppCommonVMBuilder()..update(updates))._build();

  _$AppCommonVM._(
      {required this.debugStrings,
      required this.hasWallet,
      required this.activeWalletId,
      required this.activeWalletName,
      required this.fiatCurrency,
      required this.appVersion,
      required this.appVersionBeta,
      required this.hasNewVersion,
      required this.doCheckForUpdates,
      required this.doChangeLanguage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        debugStrings, r'AppCommonVM', 'debugStrings');
    BuiltValueNullFieldError.checkNotNull(
        hasWallet, r'AppCommonVM', 'hasWallet');
    BuiltValueNullFieldError.checkNotNull(
        activeWalletId, r'AppCommonVM', 'activeWalletId');
    BuiltValueNullFieldError.checkNotNull(
        activeWalletName, r'AppCommonVM', 'activeWalletName');
    BuiltValueNullFieldError.checkNotNull(
        fiatCurrency, r'AppCommonVM', 'fiatCurrency');
    BuiltValueNullFieldError.checkNotNull(
        appVersion, r'AppCommonVM', 'appVersion');
    BuiltValueNullFieldError.checkNotNull(
        appVersionBeta, r'AppCommonVM', 'appVersionBeta');
    BuiltValueNullFieldError.checkNotNull(
        hasNewVersion, r'AppCommonVM', 'hasNewVersion');
    BuiltValueNullFieldError.checkNotNull(
        doCheckForUpdates, r'AppCommonVM', 'doCheckForUpdates');
    BuiltValueNullFieldError.checkNotNull(
        doChangeLanguage, r'AppCommonVM', 'doChangeLanguage');
  }

  @override
  AppCommonVM rebuild(void Function(AppCommonVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppCommonVMBuilder toBuilder() => new AppCommonVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppCommonVM &&
        hasWallet == other.hasWallet &&
        activeWalletId == other.activeWalletId &&
        activeWalletName == other.activeWalletName &&
        fiatCurrency == other.fiatCurrency &&
        appVersion == other.appVersion &&
        appVersionBeta == other.appVersionBeta &&
        hasNewVersion == other.hasNewVersion;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, hasWallet.hashCode),
                            activeWalletId.hashCode),
                        activeWalletName.hashCode),
                    fiatCurrency.hashCode),
                appVersion.hashCode),
            appVersionBeta.hashCode),
        hasNewVersion.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppCommonVM')
          ..add('debugStrings', debugStrings)
          ..add('hasWallet', hasWallet)
          ..add('activeWalletId', activeWalletId)
          ..add('activeWalletName', activeWalletName)
          ..add('fiatCurrency', fiatCurrency)
          ..add('appVersion', appVersion)
          ..add('appVersionBeta', appVersionBeta)
          ..add('hasNewVersion', hasNewVersion)
          ..add('doCheckForUpdates', doCheckForUpdates)
          ..add('doChangeLanguage', doChangeLanguage))
        .toString();
  }
}

class AppCommonVMBuilder implements Builder<AppCommonVM, AppCommonVMBuilder> {
  _$AppCommonVM? _$v;

  List<String>? _debugStrings;
  List<String>? get debugStrings => _$this._debugStrings;
  set debugStrings(List<String>? debugStrings) =>
      _$this._debugStrings = debugStrings;

  bool? _hasWallet;
  bool? get hasWallet => _$this._hasWallet;
  set hasWallet(bool? hasWallet) => _$this._hasWallet = hasWallet;

  String? _activeWalletId;
  String? get activeWalletId => _$this._activeWalletId;
  set activeWalletId(String? activeWalletId) =>
      _$this._activeWalletId = activeWalletId;

  String? _activeWalletName;
  String? get activeWalletName => _$this._activeWalletName;
  set activeWalletName(String? activeWalletName) =>
      _$this._activeWalletName = activeWalletName;

  String? _fiatCurrency;
  String? get fiatCurrency => _$this._fiatCurrency;
  set fiatCurrency(String? fiatCurrency) => _$this._fiatCurrency = fiatCurrency;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  String? _appVersionBeta;
  String? get appVersionBeta => _$this._appVersionBeta;
  set appVersionBeta(String? appVersionBeta) =>
      _$this._appVersionBeta = appVersionBeta;

  bool? _hasNewVersion;
  bool? get hasNewVersion => _$this._hasNewVersion;
  set hasNewVersion(bool? hasNewVersion) =>
      _$this._hasNewVersion = hasNewVersion;

  Future<ConfigUpdateData> Function(bool checkBeta)? _doCheckForUpdates;
  Future<ConfigUpdateData> Function(bool checkBeta)? get doCheckForUpdates =>
      _$this._doCheckForUpdates;
  set doCheckForUpdates(
          Future<ConfigUpdateData> Function(bool checkBeta)?
              doCheckForUpdates) =>
      _$this._doCheckForUpdates = doCheckForUpdates;

  Future<void> Function(String language)? _doChangeLanguage;
  Future<void> Function(String language)? get doChangeLanguage =>
      _$this._doChangeLanguage;
  set doChangeLanguage(
          Future<void> Function(String language)? doChangeLanguage) =>
      _$this._doChangeLanguage = doChangeLanguage;

  AppCommonVMBuilder();

  AppCommonVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _debugStrings = $v.debugStrings;
      _hasWallet = $v.hasWallet;
      _activeWalletId = $v.activeWalletId;
      _activeWalletName = $v.activeWalletName;
      _fiatCurrency = $v.fiatCurrency;
      _appVersion = $v.appVersion;
      _appVersionBeta = $v.appVersionBeta;
      _hasNewVersion = $v.hasNewVersion;
      _doCheckForUpdates = $v.doCheckForUpdates;
      _doChangeLanguage = $v.doChangeLanguage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppCommonVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppCommonVM;
  }

  @override
  void update(void Function(AppCommonVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppCommonVM build() => _build();

  _$AppCommonVM _build() {
    final _$result = _$v ??
        new _$AppCommonVM._(
            debugStrings: BuiltValueNullFieldError.checkNotNull(
                debugStrings, r'AppCommonVM', 'debugStrings'),
            hasWallet: BuiltValueNullFieldError.checkNotNull(
                hasWallet, r'AppCommonVM', 'hasWallet'),
            activeWalletId: BuiltValueNullFieldError.checkNotNull(
                activeWalletId, r'AppCommonVM', 'activeWalletId'),
            activeWalletName: BuiltValueNullFieldError.checkNotNull(
                activeWalletName, r'AppCommonVM', 'activeWalletName'),
            fiatCurrency: BuiltValueNullFieldError.checkNotNull(
                fiatCurrency, r'AppCommonVM', 'fiatCurrency'),
            appVersion: BuiltValueNullFieldError.checkNotNull(
                appVersion, r'AppCommonVM', 'appVersion'),
            appVersionBeta: BuiltValueNullFieldError.checkNotNull(
                appVersionBeta, r'AppCommonVM', 'appVersionBeta'),
            hasNewVersion: BuiltValueNullFieldError.checkNotNull(
                hasNewVersion, r'AppCommonVM', 'hasNewVersion'),
            doCheckForUpdates: BuiltValueNullFieldError.checkNotNull(doCheckForUpdates, r'AppCommonVM', 'doCheckForUpdates'),
            doChangeLanguage: BuiltValueNullFieldError.checkNotNull(doChangeLanguage, r'AppCommonVM', 'doChangeLanguage'));
    replace(_$result);
    return _$result;
  }
}

class _$Config extends Config {
  @override
  final BuiltMap<String, ConfigCoin> coins;
  @override
  final ConfigOtc otc;
  @override
  final ConfigSystem? system;
  @override
  final ConfigUpdate version;

  factory _$Config([void Function(ConfigBuilder)? updates]) =>
      (new ConfigBuilder()..update(updates))._build();

  _$Config._(
      {required this.coins,
      required this.otc,
      this.system,
      required this.version})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(coins, r'Config', 'coins');
    BuiltValueNullFieldError.checkNotNull(otc, r'Config', 'otc');
    BuiltValueNullFieldError.checkNotNull(version, r'Config', 'version');
  }

  @override
  Config rebuild(void Function(ConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigBuilder toBuilder() => new ConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Config &&
        coins == other.coins &&
        otc == other.otc &&
        system == other.system &&
        version == other.version;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, coins.hashCode), otc.hashCode), system.hashCode),
        version.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Config')
          ..add('coins', coins)
          ..add('otc', otc)
          ..add('system', system)
          ..add('version', version))
        .toString();
  }
}

class ConfigBuilder implements Builder<Config, ConfigBuilder> {
  _$Config? _$v;

  MapBuilder<String, ConfigCoin>? _coins;
  MapBuilder<String, ConfigCoin> get coins =>
      _$this._coins ??= new MapBuilder<String, ConfigCoin>();
  set coins(MapBuilder<String, ConfigCoin>? coins) => _$this._coins = coins;

  ConfigOtcBuilder? _otc;
  ConfigOtcBuilder get otc => _$this._otc ??= new ConfigOtcBuilder();
  set otc(ConfigOtcBuilder? otc) => _$this._otc = otc;

  ConfigSystemBuilder? _system;
  ConfigSystemBuilder get system =>
      _$this._system ??= new ConfigSystemBuilder();
  set system(ConfigSystemBuilder? system) => _$this._system = system;

  ConfigUpdateBuilder? _version;
  ConfigUpdateBuilder get version =>
      _$this._version ??= new ConfigUpdateBuilder();
  set version(ConfigUpdateBuilder? version) => _$this._version = version;

  ConfigBuilder();

  ConfigBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coins = $v.coins.toBuilder();
      _otc = $v.otc.toBuilder();
      _system = $v.system?.toBuilder();
      _version = $v.version.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Config other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Config;
  }

  @override
  void update(void Function(ConfigBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Config build() => _build();

  _$Config _build() {
    _$Config _$result;
    try {
      _$result = _$v ??
          new _$Config._(
              coins: coins.build(),
              otc: otc.build(),
              system: _system?.build(),
              version: version.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coins';
        coins.build();
        _$failedField = 'otc';
        otc.build();
        _$failedField = 'system';
        _system?.build();
        _$failedField = 'version';
        version.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Config', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConfigCoin extends ConfigCoin {
  @override
  final String symbol;
  @override
  final String chain;
  @override
  final String name;
  @override
  final String fullName;
  @override
  final String icon;
  @override
  final String? contract;
  @override
  final double transferFee;
  @override
  final int? chainPrecision;
  @override
  final int displayPrecision;
  @override
  final double? transferMinQuota;
  @override
  final bool? defiReward;
  @override
  final ConfigCoinFee? hdWalletFeeLevel;

  factory _$ConfigCoin([void Function(ConfigCoinBuilder)? updates]) =>
      (new ConfigCoinBuilder()..update(updates))._build();

  _$ConfigCoin._(
      {required this.symbol,
      required this.chain,
      required this.name,
      required this.fullName,
      required this.icon,
      this.contract,
      required this.transferFee,
      this.chainPrecision,
      required this.displayPrecision,
      this.transferMinQuota,
      this.defiReward,
      this.hdWalletFeeLevel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(symbol, r'ConfigCoin', 'symbol');
    BuiltValueNullFieldError.checkNotNull(chain, r'ConfigCoin', 'chain');
    BuiltValueNullFieldError.checkNotNull(name, r'ConfigCoin', 'name');
    BuiltValueNullFieldError.checkNotNull(fullName, r'ConfigCoin', 'fullName');
    BuiltValueNullFieldError.checkNotNull(icon, r'ConfigCoin', 'icon');
    BuiltValueNullFieldError.checkNotNull(
        transferFee, r'ConfigCoin', 'transferFee');
    BuiltValueNullFieldError.checkNotNull(
        displayPrecision, r'ConfigCoin', 'displayPrecision');
  }

  @override
  ConfigCoin rebuild(void Function(ConfigCoinBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigCoinBuilder toBuilder() => new ConfigCoinBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigCoin &&
        symbol == other.symbol &&
        chain == other.chain &&
        name == other.name &&
        fullName == other.fullName &&
        icon == other.icon &&
        contract == other.contract &&
        transferFee == other.transferFee &&
        chainPrecision == other.chainPrecision &&
        displayPrecision == other.displayPrecision &&
        transferMinQuota == other.transferMinQuota &&
        defiReward == other.defiReward &&
        hdWalletFeeLevel == other.hdWalletFeeLevel;
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
                                            $jc($jc(0, symbol.hashCode),
                                                chain.hashCode),
                                            name.hashCode),
                                        fullName.hashCode),
                                    icon.hashCode),
                                contract.hashCode),
                            transferFee.hashCode),
                        chainPrecision.hashCode),
                    displayPrecision.hashCode),
                transferMinQuota.hashCode),
            defiReward.hashCode),
        hdWalletFeeLevel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigCoin')
          ..add('symbol', symbol)
          ..add('chain', chain)
          ..add('name', name)
          ..add('fullName', fullName)
          ..add('icon', icon)
          ..add('contract', contract)
          ..add('transferFee', transferFee)
          ..add('chainPrecision', chainPrecision)
          ..add('displayPrecision', displayPrecision)
          ..add('transferMinQuota', transferMinQuota)
          ..add('defiReward', defiReward)
          ..add('hdWalletFeeLevel', hdWalletFeeLevel))
        .toString();
  }
}

class ConfigCoinBuilder implements Builder<ConfigCoin, ConfigCoinBuilder> {
  _$ConfigCoin? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(String? chain) => _$this._chain = chain;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  String? _contract;
  String? get contract => _$this._contract;
  set contract(String? contract) => _$this._contract = contract;

  double? _transferFee;
  double? get transferFee => _$this._transferFee;
  set transferFee(double? transferFee) => _$this._transferFee = transferFee;

  int? _chainPrecision;
  int? get chainPrecision => _$this._chainPrecision;
  set chainPrecision(int? chainPrecision) =>
      _$this._chainPrecision = chainPrecision;

  int? _displayPrecision;
  int? get displayPrecision => _$this._displayPrecision;
  set displayPrecision(int? displayPrecision) =>
      _$this._displayPrecision = displayPrecision;

  double? _transferMinQuota;
  double? get transferMinQuota => _$this._transferMinQuota;
  set transferMinQuota(double? transferMinQuota) =>
      _$this._transferMinQuota = transferMinQuota;

  bool? _defiReward;
  bool? get defiReward => _$this._defiReward;
  set defiReward(bool? defiReward) => _$this._defiReward = defiReward;

  ConfigCoinFeeBuilder? _hdWalletFeeLevel;
  ConfigCoinFeeBuilder get hdWalletFeeLevel =>
      _$this._hdWalletFeeLevel ??= new ConfigCoinFeeBuilder();
  set hdWalletFeeLevel(ConfigCoinFeeBuilder? hdWalletFeeLevel) =>
      _$this._hdWalletFeeLevel = hdWalletFeeLevel;

  ConfigCoinBuilder();

  ConfigCoinBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _chain = $v.chain;
      _name = $v.name;
      _fullName = $v.fullName;
      _icon = $v.icon;
      _contract = $v.contract;
      _transferFee = $v.transferFee;
      _chainPrecision = $v.chainPrecision;
      _displayPrecision = $v.displayPrecision;
      _transferMinQuota = $v.transferMinQuota;
      _defiReward = $v.defiReward;
      _hdWalletFeeLevel = $v.hdWalletFeeLevel?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigCoin other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfigCoin;
  }

  @override
  void update(void Function(ConfigCoinBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigCoin build() => _build();

  _$ConfigCoin _build() {
    _$ConfigCoin _$result;
    try {
      _$result = _$v ??
          new _$ConfigCoin._(
              symbol: BuiltValueNullFieldError.checkNotNull(
                  symbol, r'ConfigCoin', 'symbol'),
              chain: BuiltValueNullFieldError.checkNotNull(
                  chain, r'ConfigCoin', 'chain'),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'ConfigCoin', 'name'),
              fullName: BuiltValueNullFieldError.checkNotNull(
                  fullName, r'ConfigCoin', 'fullName'),
              icon: BuiltValueNullFieldError.checkNotNull(
                  icon, r'ConfigCoin', 'icon'),
              contract: contract,
              transferFee: BuiltValueNullFieldError.checkNotNull(
                  transferFee, r'ConfigCoin', 'transferFee'),
              chainPrecision: chainPrecision,
              displayPrecision: BuiltValueNullFieldError.checkNotNull(
                  displayPrecision, r'ConfigCoin', 'displayPrecision'),
              transferMinQuota: transferMinQuota,
              defiReward: defiReward,
              hdWalletFeeLevel: _hdWalletFeeLevel?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'hdWalletFeeLevel';
        _hdWalletFeeLevel?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ConfigCoin', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConfigCoinFee extends ConfigCoinFee {
  @override
  final bool enable;
  @override
  final BuiltMap<String, double> level;

  factory _$ConfigCoinFee([void Function(ConfigCoinFeeBuilder)? updates]) =>
      (new ConfigCoinFeeBuilder()..update(updates))._build();

  _$ConfigCoinFee._({required this.enable, required this.level}) : super._() {
    BuiltValueNullFieldError.checkNotNull(enable, r'ConfigCoinFee', 'enable');
    BuiltValueNullFieldError.checkNotNull(level, r'ConfigCoinFee', 'level');
  }

  @override
  ConfigCoinFee rebuild(void Function(ConfigCoinFeeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigCoinFeeBuilder toBuilder() => new ConfigCoinFeeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigCoinFee &&
        enable == other.enable &&
        level == other.level;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, enable.hashCode), level.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigCoinFee')
          ..add('enable', enable)
          ..add('level', level))
        .toString();
  }
}

class ConfigCoinFeeBuilder
    implements Builder<ConfigCoinFee, ConfigCoinFeeBuilder> {
  _$ConfigCoinFee? _$v;

  bool? _enable;
  bool? get enable => _$this._enable;
  set enable(bool? enable) => _$this._enable = enable;

  MapBuilder<String, double>? _level;
  MapBuilder<String, double> get level =>
      _$this._level ??= new MapBuilder<String, double>();
  set level(MapBuilder<String, double>? level) => _$this._level = level;

  ConfigCoinFeeBuilder();

  ConfigCoinFeeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enable = $v.enable;
      _level = $v.level.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigCoinFee other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfigCoinFee;
  }

  @override
  void update(void Function(ConfigCoinFeeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigCoinFee build() => _build();

  _$ConfigCoinFee _build() {
    _$ConfigCoinFee _$result;
    try {
      _$result = _$v ??
          new _$ConfigCoinFee._(
              enable: BuiltValueNullFieldError.checkNotNull(
                  enable, r'ConfigCoinFee', 'enable'),
              level: level.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'level';
        level.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ConfigCoinFee', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConfigOtc extends ConfigOtc {
  @override
  final bool? enable;
  @override
  final int? maxAds;
  @override
  final BuiltMap<String, BuiltList<String>>? tradePairs;
  @override
  final String? depositAmount;
  @override
  final String? depositCurrency;
  @override
  final BuiltMap<String, String> systemOtcAddress;
  @override
  final String systemDepositAddress;

  factory _$ConfigOtc([void Function(ConfigOtcBuilder)? updates]) =>
      (new ConfigOtcBuilder()..update(updates))._build();

  _$ConfigOtc._(
      {this.enable,
      this.maxAds,
      this.tradePairs,
      this.depositAmount,
      this.depositCurrency,
      required this.systemOtcAddress,
      required this.systemDepositAddress})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        systemOtcAddress, r'ConfigOtc', 'systemOtcAddress');
    BuiltValueNullFieldError.checkNotNull(
        systemDepositAddress, r'ConfigOtc', 'systemDepositAddress');
  }

  @override
  ConfigOtc rebuild(void Function(ConfigOtcBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigOtcBuilder toBuilder() => new ConfigOtcBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigOtc &&
        enable == other.enable &&
        maxAds == other.maxAds &&
        tradePairs == other.tradePairs &&
        depositAmount == other.depositAmount &&
        depositCurrency == other.depositCurrency &&
        systemOtcAddress == other.systemOtcAddress &&
        systemDepositAddress == other.systemDepositAddress;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, enable.hashCode), maxAds.hashCode),
                        tradePairs.hashCode),
                    depositAmount.hashCode),
                depositCurrency.hashCode),
            systemOtcAddress.hashCode),
        systemDepositAddress.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigOtc')
          ..add('enable', enable)
          ..add('maxAds', maxAds)
          ..add('tradePairs', tradePairs)
          ..add('depositAmount', depositAmount)
          ..add('depositCurrency', depositCurrency)
          ..add('systemOtcAddress', systemOtcAddress)
          ..add('systemDepositAddress', systemDepositAddress))
        .toString();
  }
}

class ConfigOtcBuilder implements Builder<ConfigOtc, ConfigOtcBuilder> {
  _$ConfigOtc? _$v;

  bool? _enable;
  bool? get enable => _$this._enable;
  set enable(bool? enable) => _$this._enable = enable;

  int? _maxAds;
  int? get maxAds => _$this._maxAds;
  set maxAds(int? maxAds) => _$this._maxAds = maxAds;

  MapBuilder<String, BuiltList<String>>? _tradePairs;
  MapBuilder<String, BuiltList<String>> get tradePairs =>
      _$this._tradePairs ??= new MapBuilder<String, BuiltList<String>>();
  set tradePairs(MapBuilder<String, BuiltList<String>>? tradePairs) =>
      _$this._tradePairs = tradePairs;

  String? _depositAmount;
  String? get depositAmount => _$this._depositAmount;
  set depositAmount(String? depositAmount) =>
      _$this._depositAmount = depositAmount;

  String? _depositCurrency;
  String? get depositCurrency => _$this._depositCurrency;
  set depositCurrency(String? depositCurrency) =>
      _$this._depositCurrency = depositCurrency;

  MapBuilder<String, String>? _systemOtcAddress;
  MapBuilder<String, String> get systemOtcAddress =>
      _$this._systemOtcAddress ??= new MapBuilder<String, String>();
  set systemOtcAddress(MapBuilder<String, String>? systemOtcAddress) =>
      _$this._systemOtcAddress = systemOtcAddress;

  String? _systemDepositAddress;
  String? get systemDepositAddress => _$this._systemDepositAddress;
  set systemDepositAddress(String? systemDepositAddress) =>
      _$this._systemDepositAddress = systemDepositAddress;

  ConfigOtcBuilder();

  ConfigOtcBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enable = $v.enable;
      _maxAds = $v.maxAds;
      _tradePairs = $v.tradePairs?.toBuilder();
      _depositAmount = $v.depositAmount;
      _depositCurrency = $v.depositCurrency;
      _systemOtcAddress = $v.systemOtcAddress.toBuilder();
      _systemDepositAddress = $v.systemDepositAddress;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigOtc other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfigOtc;
  }

  @override
  void update(void Function(ConfigOtcBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigOtc build() => _build();

  _$ConfigOtc _build() {
    _$ConfigOtc _$result;
    try {
      _$result = _$v ??
          new _$ConfigOtc._(
              enable: enable,
              maxAds: maxAds,
              tradePairs: _tradePairs?.build(),
              depositAmount: depositAmount,
              depositCurrency: depositCurrency,
              systemOtcAddress: systemOtcAddress.build(),
              systemDepositAddress: BuiltValueNullFieldError.checkNotNull(
                  systemDepositAddress, r'ConfigOtc', 'systemDepositAddress'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tradePairs';
        _tradePairs?.build();

        _$failedField = 'systemOtcAddress';
        systemOtcAddress.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ConfigOtc', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConfigSystem extends ConfigSystem {
  @override
  final BuiltMap<String, ConfigSystemApp>? config;

  factory _$ConfigSystem([void Function(ConfigSystemBuilder)? updates]) =>
      (new ConfigSystemBuilder()..update(updates))._build();

  _$ConfigSystem._({this.config}) : super._();

  @override
  ConfigSystem rebuild(void Function(ConfigSystemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigSystemBuilder toBuilder() => new ConfigSystemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigSystem && config == other.config;
  }

  @override
  int get hashCode {
    return $jf($jc(0, config.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigSystem')..add('config', config))
        .toString();
  }
}

class ConfigSystemBuilder
    implements Builder<ConfigSystem, ConfigSystemBuilder> {
  _$ConfigSystem? _$v;

  MapBuilder<String, ConfigSystemApp>? _config;
  MapBuilder<String, ConfigSystemApp> get config =>
      _$this._config ??= new MapBuilder<String, ConfigSystemApp>();
  set config(MapBuilder<String, ConfigSystemApp>? config) =>
      _$this._config = config;

  ConfigSystemBuilder();

  ConfigSystemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _config = $v.config?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigSystem other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfigSystem;
  }

  @override
  void update(void Function(ConfigSystemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigSystem build() => _build();

  _$ConfigSystem _build() {
    _$ConfigSystem _$result;
    try {
      _$result = _$v ?? new _$ConfigSystem._(config: _config?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ConfigSystem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConfigSystemApp extends ConfigSystemApp {
  @override
  final bool? enable;

  factory _$ConfigSystemApp([void Function(ConfigSystemAppBuilder)? updates]) =>
      (new ConfigSystemAppBuilder()..update(updates))._build();

  _$ConfigSystemApp._({this.enable}) : super._();

  @override
  ConfigSystemApp rebuild(void Function(ConfigSystemAppBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigSystemAppBuilder toBuilder() =>
      new ConfigSystemAppBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigSystemApp && enable == other.enable;
  }

  @override
  int get hashCode {
    return $jf($jc(0, enable.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigSystemApp')
          ..add('enable', enable))
        .toString();
  }
}

class ConfigSystemAppBuilder
    implements Builder<ConfigSystemApp, ConfigSystemAppBuilder> {
  _$ConfigSystemApp? _$v;

  bool? _enable;
  bool? get enable => _$this._enable;
  set enable(bool? enable) => _$this._enable = enable;

  ConfigSystemAppBuilder();

  ConfigSystemAppBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enable = $v.enable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigSystemApp other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfigSystemApp;
  }

  @override
  void update(void Function(ConfigSystemAppBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigSystemApp build() => _build();

  _$ConfigSystemApp _build() {
    final _$result = _$v ?? new _$ConfigSystemApp._(enable: enable);
    replace(_$result);
    return _$result;
  }
}

class _$ConfigUpdate extends ConfigUpdate {
  @override
  final bool? needUpdate;
  @override
  final ConfigUpdateData? data;

  factory _$ConfigUpdate([void Function(ConfigUpdateBuilder)? updates]) =>
      (new ConfigUpdateBuilder()..update(updates))._build();

  _$ConfigUpdate._({this.needUpdate, this.data}) : super._();

  @override
  ConfigUpdate rebuild(void Function(ConfigUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigUpdateBuilder toBuilder() => new ConfigUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigUpdate &&
        needUpdate == other.needUpdate &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, needUpdate.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigUpdate')
          ..add('needUpdate', needUpdate)
          ..add('data', data))
        .toString();
  }
}

class ConfigUpdateBuilder
    implements Builder<ConfigUpdate, ConfigUpdateBuilder> {
  _$ConfigUpdate? _$v;

  bool? _needUpdate;
  bool? get needUpdate => _$this._needUpdate;
  set needUpdate(bool? needUpdate) => _$this._needUpdate = needUpdate;

  ConfigUpdateDataBuilder? _data;
  ConfigUpdateDataBuilder get data =>
      _$this._data ??= new ConfigUpdateDataBuilder();
  set data(ConfigUpdateDataBuilder? data) => _$this._data = data;

  ConfigUpdateBuilder();

  ConfigUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _needUpdate = $v.needUpdate;
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigUpdate other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfigUpdate;
  }

  @override
  void update(void Function(ConfigUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigUpdate build() => _build();

  _$ConfigUpdate _build() {
    _$ConfigUpdate _$result;
    try {
      _$result = _$v ??
          new _$ConfigUpdate._(needUpdate: needUpdate, data: _data?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ConfigUpdate', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConfigUpdateData extends ConfigUpdateData {
  @override
  final String? version;
  @override
  final String? description;
  @override
  final bool? forceUpdate;
  @override
  final String? downloadUrl;
  @override
  final BuiltMap<String, String>? disabledModules;

  factory _$ConfigUpdateData(
          [void Function(ConfigUpdateDataBuilder)? updates]) =>
      (new ConfigUpdateDataBuilder()..update(updates))._build();

  _$ConfigUpdateData._(
      {this.version,
      this.description,
      this.forceUpdate,
      this.downloadUrl,
      this.disabledModules})
      : super._();

  @override
  ConfigUpdateData rebuild(void Function(ConfigUpdateDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigUpdateDataBuilder toBuilder() =>
      new ConfigUpdateDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigUpdateData &&
        version == other.version &&
        description == other.description &&
        forceUpdate == other.forceUpdate &&
        downloadUrl == other.downloadUrl &&
        disabledModules == other.disabledModules;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, version.hashCode), description.hashCode),
                forceUpdate.hashCode),
            downloadUrl.hashCode),
        disabledModules.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigUpdateData')
          ..add('version', version)
          ..add('description', description)
          ..add('forceUpdate', forceUpdate)
          ..add('downloadUrl', downloadUrl)
          ..add('disabledModules', disabledModules))
        .toString();
  }
}

class ConfigUpdateDataBuilder
    implements Builder<ConfigUpdateData, ConfigUpdateDataBuilder> {
  _$ConfigUpdateData? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _forceUpdate;
  bool? get forceUpdate => _$this._forceUpdate;
  set forceUpdate(bool? forceUpdate) => _$this._forceUpdate = forceUpdate;

  String? _downloadUrl;
  String? get downloadUrl => _$this._downloadUrl;
  set downloadUrl(String? downloadUrl) => _$this._downloadUrl = downloadUrl;

  MapBuilder<String, String>? _disabledModules;
  MapBuilder<String, String> get disabledModules =>
      _$this._disabledModules ??= new MapBuilder<String, String>();
  set disabledModules(MapBuilder<String, String>? disabledModules) =>
      _$this._disabledModules = disabledModules;

  ConfigUpdateDataBuilder();

  ConfigUpdateDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _description = $v.description;
      _forceUpdate = $v.forceUpdate;
      _downloadUrl = $v.downloadUrl;
      _disabledModules = $v.disabledModules?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigUpdateData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ConfigUpdateData;
  }

  @override
  void update(void Function(ConfigUpdateDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigUpdateData build() => _build();

  _$ConfigUpdateData _build() {
    _$ConfigUpdateData _$result;
    try {
      _$result = _$v ??
          new _$ConfigUpdateData._(
              version: version,
              description: description,
              forceUpdate: forceUpdate,
              downloadUrl: downloadUrl,
              disabledModules: _disabledModules?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'disabledModules';
        _disabledModules?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ConfigUpdateData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CommonState extends CommonState {
  @override
  final Config? config;
  @override
  final int? configState;
  @override
  final PackageInfo? appInfo;
  @override
  final String? deviceId;
  @override
  final String? language;
  @override
  final String? fiatCurrency;
  @override
  final ConfigUpdate? newVersion;

  factory _$CommonState([void Function(CommonStateBuilder)? updates]) =>
      (new CommonStateBuilder()..update(updates))._build();

  _$CommonState._(
      {this.config,
      this.configState,
      this.appInfo,
      this.deviceId,
      this.language,
      this.fiatCurrency,
      this.newVersion})
      : super._();

  @override
  CommonState rebuild(void Function(CommonStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommonStateBuilder toBuilder() => new CommonStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommonState &&
        config == other.config &&
        configState == other.configState &&
        appInfo == other.appInfo &&
        deviceId == other.deviceId &&
        language == other.language &&
        fiatCurrency == other.fiatCurrency &&
        newVersion == other.newVersion;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, config.hashCode), configState.hashCode),
                        appInfo.hashCode),
                    deviceId.hashCode),
                language.hashCode),
            fiatCurrency.hashCode),
        newVersion.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommonState')
          ..add('config', config)
          ..add('configState', configState)
          ..add('appInfo', appInfo)
          ..add('deviceId', deviceId)
          ..add('language', language)
          ..add('fiatCurrency', fiatCurrency)
          ..add('newVersion', newVersion))
        .toString();
  }
}

class CommonStateBuilder implements Builder<CommonState, CommonStateBuilder> {
  _$CommonState? _$v;

  ConfigBuilder? _config;
  ConfigBuilder get config => _$this._config ??= new ConfigBuilder();
  set config(ConfigBuilder? config) => _$this._config = config;

  int? _configState;
  int? get configState => _$this._configState;
  set configState(int? configState) => _$this._configState = configState;

  PackageInfo? _appInfo;
  PackageInfo? get appInfo => _$this._appInfo;
  set appInfo(PackageInfo? appInfo) => _$this._appInfo = appInfo;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  String? _fiatCurrency;
  String? get fiatCurrency => _$this._fiatCurrency;
  set fiatCurrency(String? fiatCurrency) => _$this._fiatCurrency = fiatCurrency;

  ConfigUpdateBuilder? _newVersion;
  ConfigUpdateBuilder get newVersion =>
      _$this._newVersion ??= new ConfigUpdateBuilder();
  set newVersion(ConfigUpdateBuilder? newVersion) =>
      _$this._newVersion = newVersion;

  CommonStateBuilder();

  CommonStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _config = $v.config?.toBuilder();
      _configState = $v.configState;
      _appInfo = $v.appInfo;
      _deviceId = $v.deviceId;
      _language = $v.language;
      _fiatCurrency = $v.fiatCurrency;
      _newVersion = $v.newVersion?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommonState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommonState;
  }

  @override
  void update(void Function(CommonStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommonState build() => _build();

  _$CommonState _build() {
    _$CommonState _$result;
    try {
      _$result = _$v ??
          new _$CommonState._(
              config: _config?.build(),
              configState: configState,
              appInfo: appInfo,
              deviceId: deviceId,
              language: language,
              fiatCurrency: fiatCurrency,
              newVersion: _newVersion?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();

        _$failedField = 'newVersion';
        _newVersion?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CommonState', _$failedField, e.toString());
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

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 1;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      language: fields[0] as String?,
      languageIsSet: fields[1] as bool,
      fiatCurrency: fields[2] as String?,
      activeWalletId: fields[3] as String?,
    )
      ..imageSignature = (fields[5] as Map?)?.cast<String, dynamic>()
      ..imageSignatureLastUpdate = fields[6] as int?
      ..installId = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.language)
      ..writeByte(1)
      ..write(obj.languageIsSet)
      ..writeByte(2)
      ..write(obj.fiatCurrency)
      ..writeByte(3)
      ..write(obj.activeWalletId)
      ..writeByte(5)
      ..write(obj.imageSignature)
      ..writeByte(6)
      ..write(obj.imageSignatureLastUpdate)
      ..writeByte(7)
      ..write(obj.installId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
