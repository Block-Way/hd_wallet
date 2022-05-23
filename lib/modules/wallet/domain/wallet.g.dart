// GENERATED CODE - DO NOT MODIFY BY HAND

part of wallet_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WalletState> _$walletStateSerializer = new _$WalletStateSerializer();

class _$WalletStateSerializer implements StructuredSerializer<WalletState> {
  @override
  final Iterable<Type> types = const [WalletState, _$WalletState];
  @override
  final String wireName = 'WalletState';

  @override
  Iterable<Object> serialize(Serializers serializers, WalletState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.wallets != null) {
      result
        ..add('wallets')
        ..add(serializers.serialize(object.wallets,
            specifiedType:
                const FullType(List, const [const FullType(Wallet)])));
    }
    if (object.activeWallet != null) {
      result
        ..add('activeWallet')
        ..add(serializers.serialize(object.activeWallet,
            specifiedType: const FullType(Wallet)));
    }
    if (object.activeWalletId != null) {
      result
        ..add('activeWalletId')
        ..add(serializers.serialize(object.activeWalletId,
            specifiedType: const FullType(String)));
    }
    if (object.activeWalletStatus != null) {
      result
        ..add('activeWalletStatus')
        ..add(serializers.serialize(object.activeWalletStatus,
            specifiedType: const FullType(WalletStatus)));
    }
    return result;
  }

  @override
  WalletState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WalletStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'wallets':
          result.wallets = serializers.deserialize(value,
                  specifiedType:
                      const FullType(List, const [const FullType(Wallet)]))
              as List<Wallet>;
          break;
        case 'activeWallet':
          result.activeWallet = serializers.deserialize(value,
              specifiedType: const FullType(Wallet)) as Wallet;
          break;
        case 'activeWalletId':
          result.activeWalletId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'activeWalletStatus':
          result.activeWalletStatus = serializers.deserialize(value,
              specifiedType: const FullType(WalletStatus)) as WalletStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$WalletBackupVM extends WalletBackupVM {
  @override
  final Future Function() backupSuccess;

  factory _$WalletBackupVM([void Function(WalletBackupVMBuilder) updates]) =>
      (new WalletBackupVMBuilder()..update(updates)).build();

  _$WalletBackupVM._({this.backupSuccess}) : super._() {
    if (backupSuccess == null) {
      throw new BuiltValueNullFieldError('WalletBackupVM', 'backupSuccess');
    }
  }

  @override
  WalletBackupVM rebuild(void Function(WalletBackupVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletBackupVMBuilder toBuilder() =>
      new WalletBackupVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletBackupVM;
  }

  @override
  int get hashCode {
    return 874558468;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WalletBackupVM')
          ..add('backupSuccess', backupSuccess))
        .toString();
  }
}

