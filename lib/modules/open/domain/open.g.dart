// GENERATED CODE - DO NOT MODIFY BY HAND

part of open_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OpenWebviewVM extends OpenWebviewVM {
  @override
  final String fiatCurrency;
  @override
  final bool hasWallet;
  @override
  final Wallet? activeWallet;
  @override
  final String activeWalletId;
  @override
  final WalletStatus activeWalletStatus;
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
  final String Function({required String chain, required String symbol})
      getCoinAddress;
  @override
  final Future<WalletPrivateData> Function(String password) doUnlockWallet;

  factory _$OpenWebviewVM([void Function(OpenWebviewVMBuilder)? updates]) =>
      (new OpenWebviewVMBuilder()..update(updates))._build();

  _$OpenWebviewVM._(
      {required this.fiatCurrency,
      required this.hasWallet,
      this.activeWallet,
      required this.activeWalletId,
      required this.activeWalletStatus,
      required this.onWithdrawBefore,
      required this.submit,
      required this.getCoinBalance,
      required this.getCoinAddress,
      required this.doUnlockWallet})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        fiatCurrency, r'OpenWebviewVM', 'fiatCurrency');
    BuiltValueNullFieldError.checkNotNull(
        hasWallet, r'OpenWebviewVM', 'hasWallet');
    BuiltValueNullFieldError.checkNotNull(
        activeWalletId, r'OpenWebviewVM', 'activeWalletId');
    BuiltValueNullFieldError.checkNotNull(
        activeWalletStatus, r'OpenWebviewVM', 'activeWalletStatus');
    BuiltValueNullFieldError.checkNotNull(
        onWithdrawBefore, r'OpenWebviewVM', 'onWithdrawBefore');
    BuiltValueNullFieldError.checkNotNull(submit, r'OpenWebviewVM', 'submit');
    BuiltValueNullFieldError.checkNotNull(
        getCoinBalance, r'OpenWebviewVM', 'getCoinBalance');
    BuiltValueNullFieldError.checkNotNull(
        getCoinAddress, r'OpenWebviewVM', 'getCoinAddress');
    BuiltValueNullFieldError.checkNotNull(
        doUnlockWallet, r'OpenWebviewVM', 'doUnlockWallet');
  }

  @override
  OpenWebviewVM rebuild(void Function(OpenWebviewVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenWebviewVMBuilder toBuilder() => new OpenWebviewVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenWebviewVM &&
        fiatCurrency == other.fiatCurrency &&
        hasWallet == other.hasWallet &&
        activeWallet == other.activeWallet &&
        activeWalletId == other.activeWalletId &&
        activeWalletStatus == other.activeWalletStatus;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, fiatCurrency.hashCode), hasWallet.hashCode),
                activeWallet.hashCode),
            activeWalletId.hashCode),
        activeWalletStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OpenWebviewVM')
          ..add('fiatCurrency', fiatCurrency)
          ..add('hasWallet', hasWallet)
          ..add('activeWallet', activeWallet)
          ..add('activeWalletId', activeWalletId)
          ..add('activeWalletStatus', activeWalletStatus)
          ..add('onWithdrawBefore', onWithdrawBefore)
          ..add('submit', submit)
          ..add('getCoinBalance', getCoinBalance)
          ..add('getCoinAddress', getCoinAddress)
          ..add('doUnlockWallet', doUnlockWallet))
        .toString();
  }
}

class OpenWebviewVMBuilder
    implements Builder<OpenWebviewVM, OpenWebviewVMBuilder> {
  _$OpenWebviewVM? _$v;

  String? _fiatCurrency;
  String? get fiatCurrency => _$this._fiatCurrency;
  set fiatCurrency(String? fiatCurrency) => _$this._fiatCurrency = fiatCurrency;

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

  String Function({required String chain, required String symbol})?
      _getCoinAddress;
  String Function({required String chain, required String symbol})?
      get getCoinAddress => _$this._getCoinAddress;
  set getCoinAddress(
          String Function({required String chain, required String symbol})?
              getCoinAddress) =>
      _$this._getCoinAddress = getCoinAddress;

  Future<WalletPrivateData> Function(String password)? _doUnlockWallet;
  Future<WalletPrivateData> Function(String password)? get doUnlockWallet =>
      _$this._doUnlockWallet;
  set doUnlockWallet(
          Future<WalletPrivateData> Function(String password)?
              doUnlockWallet) =>
      _$this._doUnlockWallet = doUnlockWallet;

  OpenWebviewVMBuilder();

  OpenWebviewVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fiatCurrency = $v.fiatCurrency;
      _hasWallet = $v.hasWallet;
      _activeWallet = $v.activeWallet;
      _activeWalletId = $v.activeWalletId;
      _activeWalletStatus = $v.activeWalletStatus;
      _onWithdrawBefore = $v.onWithdrawBefore;
      _submit = $v.submit;
      _getCoinBalance = $v.getCoinBalance;
      _getCoinAddress = $v.getCoinAddress;
      _doUnlockWallet = $v.doUnlockWallet;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenWebviewVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OpenWebviewVM;
  }

  @override
  void update(void Function(OpenWebviewVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OpenWebviewVM build() => _build();

  _$OpenWebviewVM _build() {
    final _$result = _$v ??
        new _$OpenWebviewVM._(
            fiatCurrency: BuiltValueNullFieldError.checkNotNull(
                fiatCurrency, r'OpenWebviewVM', 'fiatCurrency'),
            hasWallet: BuiltValueNullFieldError.checkNotNull(
                hasWallet, r'OpenWebviewVM', 'hasWallet'),
            activeWallet: activeWallet,
            activeWalletId: BuiltValueNullFieldError.checkNotNull(
                activeWalletId, r'OpenWebviewVM', 'activeWalletId'),
            activeWalletStatus: BuiltValueNullFieldError.checkNotNull(
                activeWalletStatus, r'OpenWebviewVM', 'activeWalletStatus'),
            onWithdrawBefore: BuiltValueNullFieldError.checkNotNull(
                onWithdrawBefore, r'OpenWebviewVM', 'onWithdrawBefore'),
            submit: BuiltValueNullFieldError.checkNotNull(
                submit, r'OpenWebviewVM', 'submit'),
            getCoinBalance: BuiltValueNullFieldError.checkNotNull(
                getCoinBalance, r'OpenWebviewVM', 'getCoinBalance'),
            getCoinAddress: BuiltValueNullFieldError.checkNotNull(
                getCoinAddress, r'OpenWebviewVM', 'getCoinAddress'),
            doUnlockWallet: BuiltValueNullFieldError.checkNotNull(doUnlockWallet, r'OpenWebviewVM', 'doUnlockWallet'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
