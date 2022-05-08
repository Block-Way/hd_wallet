// GENERATED CODE - DO NOT MODIFY BY HAND

part of home_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HomeBanner> _$homeBannerSerializer = new _$HomeBannerSerializer();
Serializer<HomeState> _$homeStateSerializer = new _$HomeStateSerializer();

class _$HomeBannerSerializer implements StructuredSerializer<HomeBanner> {
  @override
  final Iterable<Type> types = const [HomeBanner, _$HomeBanner];
  @override
  final String wireName = 'HomeBanner';

  @override
  Iterable<Object> serialize(Serializers serializers, HomeBanner object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(String)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.content != null) {
      result
        ..add('content')
        ..add(serializers.serialize(object.content,
            specifiedType: const FullType(String)));
    }
    if (object.img != null) {
      result
        ..add('img')
        ..add(serializers.serialize(object.img,
            specifiedType: const FullType(String)));
    }
    if (object.bgImg != null) {
      result
        ..add('bg_img')
        ..add(serializers.serialize(object.bgImg,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  HomeBanner deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HomeBannerBuilder();

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
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'img':
          result.img = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bg_img':
          result.bgImg = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$HomeStateSerializer implements StructuredSerializer<HomeState> {
  @override
  final Iterable<Type> types = const [HomeState, _$HomeState];
  @override
  final String wireName = 'HomeState';

  @override
  Iterable<Object> serialize(Serializers serializers, HomeState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'isInitialized',
      serializers.serialize(object.isInitialized,
          specifiedType: const FullType(bool)),
    ];
    if (object.homeBanners != null) {
      result
        ..add('homeBanners')
        ..add(serializers.serialize(object.homeBanners,
            specifiedType:
                const FullType(BuiltList, const [const FullType(HomeBanner)])));
    }
    if (object.homePrices != null) {
      result
        ..add('homePrices')
        ..add(serializers.serialize(object.homePrices,
            specifiedType:
                const FullType(BuiltList, const [const FullType(AssetPrice)])));
    }
    return result;
  }

  @override
  HomeState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HomeStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'homeBanners':
          result.homeBanners.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(HomeBanner)]))
              as BuiltList<Object>);
          break;
        case 'homePrices':
          result.homePrices.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AssetPrice)]))
              as BuiltList<Object>);
          break;
        case 'isInitialized':
          result.isInitialized = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$HomePageVM extends HomePageVM {
  @override
  final BuiltList<AssetPrice> homePrices;
  @override
  final BuiltList<HomeBanner> homeBanners;
  @override
  final BuiltList<NoticeInfo> homeNotices;
  @override
  final BuiltList<AdmissionInfo> admissionList;
  @override
  final bool hasNewVersion;
  @override
  final ConfigUpdateData newVersionData;
  @override
  final BuiltList<TradePair> allTradePairs;
  @override
  final BuiltList<TradeMarket> allTradeMarkets;
  @override
  final bool hasWallet;
  @override
  final CommunityConfig communityConfig;
  @override
  final int communityConfigState;
  @override
  final void Function() doLoadHomeData;
  @override
  final Future<ConfigUpdateData> Function() doCheckForBetaUpdates;
  @override
  final Future<AppLanguage> Function() doCheckLanguage;
  @override
  final Future<void> Function(String language) doChangeLanguage;
  @override
  final Future<void> Function(TradePair tradePair) doChangeTradePair;
  @override
  final Future<void> Function() doRefreshHomeData;
  @override
  final Future<void> Function() doRefreshCommunity;

  factory _$HomePageVM([void Function(HomePageVMBuilder) updates]) =>
      (new HomePageVMBuilder()..update(updates)).build();

  _$HomePageVM._(
      {this.homePrices,
      this.homeBanners,
      this.homeNotices,
      this.admissionList,
      this.hasNewVersion,
      this.newVersionData,
      this.allTradePairs,
      this.allTradeMarkets,
      this.hasWallet,
      this.communityConfig,
      this.communityConfigState,
      this.doLoadHomeData,
      this.doCheckForBetaUpdates,
      this.doCheckLanguage,
      this.doChangeLanguage,
      this.doChangeTradePair,
      this.doRefreshHomeData,
      this.doRefreshCommunity})
      : super._() {
    if (allTradePairs == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'allTradePairs');
    }
    if (allTradeMarkets == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'allTradeMarkets');
    }
    if (hasWallet == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'hasWallet');
    }
    if (doLoadHomeData == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'doLoadHomeData');
    }
    if (doCheckForBetaUpdates == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'doCheckForBetaUpdates');
    }
    if (doCheckLanguage == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'doCheckLanguage');
    }
    if (doChangeLanguage == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'doChangeLanguage');
    }
    if (doChangeTradePair == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'doChangeTradePair');
    }
    if (doRefreshHomeData == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'doRefreshHomeData');
    }
    if (doRefreshCommunity == null) {
      throw new BuiltValueNullFieldError('HomePageVM', 'doRefreshCommunity');
    }
  }

  @override
  HomePageVM rebuild(void Function(HomePageVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomePageVMBuilder toBuilder() => new HomePageVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomePageVM &&
        homePrices == other.homePrices &&
        homeBanners == other.homeBanners &&
        homeNotices == other.homeNotices &&
        admissionList == other.admissionList &&
        hasNewVersion == other.hasNewVersion &&
        newVersionData == other.newVersionData &&
        allTradePairs == other.allTradePairs &&
        allTradeMarkets == other.allTradeMarkets &&
        hasWallet == other.hasWallet &&
        communityConfig == other.communityConfig &&
        communityConfigState == other.communityConfigState;
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
                                        $jc($jc(0, homePrices.hashCode),
                                            homeBanners.hashCode),
                                        homeNotices.hashCode),
                                    admissionList.hashCode),
                                hasNewVersion.hashCode),
                            newVersionData.hashCode),
                        allTradePairs.hashCode),
                    allTradeMarkets.hashCode),
                hasWallet.hashCode),
            communityConfig.hashCode),
        communityConfigState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomePageVM')
          ..add('homePrices', homePrices)
          ..add('homeBanners', homeBanners)
          ..add('homeNotices', homeNotices)
          ..add('admissionList', admissionList)
          ..add('hasNewVersion', hasNewVersion)
          ..add('newVersionData', newVersionData)
          ..add('allTradePairs', allTradePairs)
          ..add('allTradeMarkets', allTradeMarkets)
          ..add('hasWallet', hasWallet)
          ..add('communityConfig', communityConfig)
          ..add('communityConfigState', communityConfigState)
          ..add('doLoadHomeData', doLoadHomeData)
          ..add('doCheckForBetaUpdates', doCheckForBetaUpdates)
          ..add('doCheckLanguage', doCheckLanguage)
          ..add('doChangeLanguage', doChangeLanguage)
          ..add('doChangeTradePair', doChangeTradePair)
          ..add('doRefreshHomeData', doRefreshHomeData)
          ..add('doRefreshCommunity', doRefreshCommunity))
        .toString();
  }
}

