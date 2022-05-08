// GENERATED CODE - DO NOT MODIFY BY HAND

part of invitation_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InvitationState> _$invitationStateSerializer =
    new _$InvitationStateSerializer();

class _$InvitationStateSerializer
    implements StructuredSerializer<InvitationState> {
  @override
  final Iterable<Type> types = const [InvitationState, _$InvitationState];
  @override
  final String wireName = 'InvitationState';

  @override
  Iterable<Object> serialize(Serializers serializers, InvitationState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'invitations',
      serializers.serialize(object.invitations,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Invitation)])),
      'invitationCodes',
      serializers.serialize(object.invitationCodes,
          specifiedType: const FullType(
              BuiltList, const [const FullType(InvitationCode)])),
    ];

    return result;
  }

  @override
  InvitationState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvitationStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'invitations':
          result.invitations.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Invitation)]))
              as BuiltList<Object>);
          break;
        case 'invitationCodes':
          result.invitationCodes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InvitationCode)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$InvitationCreateVM extends InvitationCreateVM {
  @override
  final String walletId;
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
      {AssetCoin coinInfo,
      String toAddress,
      String signCode,
      String sharePrvKey,
      String amount,
      Future<WalletPrivateData> Function() onUnlockWallet,
      void Function(String txId) onSuccessTransaction,
      Future<bool> Function(WalletWithdrawData withdrawData) onConfirmParams,
      Future<bool> Function() onConfirmSubmit}) doSubmitInvitation;
  @override
  final double Function({@required String chain, @required String symbol})
      getCoinBalance;
  @override
  final AssetCoin Function({@required String chain, @required String symbol})
      getCoinInfo;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;
  @override
  final Future<bool> Function(String fork, String toAddress) checkDefiRelation;
  @override
  final List<AssetCoin> Function() getInvitationCoins;

  factory _$InvitationCreateVM(
          [void Function(InvitationCreateVMBuilder) updates]) =>
      (new InvitationCreateVMBuilder()..update(updates)).build();

  _$InvitationCreateVM._(
      {this.walletId,
      this.onWithdrawBefore,
      this.submit,
      this.doSubmitInvitation,
      this.getCoinBalance,
      this.getCoinInfo,
      this.doUnlockWallet,
      this.checkDefiRelation,
      this.getInvitationCoins})
      : super._() {
    if (onWithdrawBefore == null) {
      throw new BuiltValueNullFieldError(
          'InvitationCreateVM', 'onWithdrawBefore');
    }
    if (submit == null) {
      throw new BuiltValueNullFieldError('InvitationCreateVM', 'submit');
    }
    if (doSubmitInvitation == null) {
      throw new BuiltValueNullFieldError(
          'InvitationCreateVM', 'doSubmitInvitation');
    }
    if (getCoinBalance == null) {
      throw new BuiltValueNullFieldError(
          'InvitationCreateVM', 'getCoinBalance');
    }
    if (getCoinInfo == null) {
      throw new BuiltValueNullFieldError('InvitationCreateVM', 'getCoinInfo');
    }
    if (doUnlockWallet == null) {
      throw new BuiltValueNullFieldError(
          'InvitationCreateVM', 'doUnlockWallet');
    }
    if (checkDefiRelation == null) {
      throw new BuiltValueNullFieldError(
          'InvitationCreateVM', 'checkDefiRelation');
    }
    if (getInvitationCoins == null) {
      throw new BuiltValueNullFieldError(
          'InvitationCreateVM', 'getInvitationCoins');
    }
  }

  @override
  InvitationCreateVM rebuild(
          void Function(InvitationCreateVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationCreateVMBuilder toBuilder() =>
      new InvitationCreateVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvitationCreateVM && walletId == other.walletId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, walletId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvitationCreateVM')
          ..add('walletId', walletId)
          ..add('onWithdrawBefore', onWithdrawBefore)
          ..add('submit', submit)
          ..add('doSubmitInvitation', doSubmitInvitation)
          ..add('getCoinBalance', getCoinBalance)
          ..add('getCoinInfo', getCoinInfo)
          ..add('doUnlockWallet', doUnlockWallet)
          ..add('checkDefiRelation', checkDefiRelation)
          ..add('getInvitationCoins', getInvitationCoins))
        .toString();
  }
}

