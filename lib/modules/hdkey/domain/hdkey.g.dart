// GENERATED CODE - DO NOT MODIFY BY HAND

part of hdkey_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HDKeyState> _$hDKeyStateSerializer = new _$HDKeyStateSerializer();

class _$HDKeyStateSerializer implements StructuredSerializer<HDKeyState> {
  @override
  final Iterable<Type> types = const [HDKeyState, _$HDKeyState];
  @override
  final String wireName = 'HDKeyState';

  @override
  Iterable<Object> serialize(Serializers serializers, HDKeyState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'isConnected',
      serializers.serialize(object.isConnected,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  HDKeyState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HDKeyStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'isConnected':
          result.isConnected = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$HDKeyManagementVM extends HDKeyManagementVM {
  @override
  final Wallet activeWallet;
  @override
  final AssetCoin invitationCoin;
  @override
  final List<Wallet> wallets;
  @override
  final List<String> localIds;
  @override
  final Future<void> Function(String pwdOld, String pwdNew) changePassword;
  @override
  final Future<void> Function(String name) changeName;
  @override
  final Future<void> Function() deleteWallet;
  @override
  final Future<void> Function(String mnemonic) validateMnemonic;

  factory _$HDKeyManagementVM(
          [void Function(HDKeyManagementVMBuilder) updates]) =>
      (new HDKeyManagementVMBuilder()..update(updates)).build();

  _$HDKeyManagementVM._(
      {this.activeWallet,
      this.invitationCoin,
      this.wallets,
      this.localIds,
      this.changePassword,
      this.changeName,
      this.deleteWallet,
      this.validateMnemonic})
      : super._() {
    if (wallets == null) {
      throw new BuiltValueNullFieldError('HDKeyManagementVM', 'wallets');
    }
    if (localIds == null) {
      throw new BuiltValueNullFieldError('HDKeyManagementVM', 'localIds');
    }
    if (changePassword == null) {
      throw new BuiltValueNullFieldError('HDKeyManagementVM', 'changePassword');
    }
    if (changeName == null) {
      throw new BuiltValueNullFieldError('HDKeyManagementVM', 'changeName');
    }
    if (deleteWallet == null) {
      throw new BuiltValueNullFieldError('HDKeyManagementVM', 'deleteWallet');
    }
    if (validateMnemonic == null) {
      throw new BuiltValueNullFieldError(
          'HDKeyManagementVM', 'validateMnemonic');
    }
  }

  @override
  HDKeyManagementVM rebuild(void Function(HDKeyManagementVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HDKeyManagementVMBuilder toBuilder() =>
      new HDKeyManagementVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HDKeyManagementVM &&
        activeWallet == other.activeWallet &&
        invitationCoin == other.invitationCoin &&
        wallets == other.wallets &&
        localIds == other.localIds;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, activeWallet.hashCode), invitationCoin.hashCode),
            wallets.hashCode),
        localIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HDKeyManagementVM')
          ..add('activeWallet', activeWallet)
          ..add('invitationCoin', invitationCoin)
          ..add('wallets', wallets)
          ..add('localIds', localIds)
          ..add('changePassword', changePassword)
          ..add('changeName', changeName)
          ..add('deleteWallet', deleteWallet)
          ..add('validateMnemonic', validateMnemonic))
        .toString();
  }
}

