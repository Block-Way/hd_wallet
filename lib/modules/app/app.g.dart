// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ModulePermissionVM extends ModulePermissionVM {
  @override
  final int configState;
  @override
  final int tradeConfigState;
  @override
  final int investConfigState;
  @override
  final int swapConfigState;
  @override
  final int communityConfigState;
  @override
  final ConfigUpdateData newVersionData;
  @override
  final BuiltMap<String, String> disabledModules;
  @override
  final Future<bool> Function(
          String moduleName, ModulePermissionState permission)
      doRefreshModulePermission;
  @override
  final ModulePermissionState Function(String moduleName) getModulePermission;

  factory _$ModulePermissionVM(
          [void Function(ModulePermissionVMBuilder) updates]) =>
      (new ModulePermissionVMBuilder()..update(updates)).build();

  _$ModulePermissionVM._(
      {this.configState,
      this.tradeConfigState,
      this.investConfigState,
      this.swapConfigState,
      this.communityConfigState,
      this.newVersionData,
      this.disabledModules,
      this.doRefreshModulePermission,
      this.getModulePermission})
      : super._() {
    if (doRefreshModulePermission == null) {
      throw new BuiltValueNullFieldError(
          'ModulePermissionVM', 'doRefreshModulePermission');
    }
    if (getModulePermission == null) {
      throw new BuiltValueNullFieldError(
          'ModulePermissionVM', 'getModulePermission');
    }
  }

  @override
  ModulePermissionVM rebuild(
          void Function(ModulePermissionVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModulePermissionVMBuilder toBuilder() =>
      new ModulePermissionVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModulePermissionVM &&
        configState == other.configState &&
        tradeConfigState == other.tradeConfigState &&
        investConfigState == other.investConfigState &&
        swapConfigState == other.swapConfigState &&
        communityConfigState == other.communityConfigState &&
        newVersionData == other.newVersionData &&
        disabledModules == other.disabledModules;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, configState.hashCode),
                            tradeConfigState.hashCode),
                        investConfigState.hashCode),
                    swapConfigState.hashCode),
                communityConfigState.hashCode),
            newVersionData.hashCode),
        disabledModules.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ModulePermissionVM')
          ..add('configState', configState)
          ..add('tradeConfigState', tradeConfigState)
          ..add('investConfigState', investConfigState)
          ..add('swapConfigState', swapConfigState)
          ..add('communityConfigState', communityConfigState)
          ..add('newVersionData', newVersionData)
          ..add('disabledModules', disabledModules)
          ..add('doRefreshModulePermission', doRefreshModulePermission)
          ..add('getModulePermission', getModulePermission))
        .toString();
  }
}

