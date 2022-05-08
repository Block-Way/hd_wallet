part of notice_ui_module;

class NoticeDetailPage extends StatelessWidget {
  const NoticeDetailPage(
    this.item,
    this.itemId,
  );
  final NoticeInfo item;
  final int itemId;

  static const routeName = '/notice/detail';

  static void open(NoticeInfo item, [int itemId]) {
    AppNavigator.push(routeName, params: MapEntry(itemId ?? item.id, item));
  }

  static Route<dynamic> route(RouteSettings settings) {
    final item = settings.arguments as MapEntry<int, NoticeInfo>;
    return DefaultTransition(
      settings,
      NoticeDetailPage(item.value, item.key),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = context.mediaWidth - context.edgeSizeDouble;

    return CSScaffold(
      title: item?.title ?? tr('global:lbl_loading'),
      scrollable: true,
      child: Container(
        width: double.infinity,
        padding: context.edgeBottom,
        child: StoreConnector<AppState, NoticeDetailVM>(
          onInit: (store) {
            store.dispatch(NoticeActionGetDetail(itemId ?? item.id));
          },
          distinct: true,
          converter: NoticeDetailVM.fromStore,
          builder: (context, viewModel) => viewModel.noticeDetail != null &&
                  viewModel.noticeDetail.id == itemId
              ? Column(
                  children: viewModel.noticeDetail.shareImgWithUrl
                      .map((imgUrl) => CSImage(
                            imgUrl,
                            width: width,
                          ))
                      .toList(),
                )
              : Container(),
        ),
      ),
    );
  }
}