class HDKeyManagementVMBuilder
    implements Builder<HDKeyManagementVM, HDKeyManagementVMBuilder> {
  _$HDKeyManagementVM _$v;

  Wallet _activeWallet;
  Wallet get activeWallet => _$this._activeWallet;
  set activeWallet(Wallet activeWallet) => _$this._activeWallet = activeWallet;

  AssetCoinBuilder _invitationCoin;
  AssetCoinBuilder get invitationCoin =>
      _$this._invitationCoin ??= new AssetCoinBuilder();
  set invitationCoin(AssetCoinBuilder invitationCoin) =>
      _$this._invitationCoin = invitationCoin;

  List<Wallet> _wallets;
  List<Wallet> get wallets => _$this._wallets;
  set wallets(List<Wallet> wallets) => _$this._wallets = wallets;

  List<String> _localIds;
  List<String> get localIds => _$this._localIds;
  set localIds(List<String> localIds) => _$this._localIds = localIds;

  Future<void> Function(String pwdOld, String pwdNew) _changePassword;
  Future<void> Function(String pwdOld, String pwdNew) get changePassword =>
      _$this._changePassword;
  set changePassword(
          Future<void> Function(String pwdOld, String pwdNew) changePassword) =>
      _$this._changePassword = changePassword;

  Future<void> Function(String name) _changeName;
  Future<void> Function(String name) get changeName => _$this._changeName;
  set changeName(Future<void> Function(String name) changeName) =>
      _$this._changeName = changeName;

  Future<void> Function() _deleteWallet;
  Future<void> Function() get deleteWallet => _$this._deleteWallet;
  set deleteWallet(Future<void> Function() deleteWallet) =>
      _$this._deleteWallet = deleteWallet;

  Future<void> Function(String mnemonic) _validateMnemonic;
  Future<void> Function(String mnemonic) get validateMnemonic =>
      _$this._validateMnemonic;
  set validateMnemonic(
          Future<void> Function(String mnemonic) validateMnemonic) =>
      _$this._validateMnemonic = validateMnemonic;

  HDKeyManagementVMBuilder();

  HDKeyManagementVMBuilder get _$this {
    if (_$v != null) {
      _activeWallet = _$v.activeWallet;
      _invitationCoin = _$v.invitationCoin?.toBuilder();
      _wallets = _$v.wallets;
      _localIds = _$v.localIds;
      _changePassword = _$v.changePassword;
      _changeName = _$v.changeName;
      _deleteWallet = _$v.deleteWallet;
      _validateMnemonic = _$v.validateMnemonic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HDKeyManagementVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HDKeyManagementVM;
  }

  @override
  void update(void Function(HDKeyManagementVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HDKeyManagementVM build() {
    _$HDKeyManagementVM _$result;
    try {
      _$result = _$v ??
          new _$HDKeyManagementVM._(
              activeWallet: activeWallet,
              invitationCoin: _invitationCoin?.build(),
              wallets: wallets,
              localIds: localIds,
              changePassword: changePassword,
              changeName: changeName,
              deleteWallet: deleteWallet,
              validateMnemonic: validateMnemonic);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'invitationCoin';
        _invitationCoin?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HDKeyManagementVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$HDKeyState extends HDKeyState {
  @override
  final bool isConnected;

  factory _$HDKeyState([void Function(HDKeyStateBuilder) updates]) =>
      (new HDKeyStateBuilder()..update(updates)).build();

  _$HDKeyState._({this.isConnected}) : super._() {
    if (isConnected == null) {
      throw new BuiltValueNullFieldError('HDKeyState', 'isConnected');
    }
  }

  @override
  HDKeyState rebuild(void Function(HDKeyStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HDKeyStateBuilder toBuilder() => new HDKeyStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HDKeyState && isConnected == other.isConnected;
  }

  @override
  int get hashCode {
    return $jf($jc(0, isConnected.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HDKeyState')
          ..add('isConnected', isConnected))
        .toString();
  }
}

class HDKeyStateBuilder implements Builder<HDKeyState, HDKeyStateBuilder> {
  _$HDKeyState _$v;

  bool _isConnected;
  bool get isConnected => _$this._isConnected;
  set isConnected(bool isConnected) => _$this._isConnected = isConnected;

  HDKeyStateBuilder();

  HDKeyStateBuilder get _$this {
    if (_$v != null) {
      _isConnected = _$v.isConnected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HDKeyState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HDKeyState;
  }

  @override
  void update(void Function(HDKeyStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HDKeyState build() {
    final _$result = _$v ?? new _$HDKeyState._(isConnected: isConnected);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
