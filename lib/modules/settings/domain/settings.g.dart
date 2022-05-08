// GENERATED CODE - DO NOT MODIFY BY HAND

part of settings_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SettingsConfig> _$settingsConfigSerializer =
    new _$SettingsConfigSerializer();

class _$SettingsConfigSerializer
    implements StructuredSerializer<SettingsConfig> {
  @override
  final Iterable<Type> types = const [SettingsConfig, _$SettingsConfig];
  @override
  final String wireName = 'SettingsConfig';

  @override
  Iterable<Object> serialize(Serializers serializers, SettingsConfig object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.apiBaseUrl != null) {
      result
        ..add('apiBaseUrl')
        ..add(serializers.serialize(object.apiBaseUrl,
            specifiedType: const FullType(String)));
    }
    if (object.apiAppVersion != null) {
      result
        ..add('apiAppVersion')
        ..add(serializers.serialize(object.apiAppVersion,
            specifiedType: const FullType(String)));
    }
    if (object.mqttUseTls != null) {
      result
        ..add('mqttUseTls')
        ..add(serializers.serialize(object.mqttUseTls,
            specifiedType: const FullType(String)));
    }
    if (object.mqttDisabled != null) {
      result
        ..add('mqttDisabled')
        ..add(serializers.serialize(object.mqttDisabled,
            specifiedType: const FullType(String)));
    }
    if (object.proxyUrl != null) {
      result
        ..add('proxyUrl')
        ..add(serializers.serialize(object.proxyUrl,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SettingsConfig deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SettingsConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'apiBaseUrl':
          result.apiBaseUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'apiAppVersion':
          result.apiAppVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mqttUseTls':
          result.mqttUseTls = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mqttDisabled':
          result.mqttDisabled = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'proxyUrl':
          result.proxyUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SettingsConfig extends SettingsConfig {
  @override
  final String apiBaseUrl;
  @override
  final String apiAppVersion;
  @override
  final String mqttUseTls;
  @override
  final String mqttDisabled;
  @override
  final String proxyUrl;

  factory _$SettingsConfig([void Function(SettingsConfigBuilder) updates]) =>
      (new SettingsConfigBuilder()..update(updates)).build();

  _$SettingsConfig._(
      {this.apiBaseUrl,
      this.apiAppVersion,
      this.mqttUseTls,
      this.mqttDisabled,
      this.proxyUrl})
      : super._();

  @override
  SettingsConfig rebuild(void Function(SettingsConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsConfigBuilder toBuilder() =>
      new SettingsConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsConfig &&
        apiBaseUrl == other.apiBaseUrl &&
        apiAppVersion == other.apiAppVersion &&
        mqttUseTls == other.mqttUseTls &&
        mqttDisabled == other.mqttDisabled &&
        proxyUrl == other.proxyUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, apiBaseUrl.hashCode), apiAppVersion.hashCode),
                mqttUseTls.hashCode),
            mqttDisabled.hashCode),
        proxyUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsConfig')
          ..add('apiBaseUrl', apiBaseUrl)
          ..add('apiAppVersion', apiAppVersion)
          ..add('mqttUseTls', mqttUseTls)
          ..add('mqttDisabled', mqttDisabled)
          ..add('proxyUrl', proxyUrl))
        .toString();
  }
}

class SettingsConfigBuilder
    implements Builder<SettingsConfig, SettingsConfigBuilder> {
  _$SettingsConfig _$v;

  String _apiBaseUrl;
  String get apiBaseUrl => _$this._apiBaseUrl;
  set apiBaseUrl(String apiBaseUrl) => _$this._apiBaseUrl = apiBaseUrl;

  String _apiAppVersion;
  String get apiAppVersion => _$this._apiAppVersion;
  set apiAppVersion(String apiAppVersion) =>
      _$this._apiAppVersion = apiAppVersion;

  String _mqttUseTls;
  String get mqttUseTls => _$this._mqttUseTls;
  set mqttUseTls(String mqttUseTls) => _$this._mqttUseTls = mqttUseTls;

  String _mqttDisabled;
  String get mqttDisabled => _$this._mqttDisabled;
  set mqttDisabled(String mqttDisabled) => _$this._mqttDisabled = mqttDisabled;

  String _proxyUrl;
  String get proxyUrl => _$this._proxyUrl;
  set proxyUrl(String proxyUrl) => _$this._proxyUrl = proxyUrl;

  SettingsConfigBuilder();

  SettingsConfigBuilder get _$this {
    if (_$v != null) {
      _apiBaseUrl = _$v.apiBaseUrl;
      _apiAppVersion = _$v.apiAppVersion;
      _mqttUseTls = _$v.mqttUseTls;
      _mqttDisabled = _$v.mqttDisabled;
      _proxyUrl = _$v.proxyUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SettingsConfig;
  }

  @override
  void update(void Function(SettingsConfigBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsConfig build() {
    final _$result = _$v ??
        new _$SettingsConfig._(
            apiBaseUrl: apiBaseUrl,
            apiAppVersion: apiAppVersion,
            mqttUseTls: mqttUseTls,
            mqttDisabled: mqttDisabled,
            proxyUrl: proxyUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