class InvitationCreateVMBuilder
    implements Builder<InvitationCreateVM, InvitationCreateVMBuilder> {
  _$InvitationCreateVM _$v;

  String _walletId;
  String get walletId => _$this._walletId;
  set walletId(String walletId) => _$this._walletId = walletId;

  Future<WalletWithdrawData> Function(
          WithdrawBeforeParams params, WalletWithdrawData previousData)
      _onWithdrawBefore;
  Future<WalletWithdrawData> Function(
          WithdrawBeforeParams params, WalletWithdrawData previousData)
      get onWithdrawBefore => _$this._onWithdrawBefore;
  set onWithdrawBefore(
          Future<WalletWithdrawData> Function(
                  WithdrawBeforeParams params, WalletWithdrawData previousData)
              onWithdrawBefore) =>
      _$this._onWithdrawBefore = onWithdrawBefore;

  Future<String> Function(
      WithdrawSubmitParams params, WalletPrivateData walletData,
      [Future<bool> Function() onConfirmSubmit]) _submit;
  Future<String> Function(
      WithdrawSubmitParams params, WalletPrivateData walletData,
      [Future<bool> Function() onConfirmSubmit]) get submit => _$this._submit;
  set submit(
          Future<String> Function(
                  WithdrawSubmitParams params, WalletPrivateData walletData,
                  [Future<bool> Function() onConfirmSubmit])
              submit) =>
      _$this._submit = submit;

  Future<void> Function(
      {AssetCoin coinInfo,
      String toAddress,
      String signCode,
      String sharePrvKey,
      String amount,
      Future<WalletPrivateData> Function() onUnlockWallet,
      void Function(String txId) onSuccessTransaction,
      Future<bool> Function(WalletWithdrawData withdrawData) onConfirmParams,
      Future<bool> Function() onConfirmSubmit}) _doSubmitInvitation;
  Future<void> Function(
      {AssetCoin coinInfo,
      String toAddress,
      String signCode,
      String sharePrvKey,
      String amount,
      Future<WalletPrivateData> Function() onUnlockWallet,
      void Function(String txId) onSuccessTransaction,
      Future<bool> Function(WalletWithdrawData withdrawData) onConfirmParams,
      Future<bool> Function()
          onConfirmSubmit}) get doSubmitInvitation =>
      _$this._doSubmitInvitation;
  set doSubmitInvitation(
          Future<void> Function(
                  {AssetCoin coinInfo,
                  String toAddress,
                  String signCode,
                  String sharePrvKey,
                  String amount,
                  Future<WalletPrivateData> Function() onUnlockWallet,
                  void Function(String txId) onSuccessTransaction,
                  Future<bool> Function(WalletWithdrawData withdrawData)
                      onConfirmParams,
                  Future<bool> Function() onConfirmSubmit})
              doSubmitInvitation) =>
      _$this._doSubmitInvitation = doSubmitInvitation;

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

  Future<bool> Function(String fork, String toAddress) _checkDefiRelation;
  Future<bool> Function(String fork, String toAddress) get checkDefiRelation =>
      _$this._checkDefiRelation;
  set checkDefiRelation(
          Future<bool> Function(String fork, String toAddress)
              checkDefiRelation) =>
      _$this._checkDefiRelation = checkDefiRelation;

  List<AssetCoin> Function() _getInvitationCoins;
  List<AssetCoin> Function() get getInvitationCoins =>
      _$this._getInvitationCoins;
  set getInvitationCoins(List<AssetCoin> Function() getInvitationCoins) =>
      _$this._getInvitationCoins = getInvitationCoins;

  InvitationCreateVMBuilder();

  InvitationCreateVMBuilder get _$this {
    if (_$v != null) {
      _walletId = _$v.walletId;
      _onWithdrawBefore = _$v.onWithdrawBefore;
      _submit = _$v.submit;
      _doSubmitInvitation = _$v.doSubmitInvitation;
      _getCoinBalance = _$v.getCoinBalance;
      _getCoinInfo = _$v.getCoinInfo;
      _doUnlockWallet = _$v.doUnlockWallet;
      _checkDefiRelation = _$v.checkDefiRelation;
      _getInvitationCoins = _$v.getInvitationCoins;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvitationCreateVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvitationCreateVM;
  }

  @override
  void update(void Function(InvitationCreateVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvitationCreateVM build() {
    final _$result = _$v ??
        new _$InvitationCreateVM._(
            walletId: walletId,
            onWithdrawBefore: onWithdrawBefore,
            submit: submit,
            doSubmitInvitation: doSubmitInvitation,
            getCoinBalance: getCoinBalance,
            getCoinInfo: getCoinInfo,
            doUnlockWallet: doUnlockWallet,
            checkDefiRelation: checkDefiRelation,
            getInvitationCoins: getInvitationCoins);
    replace(_$result);
    return _$result;
  }
}

class _$InvitationListVM extends InvitationListVM {
  @override
  final BuiltList<Invitation> invitations;
  @override
  final Future<int> Function(bool isRefresh, int skip, AssetCoin coin)
      loadInvitationList;
  @override
  final Future<void> Function() clearInvitationList;
  @override
  final List<AssetCoin> Function() getInvitationCoins;

  factory _$InvitationListVM(
          [void Function(InvitationListVMBuilder) updates]) =>
      (new InvitationListVMBuilder()..update(updates)).build();

  _$InvitationListVM._(
      {this.invitations,
      this.loadInvitationList,
      this.clearInvitationList,
      this.getInvitationCoins})
      : super._() {
    if (invitations == null) {
      throw new BuiltValueNullFieldError('InvitationListVM', 'invitations');
    }
    if (loadInvitationList == null) {
      throw new BuiltValueNullFieldError(
          'InvitationListVM', 'loadInvitationList');
    }
    if (clearInvitationList == null) {
      throw new BuiltValueNullFieldError(
          'InvitationListVM', 'clearInvitationList');
    }
    if (getInvitationCoins == null) {
      throw new BuiltValueNullFieldError(
          'InvitationListVM', 'getInvitationCoins');
    }
  }

  @override
  InvitationListVM rebuild(void Function(InvitationListVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationListVMBuilder toBuilder() =>
      new InvitationListVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvitationListVM && invitations == other.invitations;
  }

  @override
  int get hashCode {
    return $jf($jc(0, invitations.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvitationListVM')
          ..add('invitations', invitations)
          ..add('loadInvitationList', loadInvitationList)
          ..add('clearInvitationList', clearInvitationList)
          ..add('getInvitationCoins', getInvitationCoins))
        .toString();
  }
}

class InvitationListVMBuilder
    implements Builder<InvitationListVM, InvitationListVMBuilder> {
  _$InvitationListVM _$v;

  ListBuilder<Invitation> _invitations;
  ListBuilder<Invitation> get invitations =>
      _$this._invitations ??= new ListBuilder<Invitation>();
  set invitations(ListBuilder<Invitation> invitations) =>
      _$this._invitations = invitations;

  Future<int> Function(bool isRefresh, int skip, AssetCoin coin)
      _loadInvitationList;
  Future<int> Function(bool isRefresh, int skip, AssetCoin coin)
      get loadInvitationList => _$this._loadInvitationList;
  set loadInvitationList(
          Future<int> Function(bool isRefresh, int skip, AssetCoin coin)
              loadInvitationList) =>
      _$this._loadInvitationList = loadInvitationList;

  Future<void> Function() _clearInvitationList;
  Future<void> Function() get clearInvitationList =>
      _$this._clearInvitationList;
  set clearInvitationList(Future<void> Function() clearInvitationList) =>
      _$this._clearInvitationList = clearInvitationList;

  List<AssetCoin> Function() _getInvitationCoins;
  List<AssetCoin> Function() get getInvitationCoins =>
      _$this._getInvitationCoins;
  set getInvitationCoins(List<AssetCoin> Function() getInvitationCoins) =>
      _$this._getInvitationCoins = getInvitationCoins;

  InvitationListVMBuilder();

  InvitationListVMBuilder get _$this {
    if (_$v != null) {
      _invitations = _$v.invitations?.toBuilder();
      _loadInvitationList = _$v.loadInvitationList;
      _clearInvitationList = _$v.clearInvitationList;
      _getInvitationCoins = _$v.getInvitationCoins;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvitationListVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvitationListVM;
  }

  @override
  void update(void Function(InvitationListVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvitationListVM build() {
    _$InvitationListVM _$result;
    try {
      _$result = _$v ??
          new _$InvitationListVM._(
              invitations: invitations.build(),
              loadInvitationList: loadInvitationList,
              clearInvitationList: clearInvitationList,
              getInvitationCoins: getInvitationCoins);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'invitations';
        invitations.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvitationListVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvitationSelectVM extends InvitationSelectVM {
  @override
  final String walletId;
  @override
  final BuiltList<InvitationCode> invitationCodes;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;
  @override
  final List<AssetCoin> Function() getInvitationCoins;
  @override
  final void Function() loadInvitationCode;
  @override
  final Future<InvitationCode> Function({String mnemonic, AssetCoin coinInfo})
      createInvitationCode;

  factory _$InvitationSelectVM(
          [void Function(InvitationSelectVMBuilder) updates]) =>
      (new InvitationSelectVMBuilder()..update(updates)).build();

  _$InvitationSelectVM._(
      {this.walletId,
      this.invitationCodes,
      this.doUnlockWallet,
      this.getInvitationCoins,
      this.loadInvitationCode,
      this.createInvitationCode})
      : super._() {
    if (invitationCodes == null) {
      throw new BuiltValueNullFieldError(
          'InvitationSelectVM', 'invitationCodes');
    }
    if (doUnlockWallet == null) {
      throw new BuiltValueNullFieldError(
          'InvitationSelectVM', 'doUnlockWallet');
    }
    if (getInvitationCoins == null) {
      throw new BuiltValueNullFieldError(
          'InvitationSelectVM', 'getInvitationCoins');
    }
    if (loadInvitationCode == null) {
      throw new BuiltValueNullFieldError(
          'InvitationSelectVM', 'loadInvitationCode');
    }
    if (createInvitationCode == null) {
      throw new BuiltValueNullFieldError(
          'InvitationSelectVM', 'createInvitationCode');
    }
  }

  @override
  InvitationSelectVM rebuild(
          void Function(InvitationSelectVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationSelectVMBuilder toBuilder() =>
      new InvitationSelectVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvitationSelectVM &&
        walletId == other.walletId &&
        invitationCodes == other.invitationCodes;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, walletId.hashCode), invitationCodes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvitationSelectVM')
          ..add('walletId', walletId)
          ..add('invitationCodes', invitationCodes)
          ..add('doUnlockWallet', doUnlockWallet)
          ..add('getInvitationCoins', getInvitationCoins)
          ..add('loadInvitationCode', loadInvitationCode)
          ..add('createInvitationCode', createInvitationCode))
        .toString();
  }
}

class InvitationSelectVMBuilder
    implements Builder<InvitationSelectVM, InvitationSelectVMBuilder> {
  _$InvitationSelectVM _$v;

  String _walletId;
  String get walletId => _$this._walletId;
  set walletId(String walletId) => _$this._walletId = walletId;

  ListBuilder<InvitationCode> _invitationCodes;
  ListBuilder<InvitationCode> get invitationCodes =>
      _$this._invitationCodes ??= new ListBuilder<InvitationCode>();
  set invitationCodes(ListBuilder<InvitationCode> invitationCodes) =>
      _$this._invitationCodes = invitationCodes;

  Future<WalletPrivateData> Function(String password) _doUnlockWallet;
  Future<WalletPrivateData> Function(String password) get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password) doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  List<AssetCoin> Function() _getInvitationCoins;
  List<AssetCoin> Function() get getInvitationCoins =>
      _$this._getInvitationCoins;
  set getInvitationCoins(List<AssetCoin> Function() getInvitationCoins) =>
      _$this._getInvitationCoins = getInvitationCoins;

  void Function() _loadInvitationCode;
  void Function() get loadInvitationCode => _$this._loadInvitationCode;
  set loadInvitationCode(void Function() loadInvitationCode) =>
      _$this._loadInvitationCode = loadInvitationCode;

  Future<InvitationCode> Function({String mnemonic, AssetCoin coinInfo})
      _createInvitationCode;
  Future<InvitationCode> Function({String mnemonic, AssetCoin coinInfo})
      get createInvitationCode => _$this._createInvitationCode;
  set createInvitationCode(
          Future<InvitationCode> Function({String mnemonic, AssetCoin coinInfo})
              createInvitationCode) =>
      _$this._createInvitationCode = createInvitationCode;

  InvitationSelectVMBuilder();

  InvitationSelectVMBuilder get _$this {
    if (_$v != null) {
      _walletId = _$v.walletId;
      _invitationCodes = _$v.invitationCodes?.toBuilder();
      _doUnlockWallet = _$v.doUnlockWallet;
      _getInvitationCoins = _$v.getInvitationCoins;
      _loadInvitationCode = _$v.loadInvitationCode;
      _createInvitationCode = _$v.createInvitationCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvitationSelectVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvitationSelectVM;
  }

  @override
  void update(void Function(InvitationSelectVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvitationSelectVM build() {
    _$InvitationSelectVM _$result;
    try {
      _$result = _$v ??
          new _$InvitationSelectVM._(
              walletId: walletId,
              invitationCodes: invitationCodes.build(),
              doUnlockWallet: doUnlockWallet,
              getInvitationCoins: getInvitationCoins,
              loadInvitationCode: loadInvitationCode,
              createInvitationCode: createInvitationCode);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'invitationCodes';
        invitationCodes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvitationSelectVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvitationState extends InvitationState {
  @override
  final BuiltList<Invitation> invitations;
  @override
  final BuiltList<InvitationCode> invitationCodes;

  factory _$InvitationState([void Function(InvitationStateBuilder) updates]) =>
      (new InvitationStateBuilder()..update(updates)).build();

  _$InvitationState._({this.invitations, this.invitationCodes}) : super._() {
    if (invitations == null) {
      throw new BuiltValueNullFieldError('InvitationState', 'invitations');
    }
    if (invitationCodes == null) {
      throw new BuiltValueNullFieldError('InvitationState', 'invitationCodes');
    }
  }

  @override
  InvitationState rebuild(void Function(InvitationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationStateBuilder toBuilder() =>
      new InvitationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvitationState &&
        invitations == other.invitations &&
        invitationCodes == other.invitationCodes;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, invitations.hashCode), invitationCodes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvitationState')
          ..add('invitations', invitations)
          ..add('invitationCodes', invitationCodes))
        .toString();
  }
}

class InvitationStateBuilder
    implements Builder<InvitationState, InvitationStateBuilder> {
  _$InvitationState _$v;

  ListBuilder<Invitation> _invitations;
  ListBuilder<Invitation> get invitations =>
      _$this._invitations ??= new ListBuilder<Invitation>();
  set invitations(ListBuilder<Invitation> invitations) =>
      _$this._invitations = invitations;

  ListBuilder<InvitationCode> _invitationCodes;
  ListBuilder<InvitationCode> get invitationCodes =>
      _$this._invitationCodes ??= new ListBuilder<InvitationCode>();
  set invitationCodes(ListBuilder<InvitationCode> invitationCodes) =>
      _$this._invitationCodes = invitationCodes;

  InvitationStateBuilder();

  InvitationStateBuilder get _$this {
    if (_$v != null) {
      _invitations = _$v.invitations?.toBuilder();
      _invitationCodes = _$v.invitationCodes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvitationState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvitationState;
  }

  @override
  void update(void Function(InvitationStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvitationState build() {
    _$InvitationState _$result;
    try {
      _$result = _$v ??
          new _$InvitationState._(
              invitations: invitations.build(),
              invitationCodes: invitationCodes.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'invitations';
        invitations.build();
        _$failedField = 'invitationCodes';
        invitationCodes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvitationState', _$failedField, e.toString());
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

class InvitationCodeAdapter extends TypeAdapter<InvitationCode> {
  @override
  final int typeId = 60;

  @override
  InvitationCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvitationCode()
      ..chain = fields[0] as String
      ..symbol = fields[1] as String
      ..fork = fields[2] as String
      ..address = fields[4] as String
      ..subSign = fields[5] as String
      ..sharePrvKey = fields[6] as String
      ..createdAt = fields[7] as int;
  }

  @override
  void write(BinaryWriter writer, InvitationCode obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.chain)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.fork)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.subSign)
      ..writeByte(6)
      ..write(obj.sharePrvKey)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvitationCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