class HomePageVMBuilder implements Builder<HomePageVM, HomePageVMBuilder> {
  _$HomePageVM _$v;

  ListBuilder<AssetPrice> _homePrices;
  ListBuilder<AssetPrice> get homePrices =>
      _$this._homePrices ??= new ListBuilder<AssetPrice>();
  set homePrices(ListBuilder<AssetPrice> homePrices) =>
      _$this._homePrices = homePrices;

  ListBuilder<HomeBanner> _homeBanners;
  ListBuilder<HomeBanner> get homeBanners =>
      _$this._homeBanners ??= new ListBuilder<HomeBanner>();
  set homeBanners(ListBuilder<HomeBanner> homeBanners) =>
      _$this._homeBanners = homeBanners;

  ListBuilder<NoticeInfo> _homeNotices;
  ListBuilder<NoticeInfo> get homeNotices =>
      _$this._homeNotices ??= new ListBuilder<NoticeInfo>();
  set homeNotices(ListBuilder<NoticeInfo> homeNotices) =>
      _$this._homeNotices = homeNotices;

  ListBuilder<AdmissionInfo> _admissionList;
  ListBuilder<AdmissionInfo> get admissionList =>
      _$this._admissionList ??= new ListBuilder<AdmissionInfo>();
  set admissionList(ListBuilder<AdmissionInfo> admissionList) =>
      _$this._admissionList = admissionList;

