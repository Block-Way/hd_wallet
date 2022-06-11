// GENERATED CODE - DO NOT MODIFY BY HAND

part of explorer_domain_module;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExplorerHomeVM extends ExplorerHomeVM {
  @override
  final List<ExplorerItem> explorerList;

  factory _$ExplorerHomeVM([void Function(ExplorerHomeVMBuilder)? updates]) =>
      (new ExplorerHomeVMBuilder()..update(updates))._build();

  _$ExplorerHomeVM._({required this.explorerList}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        explorerList, r'ExplorerHomeVM', 'explorerList');
  }

  @override
  ExplorerHomeVM rebuild(void Function(ExplorerHomeVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExplorerHomeVMBuilder toBuilder() =>
      new ExplorerHomeVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExplorerHomeVM && explorerList == other.explorerList;
  }

  @override
  int get hashCode {
    return $jf($jc(0, explorerList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExplorerHomeVM')
          ..add('explorerList', explorerList))
        .toString();
  }
}

class ExplorerHomeVMBuilder
    implements Builder<ExplorerHomeVM, ExplorerHomeVMBuilder> {
  _$ExplorerHomeVM? _$v;

  List<ExplorerItem>? _explorerList;
  List<ExplorerItem>? get explorerList => _$this._explorerList;
  set explorerList(List<ExplorerItem>? explorerList) =>
      _$this._explorerList = explorerList;

  ExplorerHomeVMBuilder();

  ExplorerHomeVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _explorerList = $v.explorerList;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExplorerHomeVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExplorerHomeVM;
  }

  @override
  void update(void Function(ExplorerHomeVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExplorerHomeVM build() => _build();

  _$ExplorerHomeVM _build() {
    final _$result = _$v ??
        new _$ExplorerHomeVM._(
            explorerList: BuiltValueNullFieldError.checkNotNull(
                explorerList, r'ExplorerHomeVM', 'explorerList'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
