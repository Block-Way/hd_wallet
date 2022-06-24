part of notice_domain_module;

abstract class NoticeDetailVM
    implements Built<NoticeDetailVM, NoticeDetailVMBuilder> {
  factory NoticeDetailVM([void Function(NoticeDetailVMBuilder) updates]) =
      _$NoticeDetailVM;
  NoticeDetailVM._();

// UI Fields

  //@nullable
  NoticeInfo? get noticeDetail;

// UI Actions

// UI Logic
  static NoticeDetailVM fromStore(Store<AppState> store) {
    return NoticeDetailVM(
      (viewModel) => viewModel
        ..noticeDetail = store.state.noticeState.noticeDetail?.toBuilder(),
    );
  }
}