  bool _hasNewVersion;
  bool get hasNewVersion => _$this._hasNewVersion;
  set hasNewVersion(bool hasNewVersion) =>
      _$this._hasNewVersion = hasNewVersion;

  ConfigUpdateDataBuilder _newVersionData;
  ConfigUpdateDataBuilder get newVersionData =>
      _$this._newVersionData ??= new ConfigUpdateDataBuilder();
  set newVersionData(ConfigUpdateDataBuilder newVersionData) =>
      _$this._newVersionData = newVersionData;

  ListBuilder<TradePair> _allTradePairs;
  ListBuilder<TradePair> get allTradePairs =>
      _$this._allTradePairs ??= new ListBuilder<TradePair>();
  set allTradePairs(ListBuilder<TradePair> allTradePairs) =>
      _$this._allTradePairs = allTradePairs;

  ListBuilder<TradeMarket> _allTradeMarkets;
  ListBuilder<TradeMarket> get allTradeMarkets =>
      _$this._allTradeMarkets ??= new ListBuilder<TradeMarket>();
  set allTradeMarkets(ListBuilder<TradeMarket> allTradeMarkets) =>
      _$this._allTradeMarkets = allTradeMarkets;

  bool _hasWallet;
  bool get hasWallet => _$this._hasWallet;
  set hasWallet(bool hasWallet) => _$this._hasWallet = hasWallet;

  CommunityConfigBuilder _communityConfig;
  CommunityConfigBuilder get communityConfig =>
      _$this._communityConfig ??= new CommunityConfigBuilder();
  set communityConfig(CommunityConfigBuilder communityConfig) =>
      _$this._communityConfig = communityConfig;

  int _communityConfigState;
  int get communityConfigState => _$this._communityConfigState;
  set communityConfigState(int communityConfigState) =>
      _$this._communityConfigState = communityConfigState;

  void Function() _doLoadHomeData;
  void Function() get doLoadHomeData => _$this._doLoadHomeData;
  set doLoadHomeData(void Function() doLoadHomeData) =>
      _$this._doLoadHomeData = doLoadHomeData;

  Future<ConfigUpdateData> Function() _doCheckForBetaUpdates;
  Future<ConfigUpdateData> Function() get doCheckForBetaUpdates =>
      _$this._doCheckForBetaUpdates;
  set doCheckForBetaUpdates(
          Future<ConfigUpdateData> Function() doCheckForBetaUpdates) =>
      _$this._doCheckForBetaUpdates = doCheckForBetaUpdates;

  Future<AppLanguage> Function() _doCheckLanguage;
  Future<AppLanguage> Function() get doCheckLanguage => _$this._doCheckLanguage;
  set doCheckLanguage(Future<AppLanguage> Function() doCheckLanguage) =>
      _$this._doCheckLanguage = doCheckLanguage;

  Future<void> Function(String language) _doChangeLanguage;
  Future<void> Function(String language) get doChangeLanguage =>
      _$this._doChangeLanguage;
  set doChangeLanguage(
          Future<void> Function(String language) doChangeLanguage) =>
      _$this._doChangeLanguage = doChangeLanguage;

  Future<void> Function(TradePair tradePair) _doChangeTradePair;
  Future<void> Function(TradePair tradePair) get doChangeTradePair =>
      _$this._doChangeTradePair;
  set doChangeTradePair(
          Future<void> Function(TradePair tradePair) doChangeTradePair) =>
      _$this._doChangeTradePair = doChangeTradePair;

  Future<void> Function() _doRefreshHomeData;
  Future<void> Function() get doRefreshHomeData => _$this._doRefreshHomeData;
  set doRefreshHomeData(Future<void> Function() doRefreshHomeData) =>
      _$this._doRefreshHomeData = doRefreshHomeData;