class ModulePermissionVMBuilder
    implements Builder<ModulePermissionVM, ModulePermissionVMBuilder> {
  _$ModulePermissionVM _$v;

  int _configState;
  int get configState => _$this._configState;
  set configState(int configState) => _$this._configState = configState;

  int _tradeConfigState;
  int get tradeConfigState => _$this._tradeConfigState;
  set tradeConfigState(int tradeConfigState) =>
      _$this._tradeConfigState = tradeConfigState;

  int _investConfigState;
  int get investConfigState => _$this._investConfigState;
  set investConfigState(int investConfigState) =>
      _$this._investConfigState = investConfigState;

  int _swapConfigState;
  int get swapConfigState => _$this._swapConfigState;
  set swapConfigState(int swapConfigState) =>
      _$this._swapConfigState = swapConfigState;

  int _communityConfigState;
  int get communityConfigState => _$this._communityConfigState;
  set communityConfigState(int communityConfigState) =>
      _$this._communityConfigState = communityConfigState;

  ConfigUpdateDataBuilder _newVersionData;
  ConfigUpdateDataBuilder get newVersionData =>
      _$this._newVersionData ??= new ConfigUpdateDataBuilder();
  set newVersionData(ConfigUpdateDataBuilder newVersionData) =>
      _$this._newVersionData = newVersionData;

  MapBuilder<String, String> _disabledModules;
  MapBuilder<String, String> get disabledModules =>
      _$this._disabledModules ??= new MapBuilder<String, String>();
  set disabledModules(MapBuilder<String, String> disabledModules) =>
      _$this._disabledModules = disabledModules;

  Future<bool> Function(String moduleName, ModulePermissionState permission)
      _doRefreshModulePermission;
  Future<bool> Function(String moduleName, ModulePermissionState permission)
      get doRefreshModulePermission => _$this._doRefreshModulePermission;
  set doRefreshModulePermission(
          Future<bool> Function(
                  String moduleName, ModulePermissionState permission)
              doRefreshModulePermission) =>
      _$this._doRefreshModulePermission = doRefreshModulePermission;

  ModulePermissionState Function(String moduleName) _getModulePermission;
  ModulePermissionState Function(String moduleName) get getModulePermission =>
      _$this._getModulePermission;
  set getModulePermission(
          ModulePermissionState Function(String moduleName)
              getModulePermission) =>
      _$this._getModulePermission = getModulePermission;

  ModulePermissionVMBuilder();

  ModulePermissionVMBuilder get _$this {
    if (_$v != null) {
      _configState = _$v.configState;
      _tradeConfigState = _$v.tradeConfigState;
      _investConfigState = _$v.investConfigState;
      _swapConfigState = _$v.swapConfigState;
      _communityConfigState = _$v.communityConfigState;
      _newVersionData = _$v.newVersionData?.toBuilder();
      _disabledModules = _$v.disabledModules?.toBuilder();
      _doRefreshModulePermission = _$v.doRefreshModulePermission;
      _getModulePermission = _$v.getModulePermission;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ModulePermissionVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ModulePermissionVM;
  }

  @override
  void update(void Function(ModulePermissionVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ModulePermissionVM build() {
    _$ModulePermissionVM _$result;
    try {
      _$result = _$v ??
          new _$ModulePermissionVM._(
              configState: configState,
              tradeConfigState: tradeConfigState,
              investConfigState: investConfigState,
              swapConfigState: swapConfigState,
              communityConfigState: communityConfigState,
              newVersionData: _newVersionData?.build(),
              disabledModules: _disabledModules?.build(),
              doRefreshModulePermission: doRefreshModulePermission,
              getModulePermission: getModulePermission);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'newVersionData';
        _newVersionData?.build();
        _$failedField = 'disabledModules';
        _disabledModules?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ModulePermissionVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AppState extends AppState {
  @override
  final CommonState commonState;
  @override
  final AssetState assetState;
  @override
  final WalletState walletState;
  @override
  final NoticeState noticeState;
  @override
  final HomeState homeState;
  @override
  final SwapState swapState;
  @override
  final TradeState tradeState;
  @override
  final InvitationState invitationState;
  @override
  final CommunityState communityState;
  @override
  final HDKeyState hdkeyState;
  @override
  final InvestState investState;
  @override
  final AdmissionState admissionState;
  @override
  final ProjectState projectState;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.commonState,
      this.assetState,
      this.walletState,
      this.noticeState,
      this.homeState,
      this.swapState,
      this.tradeState,
      this.invitationState,
      this.communityState,
      this.hdkeyState,
      this.investState,
      this.admissionState,
      this.projectState})
      : super._() {
    if (commonState == null) {
      throw new BuiltValueNullFieldError('AppState', 'commonState');
    }
    if (assetState == null) {
      throw new BuiltValueNullFieldError('AppState', 'assetState');
    }
    if (walletState == null) {
      throw new BuiltValueNullFieldError('AppState', 'walletState');
    }
    if (noticeState == null) {
      throw new BuiltValueNullFieldError('AppState', 'noticeState');
    }
    if (homeState == null) {
      throw new BuiltValueNullFieldError('AppState', 'homeState');
    }
    if (swapState == null) {
      throw new BuiltValueNullFieldError('AppState', 'swapState');
    }
    if (tradeState == null) {
      throw new BuiltValueNullFieldError('AppState', 'tradeState');
    }
    if (invitationState == null) {
      throw new BuiltValueNullFieldError('AppState', 'invitationState');
    }
    if (communityState == null) {
      throw new BuiltValueNullFieldError('AppState', 'communityState');
    }
    if (hdkeyState == null) {
      throw new BuiltValueNullFieldError('AppState', 'hdkeyState');
    }
    if (investState == null) {
      throw new BuiltValueNullFieldError('AppState', 'investState');
    }
    if (admissionState == null) {
      throw new BuiltValueNullFieldError('AppState', 'admissionState');
    }
    if (projectState == null) {
      throw new BuiltValueNullFieldError('AppState', 'projectState');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        commonState == other.commonState &&
        assetState == other.assetState &&
        walletState == other.walletState &&
        noticeState == other.noticeState &&
        homeState == other.homeState &&
        swapState == other.swapState &&
        tradeState == other.tradeState &&
        invitationState == other.invitationState &&
        communityState == other.communityState &&
        hdkeyState == other.hdkeyState &&
        investState == other.investState &&
        admissionState == other.admissionState &&
        projectState == other.projectState;
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
                                                    $jc(0,
                                                        commonState.hashCode),
                                                    assetState.hashCode),
                                                walletState.hashCode),
                                            noticeState.hashCode),
                                        homeState.hashCode),
                                    swapState.hashCode),
                                tradeState.hashCode),
                            invitationState.hashCode),
                        communityState.hashCode),
                    hdkeyState.hashCode),
                investState.hashCode),
            admissionState.hashCode),
        projectState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('commonState', commonState)
          ..add('assetState', assetState)
          ..add('walletState', walletState)
          ..add('noticeState', noticeState)
          ..add('homeState', homeState)
          ..add('swapState', swapState)
          ..add('tradeState', tradeState)
          ..add('invitationState', invitationState)
          ..add('communityState', communityState)
          ..add('hdkeyState', hdkeyState)
          ..add('investState', investState)
          ..add('admissionState', admissionState)
          ..add('projectState', projectState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  CommonStateBuilder _commonState;
  CommonStateBuilder get commonState =>
      _$this._commonState ??= new CommonStateBuilder();
  set commonState(CommonStateBuilder commonState) =>
      _$this._commonState = commonState;

  AssetStateBuilder _assetState;
  AssetStateBuilder get assetState =>
      _$this._assetState ??= new AssetStateBuilder();
  set assetState(AssetStateBuilder assetState) =>
      _$this._assetState = assetState;

  WalletStateBuilder _walletState;
  WalletStateBuilder get walletState =>
      _$this._walletState ??= new WalletStateBuilder();
  set walletState(WalletStateBuilder walletState) =>
      _$this._walletState = walletState;

  NoticeStateBuilder _noticeState;
  NoticeStateBuilder get noticeState =>
      _$this._noticeState ??= new NoticeStateBuilder();
  set noticeState(NoticeStateBuilder noticeState) =>
      _$this._noticeState = noticeState;

  HomeStateBuilder _homeState;
  HomeStateBuilder get homeState =>
      _$this._homeState ??= new HomeStateBuilder();
  set homeState(HomeStateBuilder homeState) => _$this._homeState = homeState;

  SwapStateBuilder _swapState;
  SwapStateBuilder get swapState =>
      _$this._swapState ??= new SwapStateBuilder();
  set swapState(SwapStateBuilder swapState) => _$this._swapState = swapState;

  TradeStateBuilder _tradeState;
  TradeStateBuilder get tradeState =>
      _$this._tradeState ??= new TradeStateBuilder();
  set tradeState(TradeStateBuilder tradeState) =>
      _$this._tradeState = tradeState;

  InvitationStateBuilder _invitationState;
  InvitationStateBuilder get invitationState =>
      _$this._invitationState ??= new InvitationStateBuilder();
  set invitationState(InvitationStateBuilder invitationState) =>
      _$this._invitationState = invitationState;

  CommunityStateBuilder _communityState;
  CommunityStateBuilder get communityState =>
      _$this._communityState ??= new CommunityStateBuilder();
  set communityState(CommunityStateBuilder communityState) =>
      _$this._communityState = communityState;

  HDKeyStateBuilder _hdkeyState;
  HDKeyStateBuilder get hdkeyState =>
      _$this._hdkeyState ??= new HDKeyStateBuilder();
  set hdkeyState(HDKeyStateBuilder hdkeyState) =>
      _$this._hdkeyState = hdkeyState;

  InvestStateBuilder _investState;
  InvestStateBuilder get investState =>
      _$this._investState ??= new InvestStateBuilder();
  set investState(InvestStateBuilder investState) =>
      _$this._investState = investState;

  AdmissionStateBuilder _admissionState;
  AdmissionStateBuilder get admissionState =>
      _$this._admissionState ??= new AdmissionStateBuilder();
  set admissionState(AdmissionStateBuilder admissionState) =>
      _$this._admissionState = admissionState;

  ProjectStateBuilder _projectState;
  ProjectStateBuilder get projectState =>
      _$this._projectState ??= new ProjectStateBuilder();
  set projectState(ProjectStateBuilder projectState) =>
      _$this._projectState = projectState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _commonState = _$v.commonState?.toBuilder();
      _assetState = _$v.assetState?.toBuilder();
      _walletState = _$v.walletState?.toBuilder();
      _noticeState = _$v.noticeState?.toBuilder();
      _homeState = _$v.homeState?.toBuilder();
      _swapState = _$v.swapState?.toBuilder();
      _tradeState = _$v.tradeState?.toBuilder();
      _invitationState = _$v.invitationState?.toBuilder();
      _communityState = _$v.communityState?.toBuilder();
      _hdkeyState = _$v.hdkeyState?.toBuilder();
      _investState = _$v.investState?.toBuilder();
      _admissionState = _$v.admissionState?.toBuilder();
      _projectState = _$v.projectState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              commonState: commonState.build(),
              assetState: assetState.build(),
              walletState: walletState.build(),
              noticeState: noticeState.build(),
              homeState: homeState.build(),
              swapState: swapState.build(),
              tradeState: tradeState.build(),
              invitationState: invitationState.build(),
              communityState: communityState.build(),
              hdkeyState: hdkeyState.build(),
              investState: investState.build(),
              admissionState: admissionState.build(),
              projectState: projectState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'commonState';
        commonState.build();
        _$failedField = 'assetState';
        assetState.build();
        _$failedField = 'walletState';
        walletState.build();
        _$failedField = 'noticeState';
        noticeState.build();
        _$failedField = 'homeState';
        homeState.build();
        _$failedField = 'swapState';
        swapState.build();
        _$failedField = 'tradeState';
        tradeState.build();
        _$failedField = 'invitationState';
        invitationState.build();
        _$failedField = 'communityState';
        communityState.build();
        _$failedField = 'hdkeyState';
        hdkeyState.build();
        _$failedField = 'investState';
        investState.build();
        _$failedField = 'admissionState';
        admissionState.build();
        _$failedField = 'projectState';
        projectState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
