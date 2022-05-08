// GENERATED CODE - DO NOT MODIFY BY HAND

part of invest_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InvestConfig> _$investConfigSerializer =
    new _$InvestConfigSerializer();
Serializer<MintChart> _$mintChartSerializer = new _$MintChartSerializer();
Serializer<MintInfo> _$mintInfoSerializer = new _$MintInfoSerializer();
Serializer<MintItem> _$mintItemSerializer = new _$MintItemSerializer();
Serializer<ProfitInvitationItem> _$profitInvitationItemSerializer =
    new _$ProfitInvitationItemSerializer();
Serializer<ProfitRecordItem> _$profitRecordItemSerializer =
    new _$ProfitRecordItemSerializer();

class _$InvestConfigSerializer implements StructuredSerializer<InvestConfig> {
  @override
  final Iterable<Type> types = const [InvestConfig, _$InvestConfig];
  @override
  final String wireName = 'InvestConfig';

  @override
  Iterable<Object> serialize(Serializers serializers, InvestConfig object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.mints != null) {
      result
        ..add('mints')
        ..add(serializers.serialize(object.mints,
            specifiedType:
                const FullType(BuiltList, const [const FullType(MintItem)])));
    }
    if (object.airdrops != null) {
      result
        ..add('airdrops')
        ..add(serializers.serialize(object.airdrops,
            specifiedType:
                const FullType(BuiltList, const [const FullType(MintItem)])));
    }
    return result;
  }

  @override
  InvestConfig deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InvestConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'mints':
          result.mints.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(MintItem)]))
              as BuiltList<Object>);
          break;
        case 'airdrops':
          result.airdrops.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(MintItem)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$MintChartSerializer implements StructuredSerializer<MintChart> {
  @override
  final Iterable<Type> types = const [MintChart, _$MintChart];
  @override
  final String wireName = 'MintChart';

  @override
  Iterable<Object> serialize(Serializers serializers, MintChart object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.balance != null) {
      result
        ..add('balance')
        ..add(serializers.serialize(object.balance,
            specifiedType: const FullType(String)));
    }
    if (object.reward != null) {
      result
        ..add('reward')
        ..add(serializers.serialize(object.reward,
            specifiedType: const FullType(String)));
    }
    if (object.isBalance != null) {
      result
        ..add('user_balance')
        ..add(serializers.serialize(object.isBalance,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  MintChart deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MintChartBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'reward':
          result.reward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_balance':
          result.isBalance = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$MintInfoSerializer implements StructuredSerializer<MintInfo> {
  @override
  final Iterable<Type> types = const [MintInfo, _$MintInfo];
  @override
  final String wireName = 'MintInfo';

  @override
  Iterable<Object> serialize(Serializers serializers, MintInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'min_balance',
      serializers.serialize(object.minBalance,
          specifiedType: const FullType(String)),
      'best_balance',
      serializers.serialize(object.bestBalance,
          specifiedType: const FullType(String)),
      'best_balance_reward',
      serializers.serialize(object.bestBalanceReward,
          specifiedType: const FullType(String)),
      'min_balance_reward',
      serializers.serialize(object.minBalanceReward,
          specifiedType: const FullType(String)),
    ];
    if (object.promotionReward != null) {
      result
        ..add('promotion_reward')
        ..add(serializers.serialize(object.promotionReward,
            specifiedType: const FullType(String)));
    }
    if (object.stakeReward != null) {
      result
        ..add('stake_reward')
        ..add(serializers.serialize(object.stakeReward,
            specifiedType: const FullType(String)));
    }
    if (object.thisStakeReward != null) {
      result
        ..add('this_stake_reward')
        ..add(serializers.serialize(object.thisStakeReward,
            specifiedType: const FullType(String)));
    }
    if (object.thisBalance != null) {
      result
        ..add('this_balance')
        ..add(serializers.serialize(object.thisBalance,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  MintInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MintInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'promotion_reward':
          result.promotionReward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'stake_reward':
          result.stakeReward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'this_stake_reward':
          result.thisStakeReward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'this_balance':
          result.thisBalance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'min_balance':
          result.minBalance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'best_balance':
          result.bestBalance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'best_balance_reward':
          result.bestBalanceReward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'min_balance_reward':
          result.minBalanceReward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$MintItemSerializer implements StructuredSerializer<MintItem> {
  @override
  final Iterable<Type> types = const [MintItem, _$MintItem];
  @override
  final String wireName = 'MintItem';

  @override
  Iterable<Object> serialize(Serializers serializers, MintItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'symbol',
      serializers.serialize(object.symbol,
          specifiedType: const FullType(String)),
      'chain',
      serializers.serialize(object.chain,
          specifiedType: const FullType(String)),
    ];
    if (object.forkId != null) {
      result
        ..add('fork')
        ..add(serializers.serialize(object.forkId,
            specifiedType: const FullType(String)));
    }
    if (object.mintEnable != null) {
      result
        ..add('mint_enable')
        ..add(serializers.serialize(object.mintEnable,
            specifiedType: const FullType(int)));
    }
    if (object.minBalance != null) {
      result
        ..add('min_balance')
        ..add(serializers.serialize(object.minBalance,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  MintItem deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MintItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fork':
          result.forkId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'chain':
          result.chain = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'mint_enable':
          result.mintEnable = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'min_balance':
          result.minBalance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$ProfitInvitationItemSerializer
    implements StructuredSerializer<ProfitInvitationItem> {
  @override
  final Iterable<Type> types = const [
    ProfitInvitationItem,
    _$ProfitInvitationItem
  ];
  @override
  final String wireName = 'ProfitInvitationItem';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ProfitInvitationItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      '_id',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(String)),
    ];
    if (object.height != null) {
      result
        ..add('height')
        ..add(serializers.serialize(object.height,
            specifiedType: const FullType(String)));
    }
    if (object.time != null) {
      result
        ..add('time')
        ..add(serializers.serialize(object.time,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ProfitInvitationItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfitInvitationItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case '_id':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'time':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProfitRecordItemSerializer
    implements StructuredSerializer<ProfitRecordItem> {
  @override
  final Iterable<Type> types = const [ProfitRecordItem, _$ProfitRecordItem];
  @override
  final String wireName = 'ProfitRecordItem';

  @override
  Iterable<Object> serialize(Serializers serializers, ProfitRecordItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'height',
      serializers.serialize(object.height, specifiedType: const FullType(int)),
      'balance',
      serializers.serialize(object.balance,
          specifiedType: const FullType(String)),
      'stake_reward',
      serializers.serialize(object.stakeReward,
          specifiedType: const FullType(String)),
      'promotion_reward',
      serializers.serialize(object.promotionReward,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ProfitRecordItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfitRecordItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'balance':
          result.balance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'stake_reward':
          result.stakeReward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'promotion_reward':
          result.promotionReward = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$InvestHomeVM extends InvestHomeVM {
  @override
  final bool hasWallet;
  @override
  final String fiatCurrency;
  @override
  final MintItem activeMint;
  @override
  final BuiltList<MintItem> mints;
  @override
  final MintInfo mintInfo;
  @override
  final BuiltList<MintChart> chartList;
  @override
  final BuiltList<ProfitInvitationItem> profitInvitationList;
  @override
  final AssetCoin Function({String chain, String symbol}) getCoinInfo;
  @override
  final Future<void> Function(MintItem mint) doSwitchMint;
  @override
  final Future<void> Function() refreshMintReward;
  @override
  final Future<int> Function({bool isRefresh, int skip, int take})
      getProfitInvitationList;
  @override
  final MintItem Function() getDefaultMint;

  factory _$InvestHomeVM([void Function(InvestHomeVMBuilder) updates]) =>
      (new InvestHomeVMBuilder()..update(updates)).build();

  _$InvestHomeVM._(
      {this.hasWallet,
      this.fiatCurrency,
      this.activeMint,
      this.mints,
      this.mintInfo,
      this.chartList,
      this.profitInvitationList,
      this.getCoinInfo,
      this.doSwitchMint,
      this.refreshMintReward,
      this.getProfitInvitationList,
      this.getDefaultMint})
      : super._() {
    if (hasWallet == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'hasWallet');
    }
    if (fiatCurrency == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'fiatCurrency');
    }
    if (mints == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'mints');
    }
    if (chartList == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'chartList');
    }
    if (profitInvitationList == null) {
      throw new BuiltValueNullFieldError(
          'InvestHomeVM', 'profitInvitationList');
    }
    if (getCoinInfo == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'getCoinInfo');
    }
    if (doSwitchMint == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'doSwitchMint');
    }
    if (refreshMintReward == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'refreshMintReward');
    }
    if (getProfitInvitationList == null) {
      throw new BuiltValueNullFieldError(
          'InvestHomeVM', 'getProfitInvitationList');
    }
    if (getDefaultMint == null) {
      throw new BuiltValueNullFieldError('InvestHomeVM', 'getDefaultMint');
    }
  }

  @override
  InvestHomeVM rebuild(void Function(InvestHomeVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestHomeVMBuilder toBuilder() => new InvestHomeVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestHomeVM &&
        hasWallet == other.hasWallet &&
        fiatCurrency == other.fiatCurrency &&
        activeMint == other.activeMint &&
        mints == other.mints &&
        mintInfo == other.mintInfo &&
        chartList == other.chartList &&
        profitInvitationList == other.profitInvitationList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, hasWallet.hashCode), fiatCurrency.hashCode),
                        activeMint.hashCode),
                    mints.hashCode),
                mintInfo.hashCode),
            chartList.hashCode),
        profitInvitationList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvestHomeVM')
          ..add('hasWallet', hasWallet)
          ..add('fiatCurrency', fiatCurrency)
          ..add('activeMint', activeMint)
          ..add('mints', mints)
          ..add('mintInfo', mintInfo)
          ..add('chartList', chartList)
          ..add('profitInvitationList', profitInvitationList)
          ..add('getCoinInfo', getCoinInfo)
          ..add('doSwitchMint', doSwitchMint)
          ..add('refreshMintReward', refreshMintReward)
          ..add('getProfitInvitationList', getProfitInvitationList)
          ..add('getDefaultMint', getDefaultMint))
        .toString();
  }
}

class InvestHomeVMBuilder
    implements Builder<InvestHomeVM, InvestHomeVMBuilder> {
  _$InvestHomeVM _$v;

  bool _hasWallet;
  bool get hasWallet => _$this._hasWallet;
  set hasWallet(bool hasWallet) => _$this._hasWallet = hasWallet;

  String _fiatCurrency;
  String get fiatCurrency => _$this._fiatCurrency;
  set fiatCurrency(String fiatCurrency) => _$this._fiatCurrency = fiatCurrency;

  MintItemBuilder _activeMint;
  MintItemBuilder get activeMint =>
      _$this._activeMint ??= new MintItemBuilder();
  set activeMint(MintItemBuilder activeMint) => _$this._activeMint = activeMint;

  ListBuilder<MintItem> _mints;
  ListBuilder<MintItem> get mints =>
      _$this._mints ??= new ListBuilder<MintItem>();
  set mints(ListBuilder<MintItem> mints) => _$this._mints = mints;

  MintInfoBuilder _mintInfo;
  MintInfoBuilder get mintInfo => _$this._mintInfo ??= new MintInfoBuilder();
  set mintInfo(MintInfoBuilder mintInfo) => _$this._mintInfo = mintInfo;

  ListBuilder<MintChart> _chartList;
  ListBuilder<MintChart> get chartList =>
      _$this._chartList ??= new ListBuilder<MintChart>();
  set chartList(ListBuilder<MintChart> chartList) =>
      _$this._chartList = chartList;

  ListBuilder<ProfitInvitationItem> _profitInvitationList;
  ListBuilder<ProfitInvitationItem> get profitInvitationList =>
      _$this._profitInvitationList ??= new ListBuilder<ProfitInvitationItem>();
  set profitInvitationList(
          ListBuilder<ProfitInvitationItem> profitInvitationList) =>
      _$this._profitInvitationList = profitInvitationList;

  AssetCoin Function({String chain, String symbol}) _getCoinInfo;
  AssetCoin Function({String chain, String symbol}) get getCoinInfo =>
      _$this._getCoinInfo;
  set getCoinInfo(
          AssetCoin Function({String chain, String symbol}) getCoinInfo) =>
      _$this._getCoinInfo = getCoinInfo;

  Future<void> Function(MintItem mint) _doSwitchMint;
  Future<void> Function(MintItem mint) get doSwitchMint => _$this._doSwitchMint;
  set doSwitchMint(Future<void> Function(MintItem mint) doSwitchMint) =>
      _$this._doSwitchMint = doSwitchMint;

  Future<void> Function() _refreshMintReward;
  Future<void> Function() get refreshMintReward => _$this._refreshMintReward;
  set refreshMintReward(Future<void> Function() refreshMintReward) =>
      _$this._refreshMintReward = refreshMintReward;

  Future<int> Function({bool isRefresh, int skip, int take})
      _getProfitInvitationList;
  Future<int> Function({bool isRefresh, int skip, int take})
      get getProfitInvitationList => _$this._getProfitInvitationList;
  set getProfitInvitationList(
          Future<int> Function({bool isRefresh, int skip, int take})
              getProfitInvitationList) =>
      _$this._getProfitInvitationList = getProfitInvitationList;

  MintItem Function() _getDefaultMint;
  MintItem Function() get getDefaultMint => _$this._getDefaultMint;
  set getDefaultMint(MintItem Function() getDefaultMint) =>
      _$this._getDefaultMint = getDefaultMint;

  InvestHomeVMBuilder();

  InvestHomeVMBuilder get _$this {
    if (_$v != null) {
      _hasWallet = _$v.hasWallet;
      _fiatCurrency = _$v.fiatCurrency;
      _activeMint = _$v.activeMint?.toBuilder();
      _mints = _$v.mints?.toBuilder();
      _mintInfo = _$v.mintInfo?.toBuilder();
      _chartList = _$v.chartList?.toBuilder();
      _profitInvitationList = _$v.profitInvitationList?.toBuilder();
      _getCoinInfo = _$v.getCoinInfo;
      _doSwitchMint = _$v.doSwitchMint;
      _refreshMintReward = _$v.refreshMintReward;
      _getProfitInvitationList = _$v.getProfitInvitationList;
      _getDefaultMint = _$v.getDefaultMint;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvestHomeVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvestHomeVM;
  }

  @override
  void update(void Function(InvestHomeVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvestHomeVM build() {
    _$InvestHomeVM _$result;
    try {
      _$result = _$v ??
          new _$InvestHomeVM._(
              hasWallet: hasWallet,
              fiatCurrency: fiatCurrency,
              activeMint: _activeMint?.build(),
              mints: mints.build(),
              mintInfo: _mintInfo?.build(),
              chartList: chartList.build(),
              profitInvitationList: profitInvitationList.build(),
              getCoinInfo: getCoinInfo,
              doSwitchMint: doSwitchMint,
              refreshMintReward: refreshMintReward,
              getProfitInvitationList: getProfitInvitationList,
              getDefaultMint: getDefaultMint);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'activeMint';
        _activeMint?.build();
        _$failedField = 'mints';
        mints.build();
        _$failedField = 'mintInfo';
        _mintInfo?.build();
        _$failedField = 'chartList';
        chartList.build();
        _$failedField = 'profitInvitationList';
        profitInvitationList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvestHomeVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvestProfitVM extends InvestProfitVM {
  @override
  final bool hasWallet;
  @override
  final MintItem activeMint;
  @override
  final BuiltList<ProfitRecordItem> profitRecordList;
  @override
  final AssetCoin Function({String chain, String symbol}) getCoinInfo;
  @override
  final Future<int> Function({bool isRefresh, int skip, int take})
      getProfitRecordList;

  factory _$InvestProfitVM([void Function(InvestProfitVMBuilder) updates]) =>
      (new InvestProfitVMBuilder()..update(updates)).build();

  _$InvestProfitVM._(
      {this.hasWallet,
      this.activeMint,
      this.profitRecordList,
      this.getCoinInfo,
      this.getProfitRecordList})
      : super._() {
    if (hasWallet == null) {
      throw new BuiltValueNullFieldError('InvestProfitVM', 'hasWallet');
    }
    if (profitRecordList == null) {
      throw new BuiltValueNullFieldError('InvestProfitVM', 'profitRecordList');
    }
    if (getCoinInfo == null) {
      throw new BuiltValueNullFieldError('InvestProfitVM', 'getCoinInfo');
    }
    if (getProfitRecordList == null) {
      throw new BuiltValueNullFieldError(
          'InvestProfitVM', 'getProfitRecordList');
    }
  }

  @override
  InvestProfitVM rebuild(void Function(InvestProfitVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestProfitVMBuilder toBuilder() =>
      new InvestProfitVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestProfitVM &&
        hasWallet == other.hasWallet &&
        activeMint == other.activeMint &&
        profitRecordList == other.profitRecordList;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, hasWallet.hashCode), activeMint.hashCode),
        profitRecordList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvestProfitVM')
          ..add('hasWallet', hasWallet)
          ..add('activeMint', activeMint)
          ..add('profitRecordList', profitRecordList)
          ..add('getCoinInfo', getCoinInfo)
          ..add('getProfitRecordList', getProfitRecordList))
        .toString();
  }
}

class InvestProfitVMBuilder
    implements Builder<InvestProfitVM, InvestProfitVMBuilder> {
  _$InvestProfitVM _$v;

  bool _hasWallet;
  bool get hasWallet => _$this._hasWallet;
  set hasWallet(bool hasWallet) => _$this._hasWallet = hasWallet;

  MintItemBuilder _activeMint;
  MintItemBuilder get activeMint =>
      _$this._activeMint ??= new MintItemBuilder();
  set activeMint(MintItemBuilder activeMint) => _$this._activeMint = activeMint;

  ListBuilder<ProfitRecordItem> _profitRecordList;
  ListBuilder<ProfitRecordItem> get profitRecordList =>
      _$this._profitRecordList ??= new ListBuilder<ProfitRecordItem>();
  set profitRecordList(ListBuilder<ProfitRecordItem> profitRecordList) =>
      _$this._profitRecordList = profitRecordList;

  AssetCoin Function({String chain, String symbol}) _getCoinInfo;
  AssetCoin Function({String chain, String symbol}) get getCoinInfo =>
      _$this._getCoinInfo;
  set getCoinInfo(
          AssetCoin Function({String chain, String symbol}) getCoinInfo) =>
      _$this._getCoinInfo = getCoinInfo;

  Future<int> Function({bool isRefresh, int skip, int take})
      _getProfitRecordList;
  Future<int> Function({bool isRefresh, int skip, int take})
      get getProfitRecordList => _$this._getProfitRecordList;
  set getProfitRecordList(
          Future<int> Function({bool isRefresh, int skip, int take})
              getProfitRecordList) =>
      _$this._getProfitRecordList = getProfitRecordList;

  InvestProfitVMBuilder();

  InvestProfitVMBuilder get _$this {
    if (_$v != null) {
      _hasWallet = _$v.hasWallet;
      _activeMint = _$v.activeMint?.toBuilder();
      _profitRecordList = _$v.profitRecordList?.toBuilder();
      _getCoinInfo = _$v.getCoinInfo;
      _getProfitRecordList = _$v.getProfitRecordList;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvestProfitVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvestProfitVM;
  }

  @override
  void update(void Function(InvestProfitVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvestProfitVM build() {
    _$InvestProfitVM _$result;
    try {
      _$result = _$v ??
          new _$InvestProfitVM._(
              hasWallet: hasWallet,
              activeMint: _activeMint?.build(),
              profitRecordList: profitRecordList.build(),
              getCoinInfo: getCoinInfo,
              getProfitRecordList: getProfitRecordList);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'activeMint';
        _activeMint?.build();
        _$failedField = 'profitRecordList';
        profitRecordList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvestProfitVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$InvestConfig extends InvestConfig {
  @override
  final BuiltList<MintItem> mints;
  @override
  final BuiltList<MintItem> airdrops;

  factory _$InvestConfig([void Function(InvestConfigBuilder) updates]) =>
      (new InvestConfigBuilder()..update(updates)).build();

  _$InvestConfig._({this.mints, this.airdrops}) : super._();

  @override
  InvestConfig rebuild(void Function(InvestConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestConfigBuilder toBuilder() => new InvestConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestConfig &&
        mints == other.mints &&
        airdrops == other.airdrops;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, mints.hashCode), airdrops.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvestConfig')
          ..add('mints', mints)
          ..add('airdrops', airdrops))
        .toString();
  }
}

class InvestConfigBuilder
    implements Builder<InvestConfig, InvestConfigBuilder> {
  _$InvestConfig _$v;

  ListBuilder<MintItem> _mints;
  ListBuilder<MintItem> get mints =>
      _$this._mints ??= new ListBuilder<MintItem>();
  set mints(ListBuilder<MintItem> mints) => _$this._mints = mints;

  ListBuilder<MintItem> _airdrops;
  ListBuilder<MintItem> get airdrops =>
      _$this._airdrops ??= new ListBuilder<MintItem>();
  set airdrops(ListBuilder<MintItem> airdrops) => _$this._airdrops = airdrops;

  InvestConfigBuilder();

  InvestConfigBuilder get _$this {
    if (_$v != null) {
      _mints = _$v.mints?.toBuilder();
      _airdrops = _$v.airdrops?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvestConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvestConfig;
  }

  @override
  void update(void Function(InvestConfigBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvestConfig build() {
    _$InvestConfig _$result;
    try {
      _$result = _$v ??
          new _$InvestConfig._(
              mints: _mints?.build(), airdrops: _airdrops?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'mints';
        _mints?.build();
        _$failedField = 'airdrops';
        _airdrops?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvestConfig', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$MintChart extends MintChart {
  @override
  final String balance;
  @override
  final String reward;
  @override
  final bool isBalance;

  factory _$MintChart([void Function(MintChartBuilder) updates]) =>
      (new MintChartBuilder()..update(updates)).build();

  _$MintChart._({this.balance, this.reward, this.isBalance}) : super._();

  @override
  MintChart rebuild(void Function(MintChartBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MintChartBuilder toBuilder() => new MintChartBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MintChart &&
        balance == other.balance &&
        reward == other.reward &&
        isBalance == other.isBalance;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, balance.hashCode), reward.hashCode), isBalance.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MintChart')
          ..add('balance', balance)
          ..add('reward', reward)
          ..add('isBalance', isBalance))
        .toString();
  }
}

class MintChartBuilder implements Builder<MintChart, MintChartBuilder> {
  _$MintChart _$v;

  String _balance;
  String get balance => _$this._balance;
  set balance(String balance) => _$this._balance = balance;

  String _reward;
  String get reward => _$this._reward;
  set reward(String reward) => _$this._reward = reward;

  bool _isBalance;
  bool get isBalance => _$this._isBalance;
  set isBalance(bool isBalance) => _$this._isBalance = isBalance;

  MintChartBuilder();

  MintChartBuilder get _$this {
    if (_$v != null) {
      _balance = _$v.balance;
      _reward = _$v.reward;
      _isBalance = _$v.isBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MintChart other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MintChart;
  }

  @override
  void update(void Function(MintChartBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MintChart build() {
    final _$result = _$v ??
        new _$MintChart._(
            balance: balance, reward: reward, isBalance: isBalance);
    replace(_$result);
    return _$result;
  }
}

class _$MintInfo extends MintInfo {
  @override
  final String promotionReward;
  @override
  final String stakeReward;
  @override
  final String thisStakeReward;
  @override
  final String thisBalance;
  @override
  final String minBalance;
  @override
  final String bestBalance;
  @override
  final String bestBalanceReward;
  @override
  final String minBalanceReward;

  factory _$MintInfo([void Function(MintInfoBuilder) updates]) =>
      (new MintInfoBuilder()..update(updates)).build();

  _$MintInfo._(
      {this.promotionReward,
      this.stakeReward,
      this.thisStakeReward,
      this.thisBalance,
      this.minBalance,
      this.bestBalance,
      this.bestBalanceReward,
      this.minBalanceReward})
      : super._() {
    if (minBalance == null) {
      throw new BuiltValueNullFieldError('MintInfo', 'minBalance');
    }
    if (bestBalance == null) {
      throw new BuiltValueNullFieldError('MintInfo', 'bestBalance');
    }
    if (bestBalanceReward == null) {
      throw new BuiltValueNullFieldError('MintInfo', 'bestBalanceReward');
    }
    if (minBalanceReward == null) {
      throw new BuiltValueNullFieldError('MintInfo', 'minBalanceReward');
    }
  }

  @override
  MintInfo rebuild(void Function(MintInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MintInfoBuilder toBuilder() => new MintInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MintInfo &&
        promotionReward == other.promotionReward &&
        stakeReward == other.stakeReward &&
        thisStakeReward == other.thisStakeReward &&
        thisBalance == other.thisBalance &&
        minBalance == other.minBalance &&
        bestBalance == other.bestBalance &&
        bestBalanceReward == other.bestBalanceReward &&
        minBalanceReward == other.minBalanceReward;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, promotionReward.hashCode),
                                stakeReward.hashCode),
                            thisStakeReward.hashCode),
                        thisBalance.hashCode),
                    minBalance.hashCode),
                bestBalance.hashCode),
            bestBalanceReward.hashCode),
        minBalanceReward.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MintInfo')
          ..add('promotionReward', promotionReward)
          ..add('stakeReward', stakeReward)
          ..add('thisStakeReward', thisStakeReward)
          ..add('thisBalance', thisBalance)
          ..add('minBalance', minBalance)
          ..add('bestBalance', bestBalance)
          ..add('bestBalanceReward', bestBalanceReward)
          ..add('minBalanceReward', minBalanceReward))
        .toString();
  }
}

class MintInfoBuilder implements Builder<MintInfo, MintInfoBuilder> {
  _$MintInfo _$v;

  String _promotionReward;
  String get promotionReward => _$this._promotionReward;
  set promotionReward(String promotionReward) =>
      _$this._promotionReward = promotionReward;

  String _stakeReward;
  String get stakeReward => _$this._stakeReward;
  set stakeReward(String stakeReward) => _$this._stakeReward = stakeReward;

  String _thisStakeReward;
  String get thisStakeReward => _$this._thisStakeReward;
  set thisStakeReward(String thisStakeReward) =>
      _$this._thisStakeReward = thisStakeReward;

  String _thisBalance;
  String get thisBalance => _$this._thisBalance;
  set thisBalance(String thisBalance) => _$this._thisBalance = thisBalance;

  String _minBalance;
  String get minBalance => _$this._minBalance;
  set minBalance(String minBalance) => _$this._minBalance = minBalance;

  String _bestBalance;
  String get bestBalance => _$this._bestBalance;
  set bestBalance(String bestBalance) => _$this._bestBalance = bestBalance;

  String _bestBalanceReward;
  String get bestBalanceReward => _$this._bestBalanceReward;
  set bestBalanceReward(String bestBalanceReward) =>
      _$this._bestBalanceReward = bestBalanceReward;

  String _minBalanceReward;
  String get minBalanceReward => _$this._minBalanceReward;
  set minBalanceReward(String minBalanceReward) =>
      _$this._minBalanceReward = minBalanceReward;

  MintInfoBuilder();

  MintInfoBuilder get _$this {
    if (_$v != null) {
      _promotionReward = _$v.promotionReward;
      _stakeReward = _$v.stakeReward;
      _thisStakeReward = _$v.thisStakeReward;
      _thisBalance = _$v.thisBalance;
      _minBalance = _$v.minBalance;
      _bestBalance = _$v.bestBalance;
      _bestBalanceReward = _$v.bestBalanceReward;
      _minBalanceReward = _$v.minBalanceReward;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MintInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MintInfo;
  }

  @override
  void update(void Function(MintInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MintInfo build() {
    final _$result = _$v ??
        new _$MintInfo._(
            promotionReward: promotionReward,
            stakeReward: stakeReward,
            thisStakeReward: thisStakeReward,
            thisBalance: thisBalance,
            minBalance: minBalance,
            bestBalance: bestBalance,
            bestBalanceReward: bestBalanceReward,
            minBalanceReward: minBalanceReward);
    replace(_$result);
    return _$result;
  }
}

class _$MintItem extends MintItem {
  @override
  final int id;
  @override
  final String forkId;
  @override
  final BuiltMap<String, String> name;
  @override
  final String symbol;
  @override
  final String chain;
  @override
  final int mintEnable;
  @override
  final double minBalance;

  factory _$MintItem([void Function(MintItemBuilder) updates]) =>
      (new MintItemBuilder()..update(updates)).build();

  _$MintItem._(
      {this.id,
      this.forkId,
      this.name,
      this.symbol,
      this.chain,
      this.mintEnable,
      this.minBalance})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('MintItem', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('MintItem', 'name');
    }
    if (symbol == null) {
      throw new BuiltValueNullFieldError('MintItem', 'symbol');
    }
    if (chain == null) {
      throw new BuiltValueNullFieldError('MintItem', 'chain');
    }
  }

  @override
  MintItem rebuild(void Function(MintItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MintItemBuilder toBuilder() => new MintItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MintItem &&
        id == other.id &&
        forkId == other.forkId &&
        name == other.name &&
        symbol == other.symbol &&
        chain == other.chain &&
        mintEnable == other.mintEnable &&
        minBalance == other.minBalance;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), forkId.hashCode),
                        name.hashCode),
                    symbol.hashCode),
                chain.hashCode),
            mintEnable.hashCode),
        minBalance.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MintItem')
          ..add('id', id)
          ..add('forkId', forkId)
          ..add('name', name)
          ..add('symbol', symbol)
          ..add('chain', chain)
          ..add('mintEnable', mintEnable)
          ..add('minBalance', minBalance))
        .toString();
  }
}

class MintItemBuilder implements Builder<MintItem, MintItemBuilder> {
  _$MintItem _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _forkId;
  String get forkId => _$this._forkId;
  set forkId(String forkId) => _$this._forkId = forkId;

  MapBuilder<String, String> _name;
  MapBuilder<String, String> get name =>
      _$this._name ??= new MapBuilder<String, String>();
  set name(MapBuilder<String, String> name) => _$this._name = name;

  String _symbol;
  String get symbol => _$this._symbol;
  set symbol(String symbol) => _$this._symbol = symbol;

  String _chain;
  String get chain => _$this._chain;
  set chain(String chain) => _$this._chain = chain;

  int _mintEnable;
  int get mintEnable => _$this._mintEnable;
  set mintEnable(int mintEnable) => _$this._mintEnable = mintEnable;

  double _minBalance;
  double get minBalance => _$this._minBalance;
  set minBalance(double minBalance) => _$this._minBalance = minBalance;

  MintItemBuilder();

  MintItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _forkId = _$v.forkId;
      _name = _$v.name?.toBuilder();
      _symbol = _$v.symbol;
      _chain = _$v.chain;
      _mintEnable = _$v.mintEnable;
      _minBalance = _$v.minBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MintItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MintItem;
  }

  @override
  void update(void Function(MintItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MintItem build() {
    _$MintItem _$result;
    try {
      _$result = _$v ??
          new _$MintItem._(
              id: id,
              forkId: forkId,
              name: name.build(),
              symbol: symbol,
              chain: chain,
              mintEnable: mintEnable,
              minBalance: minBalance);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'name';
        name.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MintItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ProfitInvitationItem extends ProfitInvitationItem {
  @override
  final String address;
  @override
  final String amount;
  @override
  final String height;
  @override
  final String time;

  factory _$ProfitInvitationItem(
          [void Function(ProfitInvitationItemBuilder) updates]) =>
      (new ProfitInvitationItemBuilder()..update(updates)).build();

  _$ProfitInvitationItem._({this.address, this.amount, this.height, this.time})
      : super._() {
    if (address == null) {
      throw new BuiltValueNullFieldError('ProfitInvitationItem', 'address');
    }
    if (amount == null) {
      throw new BuiltValueNullFieldError('ProfitInvitationItem', 'amount');
    }
  }

  @override
  ProfitInvitationItem rebuild(
          void Function(ProfitInvitationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfitInvitationItemBuilder toBuilder() =>
      new ProfitInvitationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfitInvitationItem &&
        address == other.address &&
        amount == other.amount &&
        height == other.height &&
        time == other.time;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, address.hashCode), amount.hashCode), height.hashCode),
        time.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProfitInvitationItem')
          ..add('address', address)
          ..add('amount', amount)
          ..add('height', height)
          ..add('time', time))
        .toString();
  }
}

class ProfitInvitationItemBuilder
    implements Builder<ProfitInvitationItem, ProfitInvitationItemBuilder> {
  _$ProfitInvitationItem _$v;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _amount;
  String get amount => _$this._amount;
  set amount(String amount) => _$this._amount = amount;

  String _height;
  String get height => _$this._height;
  set height(String height) => _$this._height = height;

  String _time;
  String get time => _$this._time;
  set time(String time) => _$this._time = time;

  ProfitInvitationItemBuilder();

  ProfitInvitationItemBuilder get _$this {
    if (_$v != null) {
      _address = _$v.address;
      _amount = _$v.amount;
      _height = _$v.height;
      _time = _$v.time;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfitInvitationItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProfitInvitationItem;
  }

  @override
  void update(void Function(ProfitInvitationItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProfitInvitationItem build() {
    final _$result = _$v ??
        new _$ProfitInvitationItem._(
            address: address, amount: amount, height: height, time: time);
    replace(_$result);
    return _$result;
  }
}

class _$ProfitRecordItem extends ProfitRecordItem {
  @override
  final int height;
  @override
  final String balance;
  @override
  final String stakeReward;
  @override
  final String promotionReward;

  factory _$ProfitRecordItem(
          [void Function(ProfitRecordItemBuilder) updates]) =>
      (new ProfitRecordItemBuilder()..update(updates)).build();

  _$ProfitRecordItem._(
      {this.height, this.balance, this.stakeReward, this.promotionReward})
      : super._() {
    if (height == null) {
      throw new BuiltValueNullFieldError('ProfitRecordItem', 'height');
    }
    if (balance == null) {
      throw new BuiltValueNullFieldError('ProfitRecordItem', 'balance');
    }
    if (stakeReward == null) {
      throw new BuiltValueNullFieldError('ProfitRecordItem', 'stakeReward');
    }
    if (promotionReward == null) {
      throw new BuiltValueNullFieldError('ProfitRecordItem', 'promotionReward');
    }
  }

  @override
  ProfitRecordItem rebuild(void Function(ProfitRecordItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfitRecordItemBuilder toBuilder() =>
      new ProfitRecordItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfitRecordItem &&
        height == other.height &&
        balance == other.balance &&
        stakeReward == other.stakeReward &&
        promotionReward == other.promotionReward;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, height.hashCode), balance.hashCode),
            stakeReward.hashCode),
        promotionReward.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProfitRecordItem')
          ..add('height', height)
          ..add('balance', balance)
          ..add('stakeReward', stakeReward)
          ..add('promotionReward', promotionReward))
        .toString();
  }
}

class ProfitRecordItemBuilder
    implements Builder<ProfitRecordItem, ProfitRecordItemBuilder> {
  _$ProfitRecordItem _$v;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  String _balance;
  String get balance => _$this._balance;
  set balance(String balance) => _$this._balance = balance;

  String _stakeReward;
  String get stakeReward => _$this._stakeReward;
  set stakeReward(String stakeReward) => _$this._stakeReward = stakeReward;

  String _promotionReward;
  String get promotionReward => _$this._promotionReward;
  set promotionReward(String promotionReward) =>
      _$this._promotionReward = promotionReward;

  ProfitRecordItemBuilder();

  ProfitRecordItemBuilder get _$this {
    if (_$v != null) {
      _height = _$v.height;
      _balance = _$v.balance;
      _stakeReward = _$v.stakeReward;
      _promotionReward = _$v.promotionReward;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfitRecordItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProfitRecordItem;
  }

  @override
  void update(void Function(ProfitRecordItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProfitRecordItem build() {
    final _$result = _$v ??
        new _$ProfitRecordItem._(
            height: height,
            balance: balance,
            stakeReward: stakeReward,
            promotionReward: promotionReward);
    replace(_$result);
    return _$result;
  }
}

class _$InvestState extends InvestState {
  @override
  final InvestConfig config;
  @override
  final int configState;
  @override
  final MintItem activeMint;
  @override
  final MintInfo mintInfo;
  @override
  final BuiltList<MintChart> chartList;
  @override
  final BuiltList<ProfitRecordItem> profitRecordList;
  @override
  final BuiltList<ProfitInvitationItem> profitInvitationList;

  factory _$InvestState([void Function(InvestStateBuilder) updates]) =>
      (new InvestStateBuilder()..update(updates)).build();

  _$InvestState._(
      {this.config,
      this.configState,
      this.activeMint,
      this.mintInfo,
      this.chartList,
      this.profitRecordList,
      this.profitInvitationList})
      : super._() {
    if (chartList == null) {
      throw new BuiltValueNullFieldError('InvestState', 'chartList');
    }
    if (profitRecordList == null) {
      throw new BuiltValueNullFieldError('InvestState', 'profitRecordList');
    }
    if (profitInvitationList == null) {
      throw new BuiltValueNullFieldError('InvestState', 'profitInvitationList');
    }
  }

  @override
  InvestState rebuild(void Function(InvestStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestStateBuilder toBuilder() => new InvestStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestState &&
        config == other.config &&
        configState == other.configState &&
        activeMint == other.activeMint &&
        mintInfo == other.mintInfo &&
        chartList == other.chartList &&
        profitRecordList == other.profitRecordList &&
        profitInvitationList == other.profitInvitationList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, config.hashCode), configState.hashCode),
                        activeMint.hashCode),
                    mintInfo.hashCode),
                chartList.hashCode),
            profitRecordList.hashCode),
        profitInvitationList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InvestState')
          ..add('config', config)
          ..add('configState', configState)
          ..add('activeMint', activeMint)
          ..add('mintInfo', mintInfo)
          ..add('chartList', chartList)
          ..add('profitRecordList', profitRecordList)
          ..add('profitInvitationList', profitInvitationList))
        .toString();
  }
}

class InvestStateBuilder implements Builder<InvestState, InvestStateBuilder> {
  _$InvestState _$v;

  InvestConfigBuilder _config;
  InvestConfigBuilder get config =>
      _$this._config ??= new InvestConfigBuilder();
  set config(InvestConfigBuilder config) => _$this._config = config;

  int _configState;
  int get configState => _$this._configState;
  set configState(int configState) => _$this._configState = configState;

  MintItemBuilder _activeMint;
  MintItemBuilder get activeMint =>
      _$this._activeMint ??= new MintItemBuilder();
  set activeMint(MintItemBuilder activeMint) => _$this._activeMint = activeMint;

  MintInfoBuilder _mintInfo;
  MintInfoBuilder get mintInfo => _$this._mintInfo ??= new MintInfoBuilder();
  set mintInfo(MintInfoBuilder mintInfo) => _$this._mintInfo = mintInfo;

  ListBuilder<MintChart> _chartList;
  ListBuilder<MintChart> get chartList =>
      _$this._chartList ??= new ListBuilder<MintChart>();
  set chartList(ListBuilder<MintChart> chartList) =>
      _$this._chartList = chartList;

  ListBuilder<ProfitRecordItem> _profitRecordList;
  ListBuilder<ProfitRecordItem> get profitRecordList =>
      _$this._profitRecordList ??= new ListBuilder<ProfitRecordItem>();
  set profitRecordList(ListBuilder<ProfitRecordItem> profitRecordList) =>
      _$this._profitRecordList = profitRecordList;

  ListBuilder<ProfitInvitationItem> _profitInvitationList;
  ListBuilder<ProfitInvitationItem> get profitInvitationList =>
      _$this._profitInvitationList ??= new ListBuilder<ProfitInvitationItem>();
  set profitInvitationList(
          ListBuilder<ProfitInvitationItem> profitInvitationList) =>
      _$this._profitInvitationList = profitInvitationList;

  InvestStateBuilder();

  InvestStateBuilder get _$this {
    if (_$v != null) {
      _config = _$v.config?.toBuilder();
      _configState = _$v.configState;
      _activeMint = _$v.activeMint?.toBuilder();
      _mintInfo = _$v.mintInfo?.toBuilder();
      _chartList = _$v.chartList?.toBuilder();
      _profitRecordList = _$v.profitRecordList?.toBuilder();
      _profitInvitationList = _$v.profitInvitationList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvestState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InvestState;
  }

  @override
  void update(void Function(InvestStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InvestState build() {
    _$InvestState _$result;
    try {
      _$result = _$v ??
          new _$InvestState._(
              config: _config?.build(),
              configState: configState,
              activeMint: _activeMint?.build(),
              mintInfo: _mintInfo?.build(),
              chartList: chartList.build(),
              profitRecordList: profitRecordList.build(),
              profitInvitationList: profitInvitationList.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'config';
        _config?.build();

        _$failedField = 'activeMint';
        _activeMint?.build();
        _$failedField = 'mintInfo';
        _mintInfo?.build();
        _$failedField = 'chartList';
        chartList.build();
        _$failedField = 'profitRecordList';
        profitRecordList.build();
        _$failedField = 'profitInvitationList';
        profitInvitationList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InvestState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