  Future<void> Function() _doRefreshCommunity;
  Future<void> Function() get doRefreshCommunity => _$this._doRefreshCommunity;
  set doRefreshCommunity(Future<void> Function() doRefreshCommunity) =>
      _$this._doRefreshCommunity = doRefreshCommunity;

  HomePageVMBuilder();

  HomePageVMBuilder get _$this {
    if (_$v != null) {
      _homePrices = _$v.homePrices?.toBuilder();
      _homeBanners = _$v.homeBanners?.toBuilder();
      _homeNotices = _$v.homeNotices?.toBuilder();
      _admissionList = _$v.admissionList?.toBuilder();
      _hasNewVersion = _$v.hasNewVersion;
      _newVersionData = _$v.newVersionData?.toBuilder();
      _allTradePairs = _$v.allTradePairs?.toBuilder();
      _allTradeMarkets = _$v.allTradeMarkets?.toBuilder();
      _hasWallet = _$v.hasWallet;
      _communityConfig = _$v.communityConfig?.toBuilder();
      _communityConfigState = _$v.communityConfigState;
      _doLoadHomeData = _$v.doLoadHomeData;
      _doCheckForBetaUpdates = _$v.doCheckForBetaUpdates;
      _doCheckLanguage = _$v.doCheckLanguage;
      _doChangeLanguage = _$v.doChangeLanguage;
      _doChangeTradePair = _$v.doChangeTradePair;
      _doRefreshHomeData = _$v.doRefreshHomeData;
      _doRefreshCommunity = _$v.doRefreshCommunity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomePageVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HomePageVM;
  }

  @override
  void update(void Function(HomePageVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomePageVM build() {
    _$HomePageVM _$result;
    try {
      _$result = _$v ??
          new _$HomePageVM._(
              homePrices: _homePrices?.build(),
              homeBanners: _homeBanners?.build(),
              homeNotices: _homeNotices?.build(),
              admissionList: _admissionList?.build(),
              hasNewVersion: hasNewVersion,
              newVersionData: _newVersionData?.build(),
              allTradePairs: allTradePairs.build(),
              allTradeMarkets: allTradeMarkets.build(),
              hasWallet: hasWallet,
              communityConfig: _communityConfig?.build(),
              communityConfigState: communityConfigState,
              doLoadHomeData: doLoadHomeData,
              doCheckForBetaUpdates: doCheckForBetaUpdates,
              doCheckLanguage: doCheckLanguage,
              doChangeLanguage: doChangeLanguage,
              doChangeTradePair: doChangeTradePair,
              doRefreshHomeData: doRefreshHomeData,
              doRefreshCommunity: doRefreshCommunity);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'homePrices';
        _homePrices?.build();
        _$failedField = 'homeBanners';
        _homeBanners?.build();
        _$failedField = 'homeNotices';
        _homeNotices?.build();
        _$failedField = 'admissionList';
        _admissionList?.build();

        _$failedField = 'newVersionData';
        _newVersionData?.build();
        _$failedField = 'allTradePairs';
        allTradePairs.build();
        _$failedField = 'allTradeMarkets';
        allTradeMarkets.build();

        _$failedField = 'communityConfig';
        _communityConfig?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HomePageVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$HomeBanner extends HomeBanner {
  @override
  final int id;
  @override
  final String type;
  @override
  final String title;
  @override
  final String content;
  @override
  final String img;
  @override
  final String bgImg;
  String __imageUrl;

  factory _$HomeBanner([void Function(HomeBannerBuilder) updates]) =>
      (new HomeBannerBuilder()..update(updates)).build();

  _$HomeBanner._(
      {this.id, this.type, this.title, this.content, this.img, this.bgImg})
      : super._();

  @override
  String get imageUrl => __imageUrl ??= super.imageUrl;

  @override
  HomeBanner rebuild(void Function(HomeBannerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeBannerBuilder toBuilder() => new HomeBannerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeBanner &&
        id == other.id &&
        type == other.type &&
        title == other.title &&
        content == other.content &&
        img == other.img &&
        bgImg == other.bgImg;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), type.hashCode), title.hashCode),
                content.hashCode),
            img.hashCode),
        bgImg.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeBanner')
          ..add('id', id)
          ..add('type', type)
          ..add('title', title)
          ..add('content', content)
          ..add('img', img)
          ..add('bgImg', bgImg))
        .toString();
  }
}

class HomeBannerBuilder implements Builder<HomeBanner, HomeBannerBuilder> {
  _$HomeBanner _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  String _img;
  String get img => _$this._img;
  set img(String img) => _$this._img = img;

