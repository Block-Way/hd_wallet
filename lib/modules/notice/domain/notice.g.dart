// GENERATED CODE - DO NOT MODIFY BY HAND

part of notice_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NoticeInfo> _$noticeInfoSerializer = new _$NoticeInfoSerializer();

class _$NoticeInfoSerializer implements StructuredSerializer<NoticeInfo> {
  @override
  final Iterable<Type> types = const [NoticeInfo, _$NoticeInfo];
  @override
  final String wireName = 'NoticeInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, NoticeInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.coverImg;
    if (value != null) {
      result
        ..add('cover_img')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.shareImg;
    if (value != null) {
      result
        ..add('share_img')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  NoticeInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NoticeInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'cover_img':
          result.coverImg = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'share_img':
          result.shareImg.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$NoticeDetailVM extends NoticeDetailVM {
  @override
  final NoticeInfo? noticeDetail;

  factory _$NoticeDetailVM([void Function(NoticeDetailVMBuilder)? updates]) =>
      (new NoticeDetailVMBuilder()..update(updates))._build();

  _$NoticeDetailVM._({this.noticeDetail}) : super._();

  @override
  NoticeDetailVM rebuild(void Function(NoticeDetailVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoticeDetailVMBuilder toBuilder() =>
      new NoticeDetailVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoticeDetailVM && noticeDetail == other.noticeDetail;
  }

  @override
  int get hashCode {
    return $jf($jc(0, noticeDetail.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoticeDetailVM')
          ..add('noticeDetail', noticeDetail))
        .toString();
  }
}

class NoticeDetailVMBuilder
    implements Builder<NoticeDetailVM, NoticeDetailVMBuilder> {
  _$NoticeDetailVM? _$v;

  NoticeInfoBuilder? _noticeDetail;
  NoticeInfoBuilder get noticeDetail =>
      _$this._noticeDetail ??= new NoticeInfoBuilder();
  set noticeDetail(NoticeInfoBuilder? noticeDetail) =>
      _$this._noticeDetail = noticeDetail;

  NoticeDetailVMBuilder();

  NoticeDetailVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _noticeDetail = $v.noticeDetail?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeDetailVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NoticeDetailVM;
  }

  @override
  void update(void Function(NoticeDetailVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoticeDetailVM build() => _build();

  _$NoticeDetailVM _build() {
    _$NoticeDetailVM _$result;
    try {
      _$result =
          _$v ?? new _$NoticeDetailVM._(noticeDetail: _noticeDetail?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'noticeDetail';
        _noticeDetail?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NoticeDetailVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NoticeListVM extends NoticeListVM {
  @override
  final BuiltList<NoticeInfo>? noticeList;
  @override
  final BuiltList<NoticeInfo>? noticeLatest;
  @override
  final Future<int> Function(bool isRefresh, int skip) loadData;

  factory _$NoticeListVM([void Function(NoticeListVMBuilder)? updates]) =>
      (new NoticeListVMBuilder()..update(updates))._build();

  _$NoticeListVM._({this.noticeList, this.noticeLatest, required this.loadData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        loadData, r'NoticeListVM', 'loadData');
  }

  @override
  NoticeListVM rebuild(void Function(NoticeListVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoticeListVMBuilder toBuilder() => new NoticeListVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoticeListVM &&
        noticeList == other.noticeList &&
        noticeLatest == other.noticeLatest;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, noticeList.hashCode), noticeLatest.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoticeListVM')
          ..add('noticeList', noticeList)
          ..add('noticeLatest', noticeLatest)
          ..add('loadData', loadData))
        .toString();
  }
}

class NoticeListVMBuilder
    implements Builder<NoticeListVM, NoticeListVMBuilder> {
  _$NoticeListVM? _$v;

  ListBuilder<NoticeInfo>? _noticeList;
  ListBuilder<NoticeInfo> get noticeList =>
      _$this._noticeList ??= new ListBuilder<NoticeInfo>();
  set noticeList(ListBuilder<NoticeInfo>? noticeList) =>
      _$this._noticeList = noticeList;

  ListBuilder<NoticeInfo>? _noticeLatest;
  ListBuilder<NoticeInfo> get noticeLatest =>
      _$this._noticeLatest ??= new ListBuilder<NoticeInfo>();
  set noticeLatest(ListBuilder<NoticeInfo>? noticeLatest) =>
      _$this._noticeLatest = noticeLatest;

  Future<int> Function(bool isRefresh, int skip)? _loadData;
  Future<int> Function(bool isRefresh, int skip)? get loadData =>
      _$this._loadData;
  set loadData(Future<int> Function(bool isRefresh, int skip)? loadData) =>
      _$this._loadData = loadData;

  NoticeListVMBuilder();

  NoticeListVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _noticeList = $v.noticeList?.toBuilder();
      _noticeLatest = $v.noticeLatest?.toBuilder();
      _loadData = $v.loadData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeListVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NoticeListVM;
  }

  @override
  void update(void Function(NoticeListVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoticeListVM build() => _build();

  _$NoticeListVM _build() {
    _$NoticeListVM _$result;
    try {
      _$result = _$v ??
          new _$NoticeListVM._(
              noticeList: _noticeList?.build(),
              noticeLatest: _noticeLatest?.build(),
              loadData: BuiltValueNullFieldError.checkNotNull(
                  loadData, r'NoticeListVM', 'loadData'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'noticeList';
        _noticeList?.build();
        _$failedField = 'noticeLatest';
        _noticeLatest?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NoticeListVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NoticeInfo extends NoticeInfo {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? coverImg;
  @override
  final int? createdAt;
  @override
  final BuiltList<String>? shareImg;
  String? __image;
  List<String>? __shareImgWithUrl;

  factory _$NoticeInfo([void Function(NoticeInfoBuilder)? updates]) =>
      (new NoticeInfoBuilder()..update(updates))._build();

  _$NoticeInfo._(
      {this.id, this.title, this.coverImg, this.createdAt, this.shareImg})
      : super._();

  @override
  String get image => __image ??= super.image;

  @override
  List<String> get shareImgWithUrl =>
      __shareImgWithUrl ??= super.shareImgWithUrl;

  @override
  NoticeInfo rebuild(void Function(NoticeInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoticeInfoBuilder toBuilder() => new NoticeInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoticeInfo &&
        id == other.id &&
        title == other.title &&
        coverImg == other.coverImg &&
        createdAt == other.createdAt &&
        shareImg == other.shareImg;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), title.hashCode), coverImg.hashCode),
            createdAt.hashCode),
        shareImg.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoticeInfo')
          ..add('id', id)
          ..add('title', title)
          ..add('coverImg', coverImg)
          ..add('createdAt', createdAt)
          ..add('shareImg', shareImg))
        .toString();
  }
}

class NoticeInfoBuilder implements Builder<NoticeInfo, NoticeInfoBuilder> {
  _$NoticeInfo? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _coverImg;
  String? get coverImg => _$this._coverImg;
  set coverImg(String? coverImg) => _$this._coverImg = coverImg;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  ListBuilder<String>? _shareImg;
  ListBuilder<String> get shareImg =>
      _$this._shareImg ??= new ListBuilder<String>();
  set shareImg(ListBuilder<String>? shareImg) => _$this._shareImg = shareImg;

  NoticeInfoBuilder();

  NoticeInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _coverImg = $v.coverImg;
      _createdAt = $v.createdAt;
      _shareImg = $v.shareImg?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NoticeInfo;
  }

  @override
  void update(void Function(NoticeInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoticeInfo build() => _build();

  _$NoticeInfo _build() {
    _$NoticeInfo _$result;
    try {
      _$result = _$v ??
          new _$NoticeInfo._(
              id: id,
              title: title,
              coverImg: coverImg,
              createdAt: createdAt,
              shareImg: _shareImg?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'shareImg';
        _shareImg?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NoticeInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NoticeState extends NoticeState {
  @override
  final BuiltList<NoticeInfo>? noticeList;
  @override
  final BuiltList<NoticeInfo>? noticeLatest;
  @override
  final NoticeInfo? noticeDetail;

  factory _$NoticeState([void Function(NoticeStateBuilder)? updates]) =>
      (new NoticeStateBuilder()..update(updates))._build();

  _$NoticeState._({this.noticeList, this.noticeLatest, this.noticeDetail})
      : super._();

  @override
  NoticeState rebuild(void Function(NoticeStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoticeStateBuilder toBuilder() => new NoticeStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoticeState &&
        noticeList == other.noticeList &&
        noticeLatest == other.noticeLatest &&
        noticeDetail == other.noticeDetail;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, noticeList.hashCode), noticeLatest.hashCode),
        noticeDetail.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoticeState')
          ..add('noticeList', noticeList)
          ..add('noticeLatest', noticeLatest)
          ..add('noticeDetail', noticeDetail))
        .toString();
  }
}

class NoticeStateBuilder implements Builder<NoticeState, NoticeStateBuilder> {
  _$NoticeState? _$v;

  ListBuilder<NoticeInfo>? _noticeList;
  ListBuilder<NoticeInfo> get noticeList =>
      _$this._noticeList ??= new ListBuilder<NoticeInfo>();
  set noticeList(ListBuilder<NoticeInfo>? noticeList) =>
      _$this._noticeList = noticeList;

  ListBuilder<NoticeInfo>? _noticeLatest;
  ListBuilder<NoticeInfo> get noticeLatest =>
      _$this._noticeLatest ??= new ListBuilder<NoticeInfo>();
  set noticeLatest(ListBuilder<NoticeInfo>? noticeLatest) =>
      _$this._noticeLatest = noticeLatest;

  NoticeInfoBuilder? _noticeDetail;
  NoticeInfoBuilder get noticeDetail =>
      _$this._noticeDetail ??= new NoticeInfoBuilder();
  set noticeDetail(NoticeInfoBuilder? noticeDetail) =>
      _$this._noticeDetail = noticeDetail;

  NoticeStateBuilder();

  NoticeStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _noticeList = $v.noticeList?.toBuilder();
      _noticeLatest = $v.noticeLatest?.toBuilder();
      _noticeDetail = $v.noticeDetail?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NoticeState;
  }

  @override
  void update(void Function(NoticeStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoticeState build() => _build();

  _$NoticeState _build() {
    _$NoticeState _$result;
    try {
      _$result = _$v ??
          new _$NoticeState._(
              noticeList: _noticeList?.build(),
              noticeLatest: _noticeLatest?.build(),
              noticeDetail: _noticeDetail?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'noticeList';
        _noticeList?.build();
        _$failedField = 'noticeLatest';
        _noticeLatest?.build();
        _$failedField = 'noticeDetail';
        _noticeDetail?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NoticeState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
