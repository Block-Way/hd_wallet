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
  Iterable<Object?> serialize(Serializers serializers, HDKeyState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'isConnected',
      serializers.serialize(object.isConnected,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  HDKeyState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HDKeyStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'isConnected':
          result.isConnected = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$HDKeyManagementVM extends HDKeyManagementVM {
  @override
  final Wallet? activeWallet;
  @override
  final AssetCoin? invitationCoin;
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
          [void Function(HDKeyManagementVMBuilder)? updates]) =>
      (new HDKeyManagementVMBuilder()..update(updates))._build();

  _$HDKeyManagementVM._(
      {this.activeWallet,
      this.invitationCoin,
      required this.wallets,
      required this.localIds,
      required this.changePassword,
      required this.changeName,
      required this.deleteWallet,
      required this.validateMnemonic})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        wallets, r'HDKeyManagementVM', 'wallets');
    BuiltValueNullFieldError.checkNotNull(
        localIds, r'HDKeyManagementVM', 'localIds');
    BuiltValueNullFieldError.checkNotNull(
        changePassword, r'HDKeyManagementVM', 'changePassword');
    BuiltValueNullFieldError.checkNotNull(
        changeName, r'HDKeyManagementVM', 'changeName');
    BuiltValueNullFieldError.checkNotNull(
        deleteWallet, r'HDKeyManagementVM', 'deleteWallet');
    BuiltValueNullFieldError.checkNotNull(
        validateMnemonic, r'HDKeyManagementVM', 'validateMnemonic');
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
    return (newBuiltValueToStringHelper(r'HDKeyManagementVM')
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
  _$HDKeyManagementVM? _$v;

  Wallet? _activeWallet;
  Wallet? get activeWallet => _$this._activeWallet;
  set activeWallet(Wallet? activeWallet) => _$this._activeWallet = activeWallet;

  AssetCoinBuilder? _invitationCoin;
  AssetCoinBuilder get invitationCoin =>
      _$this._invitationCoin ??= new AssetCoinBuilder();
  set invitationCoin(AssetCoinBuilder? invitationCoin) =>
      _$this._invitationCoin = invitationCoin;

  List<Wallet>? _wallets;
  List<Wallet>? get wallets => _$this._wallets;
  set wallets(List<Wallet>? wallets) => _$this._wallets = wallets;

  List<String>? _localIds;
  List<String>? get localIds => _$this._localIds;
  set localIds(List<String>? localIds) => _$this._localIds = localIds;

  Future<void> Function(String pwdOld, String pwdNew)? _changePassword;
  Future<void> Function(String pwdOld, String pwdNew)? get changePassword =>
      _$this._changePassword;
  set changePassword(
          Future<void> Function(String pwdOld, String pwdNew)?
              changePassword) =>
      _$this._changePassword = changePassword;

  Future<void> Function(String name)? _changeName;
  Future<void> Function(String name)? get changeName => _$this._changeName;
  set changeName(Future<void> Function(String name)? changeName) =>
      _$this._changeName = changeName;

  Future<void> Function()? _deleteWallet;
  Future<void> Function()? get deleteWallet => _$this._deleteWallet;
  set deleteWallet(Future<void> Function()? deleteWallet) =>
      _$this._deleteWallet = deleteWallet;

  Future<void> Function(String mnemonic)? _validateMnemonic;
  Future<void> Function(String mnemonic)? get validateMnemonic =>
      _$this._validateMnemonic;
  set validateMnemonic(
          Future<void> Function(String mnemonic)? validateMnemonic) =>
      _$this._validateMnemonic = validateMnemonic;

  HDKeyManagementVMBuilder();

  HDKeyManagementVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _activeWallet = $v.activeWallet;
      _invitationCoin = $v.invitationCoin?.toBuilder();
      _wallets = $v.wallets;
      _localIds = $v.localIds;
      _changePassword = $v.changePassword;
      _changeName = $v.changeName;
      _deleteWallet = $v.deleteWallet;
      _validateMnemonic = $v.validateMnemonic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HDKeyManagementVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HDKeyManagementVM;
  }

  @override
  void update(void Function(HDKeyManagementVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HDKeyManagementVM build() => _build();

  _$HDKeyManagementVM _build() {
    _$HDKeyManagementVM _$result;
    try {
      _$result = _$v ??
          new _$HDKeyManagementVM._(
              activeWallet: activeWallet,
              invitationCoin: _invitationCoin?.build(),
              wallets: BuiltValueNullFieldError.checkNotNull(
                  wallets, r'HDKeyManagementVM', 'wallets'),
              localIds: BuiltValueNullFieldError.checkNotNull(
                  localIds, r'HDKeyManagementVM', 'localIds'),
              changePassword: BuiltValueNullFieldError.checkNotNull(
                  changePassword, r'HDKeyManagementVM', 'changePassword'),
              changeName: BuiltValueNullFieldError.checkNotNull(
                  changeName, r'HDKeyManagementVM', 'changeName'),
              deleteWallet: BuiltValueNullFieldError.checkNotNull(
                  deleteWallet, r'HDKeyManagementVM', 'deleteWallet'),
              validateMnemonic: BuiltValueNullFieldError.checkNotNull(
                  validateMnemonic, r'HDKeyManagementVM', 'validateMnemonic'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'invitationCoin';
        _invitationCoin?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HDKeyManagementVM', _$failedField, e.toString());
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

  factory _$HDKeyState([void Function(HDKeyStateBuilder)? updates]) =>
      (new HDKeyStateBuilder()..update(updates))._build();

  _$HDKeyState._({required this.isConnected}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isConnected, r'HDKeyState', 'isConnected');
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
    return (newBuiltValueToStringHelper(r'HDKeyState')
          ..add('isConnected', isConnected))
        .toString();
  }
}

class HDKeyStateBuilder implements Builder<HDKeyState, HDKeyStateBuilder> {
  _$HDKeyState? _$v;

  bool? _isConnected;
  bool? get isConnected => _$this._isConnected;
  set isConnected(bool? isConnected) => _$this._isConnected = isConnected;

  HDKeyStateBuilder();

  HDKeyStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isConnected = $v.isConnected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HDKeyState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HDKeyState;
  }

  @override
  void update(void Function(HDKeyStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HDKeyState build() => _build();

  _$HDKeyState _build() {
    final _$result = _$v ??
        new _$HDKeyState._(
            isConnected: BuiltValueNullFieldError.checkNotNull(
                isConnected, r'HDKeyState', 'isConnected'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