  String _bgImg;
  String get bgImg => _$this._bgImg;
  set bgImg(String bgImg) => _$this._bgImg = bgImg;

  HomeBannerBuilder();

  HomeBannerBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _type = _$v.type;
      _title = _$v.title;
      _content = _$v.content;
      _img = _$v.img;
      _bgImg = _$v.bgImg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeBanner other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HomeBanner;
  }

  @override
  void update(void Function(HomeBannerBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeBanner build() {
    final _$result = _$v ??
        new _$HomeBanner._(
            id: id,
            type: type,
            title: title,
            content: content,
            img: img,
            bgImg: bgImg);
    replace(_$result);
    return _$result;
  }
}

class _$HomeState extends HomeState {
  @override
  final BuiltList<HomeBanner> homeBanners;
  @override
  final BuiltList<AssetPrice> homePrices;
  @override
  final bool isInitialized;

  factory _$HomeState([void Function(HomeStateBuilder) updates]) =>
      (new HomeStateBuilder()..update(updates)).build();

  _$HomeState._({this.homeBanners, this.homePrices, this.isInitialized})
      : super._() {
    if (isInitialized == null) {
      throw new BuiltValueNullFieldError('HomeState', 'isInitialized');
    }
  }

  @override
  HomeState rebuild(void Function(HomeStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeStateBuilder toBuilder() => new HomeStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeState &&
        homeBanners == other.homeBanners &&
        homePrices == other.homePrices &&
        isInitialized == other.isInitialized;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, homeBanners.hashCode), homePrices.hashCode),
        isInitialized.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeState')
          ..add('homeBanners', homeBanners)
          ..add('homePrices', homePrices)
          ..add('isInitialized', isInitialized))
        .toString();
  }
}

class HomeStateBuilder implements Builder<HomeState, HomeStateBuilder> {
  _$HomeState _$v;

  ListBuilder<HomeBanner> _homeBanners;
  ListBuilder<HomeBanner> get homeBanners =>
      _$this._homeBanners ??= new ListBuilder<HomeBanner>();
  set homeBanners(ListBuilder<HomeBanner> homeBanners) =>
      _$this._homeBanners = homeBanners;

  ListBuilder<AssetPrice> _homePrices;
  ListBuilder<AssetPrice> get homePrices =>
      _$this._homePrices ??= new ListBuilder<AssetPrice>();
  set homePrices(ListBuilder<AssetPrice> homePrices) =>
      _$this._homePrices = homePrices;

  bool _isInitialized;
  bool get isInitialized => _$this._isInitialized;
  set isInitialized(bool isInitialized) =>
      _$this._isInitialized = isInitialized;

  HomeStateBuilder();

  HomeStateBuilder get _$this {
    if (_$v != null) {
      _homeBanners = _$v.homeBanners?.toBuilder();
      _homePrices = _$v.homePrices?.toBuilder();
      _isInitialized = _$v.isInitialized;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HomeState;
  }

  @override
  void update(void Function(HomeStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeState build() {
    _$HomeState _$result;
    try {
      _$result = _$v ??
          new _$HomeState._(
              homeBanners: _homeBanners?.build(),
              homePrices: _homePrices?.build(),
              isInitialized: isInitialized);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'homeBanners';
        _homeBanners?.build();
        _$failedField = 'homePrices';
        _homePrices?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HomeState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
