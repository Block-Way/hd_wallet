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
  Iterable<Object> serialize(Serializers serializers, NoticeInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.coverImg != null) {
      result
        ..add('cover_img')
        ..add(serializers.serialize(object.coverImg,
            specifiedType: const FullType(String)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(int)));
    }
    if (object.shareImg != null) {
      result
        ..add('share_img')
        ..add(serializers.serialize(object.shareImg,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  NoticeInfo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NoticeInfoBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cover_img':
          result.coverImg = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'share_img':
          result.shareImg.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$NoticeDetailVM extends NoticeDetailVM {
  @override
  final NoticeInfo noticeDetail;

  factory _$NoticeDetailVM([void Function(NoticeDetailVMBuilder) updates]) =>
      (new NoticeDetailVMBuilder()..update(updates)).build();

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
    return (newBuiltValueToStringHelper('NoticeDetailVM')
          ..add('noticeDetail', noticeDetail))
        .toString();
  }
}

class NoticeDetailVMBuilder
    implements Builder<NoticeDetailVM, NoticeDetailVMBuilder> {
  _$NoticeDetailVM _$v;

  NoticeInfoBuilder _noticeDetail;
  NoticeInfoBuilder get noticeDetail =>
      _$this._noticeDetail ??= new NoticeInfoBuilder();
  set noticeDetail(NoticeInfoBuilder noticeDetail) =>
      _$this._noticeDetail = noticeDetail;

  NoticeDetailVMBuilder();

  NoticeDetailVMBuilder get _$this {
    if (_$v != null) {
      _noticeDetail = _$v.noticeDetail?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeDetailVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NoticeDetailVM;
  }

  @override
  void update(void Function(NoticeDetailVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NoticeDetailVM build() {
    _$NoticeDetailVM _$result;
    try {
      _$result =
          _$v ?? new _$NoticeDetailVM._(noticeDetail: _noticeDetail?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'noticeDetail';
        _noticeDetail?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NoticeDetailVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NoticeListVM extends NoticeListVM {
  @override
  final BuiltList<NoticeInfo> noticeList;
  @override
  final BuiltList<NoticeInfo> noticeLatest;
  @override
  final Future<int> Function(bool isRefresh, int skip) loadData;

  factory _$NoticeListVM([void Function(NoticeListVMBuilder) updates]) =>
      (new NoticeListVMBuilder()..update(updates)).build();

  _$NoticeListVM._({this.noticeList, this.noticeLatest, this.loadData})
      : super._() {
    if (loadData == null) {
      throw new BuiltValueNullFieldError('NoticeListVM', 'loadData');
    }
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
    return (newBuiltValueToStringHelper('NoticeListVM')
          ..add('noticeList', noticeList)
          ..add('noticeLatest', noticeLatest)
          ..add('loadData', loadData))
        .toString();
  }
}

class NoticeListVMBuilder
    implements Builder<NoticeListVM, NoticeListVMBuilder> {
  _$NoticeListVM _$v;

  ListBuilder<NoticeInfo> _noticeList;
  ListBuilder<NoticeInfo> get noticeList =>
      _$this._noticeList ??= new ListBuilder<NoticeInfo>();
  set noticeList(ListBuilder<NoticeInfo> noticeList) =>
      _$this._noticeList = noticeList;

  ListBuilder<NoticeInfo> _noticeLatest;
  ListBuilder<NoticeInfo> get noticeLatest =>
      _$this._noticeLatest ??= new ListBuilder<NoticeInfo>();
  set noticeLatest(ListBuilder<NoticeInfo> noticeLatest) =>
      _$this._noticeLatest = noticeLatest;

  Future<int> Function(bool isRefresh, int skip) _loadData;
  Future<int> Function(bool isRefresh, int skip) get loadData =>
      _$this._loadData;
  set loadData(Future<int> Function(bool isRefresh, int skip) loadData) =>
      _$this._loadData = loadData;

  NoticeListVMBuilder();

  NoticeListVMBuilder get _$this {
    if (_$v != null) {
      _noticeList = _$v.noticeList?.toBuilder();
      _noticeLatest = _$v.noticeLatest?.toBuilder();
      _loadData = _$v.loadData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeListVM other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NoticeListVM;
  }

  @override
  void update(void Function(NoticeListVMBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NoticeListVM build() {
    _$NoticeListVM _$result;
    try {
      _$result = _$v ??
          new _$NoticeListVM._(
              noticeList: _noticeList?.build(),
              noticeLatest: _noticeLatest?.build(),
              loadData: loadData);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'noticeList';
        _noticeList?.build();
        _$failedField = 'noticeLatest';
        _noticeLatest?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NoticeListVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NoticeInfo extends NoticeInfo {
  @override
  final int id;
  @override
  final String title;
  @override
  final String coverImg;
  @override
  final int createdAt;
  @override
  final BuiltList<String> shareImg;
  String __image;
  List<String> __shareImgWithUrl;

  factory _$NoticeInfo([void Function(NoticeInfoBuilder) updates]) =>
      (new NoticeInfoBuilder()..update(updates)).build();

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
    return (newBuiltValueToStringHelper('NoticeInfo')
          ..add('id', id)
          ..add('title', title)
          ..add('coverImg', coverImg)
          ..add('createdAt', createdAt)
          ..add('shareImg', shareImg))
        .toString();
  }
}

class NoticeInfoBuilder implements Builder<NoticeInfo, NoticeInfoBuilder> {
  _$NoticeInfo _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _coverImg;
  String get coverImg => _$this._coverImg;
  set coverImg(String coverImg) => _$this._coverImg = coverImg;

  int _createdAt;
  int get createdAt => _$this._createdAt;
  set createdAt(int createdAt) => _$this._createdAt = createdAt;

  ListBuilder<String> _shareImg;
  ListBuilder<String> get shareImg =>
      _$this._shareImg ??= new ListBuilder<String>();
  set shareImg(ListBuilder<String> shareImg) => _$this._shareImg = shareImg;

  NoticeInfoBuilder();

  NoticeInfoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _coverImg = _$v.coverImg;
      _createdAt = _$v.createdAt;
      _shareImg = _$v.shareImg?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NoticeInfo;
  }

  @override
  void update(void Function(NoticeInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NoticeInfo build() {
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
      String _$failedField;
      try {
        _$failedField = 'shareImg';
        _shareImg?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NoticeInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NoticeState extends NoticeState {
  @override
  final BuiltList<NoticeInfo> noticeList;
  @override
  final BuiltList<NoticeInfo> noticeLatest;
  @override
  final NoticeInfo noticeDetail;

  factory _$NoticeState([void Function(NoticeStateBuilder) updates]) =>
      (new NoticeStateBuilder()..update(updates)).build();

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
    return (newBuiltValueToStringHelper('NoticeState')
          ..add('noticeList', noticeList)
          ..add('noticeLatest', noticeLatest)
          ..add('noticeDetail', noticeDetail))
        .toString();
  }
}

class NoticeStateBuilder implements Builder<NoticeState, NoticeStateBuilder> {
  _$NoticeState _$v;

  ListBuilder<NoticeInfo> _noticeList;
  ListBuilder<NoticeInfo> get noticeList =>
      _$this._noticeList ??= new ListBuilder<NoticeInfo>();
  set noticeList(ListBuilder<NoticeInfo> noticeList) =>
      _$this._noticeList = noticeList;

  ListBuilder<NoticeInfo> _noticeLatest;
  ListBuilder<NoticeInfo> get noticeLatest =>
      _$this._noticeLatest ??= new ListBuilder<NoticeInfo>();
  set noticeLatest(ListBuilder<NoticeInfo> noticeLatest) =>
      _$this._noticeLatest = noticeLatest;

  NoticeInfoBuilder _noticeDetail;
  NoticeInfoBuilder get noticeDetail =>
      _$this._noticeDetail ??= new NoticeInfoBuilder();
  set noticeDetail(NoticeInfoBuilder noticeDetail) =>
      _$this._noticeDetail = noticeDetail;

  NoticeStateBuilder();

  NoticeStateBuilder get _$this {
    if (_$v != null) {
      _noticeList = _$v.noticeList?.toBuilder();
      _noticeLatest = _$v.noticeLatest?.toBuilder();
      _noticeDetail = _$v.noticeDetail?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NoticeState;
  }

  @override
  void update(void Function(NoticeStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NoticeState build() {
    _$NoticeState _$result;
    try {
      _$result = _$v ??
          new _$NoticeState._(
              noticeList: _noticeList?.build(),
              noticeLatest: _noticeLatest?.build(),
              noticeDetail: _noticeDetail?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'noticeList';
        _noticeList?.build();
        _$failedField = 'noticeLatest';
        _noticeLatest?.build();
        _$failedField = 'noticeDetail';
        _noticeDetail?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NoticeState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