class WalletBackupVMBuilder
    implements Builder<WalletBackupVM, WalletBackupVMBuilder> {
  _$WalletBackupVM _$v;

  Future Function() _backupSuccess;
  Future Function() get backupSuccess => _$this._backupSuccess;
  set backupSuccess(Future Function() backupSuccess) =>
      _$this._backupSuccess = backupSuccess;

  WalletBackupVMBuilder();

  WalletBackupVMBuilder get _$this {
    if (_$v != null) {
      _backupSuccess = _$v.backupSuccess;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletBackupVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WalletBackupVM;
  }

  @override
  void update(void Function(WalletBackupVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WalletBackupVM build() {
    final _$result =
        _$v ?? new _$WalletBackupVM._(backupSuccess: backupSuccess);
    replace(_$result);
    return _$result;
  }
}

class _$WalletManagementVM extends WalletManagementVM {
  @override
  final Wallet activeWallet;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;
  @override
  final Future<String> Function(String name, String password,
      [String importMnemonic, WalletType type]) createWallet;
  @override
  final Future<void> Function(String pwdOld, String pwdNew) changePassword;
  @override
  final Future<void> Function(String name) changeName;
  @override
  final Future<void> Function() deleteWallet;
  @override
  final Future<void> Function(String mnemonic) validateMnemonic;

  factory _$WalletManagementVM(
          [void Function(WalletManagementVMBuilder) updates]) =>
      (new WalletManagementVMBuilder()..update(updates)).build();

  _$WalletManagementVM._(
      {this.activeWallet,
      this.doUnlockWallet,
      this.createWallet,
      this.changePassword,
      this.changeName,
      this.deleteWallet,
      this.validateMnemonic})
      : super._() {
    if (doUnlockWallet == null) {
      throw new BuiltValueNullFieldError(
          'WalletManagementVM', 'doUnlockWallet');
    }
    if (createWallet == null) {
      throw new BuiltValueNullFieldError('WalletManagementVM', 'createWallet');
    }
    if (changePassword == null) {
      throw new BuiltValueNullFieldError(
          'WalletManagementVM', 'changePassword');
    }
    if (changeName == null) {
      throw new BuiltValueNullFieldError('WalletManagementVM', 'changeName');
    }
    if (deleteWallet == null) {
      throw new BuiltValueNullFieldError('WalletManagementVM', 'deleteWallet');
    }
    if (validateMnemonic == null) {
      throw new BuiltValueNullFieldError(
          'WalletManagementVM', 'validateMnemonic');
    }
  }

  @override
  WalletManagementVM rebuild(
          void Function(WalletManagementVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletManagementVMBuilder toBuilder() =>
      new WalletManagementVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletManagementVM && activeWallet == other.activeWallet;
  }

  @override
  int get hashCode {
    return $jf($jc(0, activeWallet.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WalletManagementVM')
          ..add('activeWallet', activeWallet)
          ..add('doUnlockWallet', doUnlockWallet)
          ..add('createWallet', createWallet)
          ..add('changePassword', changePassword)
          ..add('changeName', changeName)
          ..add('deleteWallet', deleteWallet)
          ..add('validateMnemonic', validateMnemonic))
        .toString();
  }
}

class WalletManagementVMBuilder
    implements Builder<WalletManagementVM, WalletManagementVMBuilder> {
  _$WalletManagementVM _$v;

  Wallet _activeWallet;
  Wallet get activeWallet => _$this._activeWallet;
  set activeWallet(Wallet activeWallet) => _$this._activeWallet = activeWallet;

  Future<WalletPrivateData> Function(String password) _doUnlockWallet;
  Future<WalletPrivateData> Function(String password) get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password) doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  Future<String> Function(String name, String password,
      [String importMnemonic, WalletType type]) _createWallet;
  Future<String> Function(String name, String password,
      [String importMnemonic,
      WalletType type]) get createWallet => _$this._createWallet;
  set createWallet(
          Future<String> Function(String name, String password,
                  [String importMnemonic, WalletType type])
              createWallet) =>
      _$this._createWallet = createWallet;

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

  WalletManagementVMBuilder();

  WalletManagementVMBuilder get _$this {
    if (_$v != null) {
      _activeWallet = _$v.activeWallet;
      _doUnlockWallet = _$v.doUnlockWallet;
      _createWallet = _$v.createWallet;
      _changePassword = _$v.changePassword;
      _changeName = _$v.changeName;
      _deleteWallet = _$v.deleteWallet;
      _validateMnemonic = _$v.validateMnemonic;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletManagementVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WalletManagementVM;
  }

  @override
  void update(void Function(WalletManagementVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WalletManagementVM build() {
    final _$result = _$v ??
        new _$WalletManagementVM._(
            activeWallet: activeWallet,
            doUnlockWallet: doUnlockWallet,
            createWallet: createWallet,
            changePassword: changePassword,
            changeName: changeName,
            deleteWallet: deleteWallet,
            validateMnemonic: validateMnemonic);
    replace(_$result);
    return _$result;
  }
}

class _$WalletState extends WalletState {
  @override
  final List<Wallet> wallets;
  @override
  final Wallet activeWallet;
  @override
  final String activeWalletId;
  @override
  final WalletStatus activeWalletStatus;

  factory _$WalletState([void Function(WalletStateBuilder) updates]) =>
      (new WalletStateBuilder()..update(updates)).build();

  _$WalletState._(
      {this.wallets,
      this.activeWallet,
      this.activeWalletId,
      this.activeWalletStatus})
      : super._();

  @override
  WalletState rebuild(void Function(WalletStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletStateBuilder toBuilder() => new WalletStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletState &&
        wallets == other.wallets &&
        activeWallet == other.activeWallet &&
        activeWalletId == other.activeWalletId &&
        activeWalletStatus == other.activeWalletStatus;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, wallets.hashCode), activeWallet.hashCode),
            activeWalletId.hashCode),
        activeWalletStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WalletState')
          ..add('wallets', wallets)
          ..add('activeWallet', activeWallet)
          ..add('activeWalletId', activeWalletId)
          ..add('activeWalletStatus', activeWalletStatus))
        .toString();
  }
}

class WalletStateBuilder implements Builder<WalletState, WalletStateBuilder> {
  _$WalletState _$v;

  List<Wallet> _wallets;
  List<Wallet> get wallets => _$this._wallets;
  set wallets(List<Wallet> wallets) => _$this._wallets = wallets;

  Wallet _activeWallet;
  Wallet get activeWallet => _$this._activeWallet;
  set activeWallet(Wallet activeWallet) => _$this._activeWallet = activeWallet;

  String _activeWalletId;
  String get activeWalletId => _$this._activeWalletId;
  set activeWalletId(String activeWalletId) =>
      _$this._activeWalletId = activeWalletId;

  WalletStatus _activeWalletStatus;
  WalletStatus get activeWalletStatus => _$this._activeWalletStatus;
  set activeWalletStatus(WalletStatus activeWalletStatus) =>
      _$this._activeWalletStatus = activeWalletStatus;

  WalletStateBuilder();

  WalletStateBuilder get _$this {
    if (_$v != null) {
      _wallets = _$v.wallets;
      _activeWallet = _$v.activeWallet;
      _activeWalletId = _$v.activeWalletId;
      _activeWalletStatus = _$v.activeWalletStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WalletState;
  }

  @override
  void update(void Function(WalletStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WalletState build() {
    final _$result = _$v ??
        new _$WalletState._(
            wallets: wallets,
            activeWallet: activeWallet,
            activeWalletId: activeWalletId,
            activeWalletStatus: activeWalletStatus);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BroadcastTxTypeAdapter extends TypeAdapter<BroadcastTxType> {
  @override
  final int typeId = 50;

  @override
  BroadcastTxType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BroadcastTxType.swap;
      case 1:
        return BroadcastTxType.pool;
      case 2:
        return BroadcastTxType.project;
      case 3:
        return BroadcastTxType.tradeFailOrder;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, BroadcastTxType obj) {
    switch (obj) {
      case BroadcastTxType.swap:
        writer.writeByte(0);
        break;
      case BroadcastTxType.pool:
        writer.writeByte(1);
        break;
      case BroadcastTxType.project:
        writer.writeByte(2);
        break;
      case BroadcastTxType.tradeFailOrder:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastTxTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BroadcastTxInfoAdapter extends TypeAdapter<BroadcastTxInfo> {
  @override
  final int typeId = 51;

  @override
  BroadcastTxInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BroadcastTxInfo(
      chain: fields[0] as String,
      symbol: fields[1] as String,
      type: fields[2] as BroadcastTxType,
      txId: fields[3] as String,
      apiParams: fields[5] as String,
    )
      ..isSubmitted = fields[4] as bool
      ..createdAt = fields[6] as DateTime
      ..updatedAt = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, BroadcastTxInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.chain)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.txId)
      ..writeByte(4)
      ..write(obj.isSubmitted)
      ..writeByte(5)
      ..write(obj.apiParams)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastTxInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoinAddressAdapter extends TypeAdapter<CoinAddress> {
  @override
  final int typeId = 13;

  @override
  CoinAddress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoinAddress(
      chain: fields[0] as String,
      symbol: fields[8] as String,
      address: fields[1] as String,
      publicKey: fields[4] as String,
      addressType: fields[2] as String,
      addressMemoOrTag: fields[3] as String,
      description: fields[5] as String,
    )
      ..createdAt = fields[6] as DateTime
      ..updatedAt = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CoinAddress obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.chain)
      ..writeByte(8)
      ..write(obj.symbol)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.addressMemoOrTag)
      ..writeByte(2)
      ..write(obj.addressType)
      ..writeByte(4)
      ..write(obj.publicKey)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinAddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoinBalanceAdapter extends TypeAdapter<CoinBalance> {
  @override
  final int typeId = 14;

  @override
  CoinBalance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoinBalance(
      chain: fields[0] as String,
      symbol: fields[1] as String,
      balance: fields[2] as double,
      unconfirmed: fields[3] as double,
    )
      ..createdAt = fields[4] as DateTime
      ..updatedAt = fields[5] as DateTime
      ..lockUntil = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CoinBalance obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.chain)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.balance)
      ..writeByte(3)
      ..write(obj.unconfirmed)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.lockUntil);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinBalanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoinInfoAdapter extends TypeAdapter<CoinInfo> {
  @override
  final int typeId = 12;

  @override
  CoinInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoinInfo(
      chain: fields[0] as String,
      symbol: fields[1] as String,
      name: fields[3] as String,
      fullName: fields[4] as String,
      chainPrecision: fields[7] as int,
      displayPrecision: fields[8] as int,
      contract: fields[2] as String,
      iconOnline: fields[5] as String,
      iconLocal: fields[6] as String,
      isEnabled: fields[11] as bool,
      isFixed: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CoinInfo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.chain)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.contract)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.fullName)
      ..writeByte(5)
      ..write(obj.iconOnline)
      ..writeByte(6)
      ..write(obj.iconLocal)
      ..writeByte(7)
      ..write(obj.chainPrecision)
      ..writeByte(8)
      ..write(obj.displayPrecision)
      ..writeByte(10)
      ..write(obj.isFixed)
      ..writeByte(11)
      ..write(obj.isEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WalletStatusAdapter extends TypeAdapter<WalletStatus> {
  @override
  final int typeId = 15;

  @override
  WalletStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WalletStatus.synced;
      case 1:
        return WalletStatus.notSynced;
      case 2:
        return WalletStatus.unknown;
      case 3:
        return WalletStatus.loading;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, WalletStatus obj) {
    switch (obj) {
      case WalletStatus.synced:
        writer.writeByte(0);
        break;
      case WalletStatus.notSynced:
        writer.writeByte(1);
        break;
      case WalletStatus.unknown:
        writer.writeByte(2);
        break;
      case WalletStatus.loading:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WalletTypeAdapter extends TypeAdapter<WalletType> {
  @override
  final int typeId = 11;

  @override
  WalletType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WalletType.mnemonicBip44;
      case 1:
        return WalletType.mnemonicBip39;
      case 2:
        return WalletType.privateKey;
      case 3:
        return WalletType.device;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, WalletType obj) {
    switch (obj) {
      case WalletType.mnemonicBip44:
        writer.writeByte(0);
        break;
      case WalletType.mnemonicBip39:
        writer.writeByte(1);
        break;
      case WalletType.privateKey:
        writer.writeByte(2);
        break;
      case WalletType.device:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WalletAdapter extends TypeAdapter<Wallet> {
  @override
  final int typeId = 10;

  @override
  Wallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wallet(
      id: fields[0] as String,
      type: fields[2] as WalletType,
      name: fields[1] as String,
      addresses: (fields[9] as List)?.cast<CoinAddress>(),
      hasBackup: fields[4] as bool,
      coins: (fields[7] as List)?.cast<CoinInfo>(),
    )
      ..status = fields[3] as WalletStatus
      ..createdAt = fields[5] as DateTime
      ..updatedAt = fields[6] as DateTime
      ..balances = (fields[8] as List)?.cast<CoinBalance>();
  }

  @override
  void write(BinaryWriter writer, Wallet obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.hasBackup)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.coins)
      ..writeByte(8)
      ..write(obj.balances)
      ..writeByte(9)
      ..write(obj.addresses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
