part of notice_ui_module;

class NoticeListPage extends HookWidget {
  static const routeName = '/notice/list';
  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      NoticeListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = useBehaviorStreamController<CSListViewParams>();

    return CSScaffold(
      title: tr('home:notice_list_title'),
      child: StoreConnector<AppState, NoticeListVM>(
        distinct: true,
        converter: NoticeListVM.fromStore,
        onInitialBuild: (viewModel) {
          request.add(CSListViewParams());
        },
        builder: (context, viewModel) {
          return CSListViewStream(
              emptyLabel: tr('home:notice_list_msg_empty'),
              emptyImageUrl: 'assets/images/empty_record.png',
              requestStream: request,
              onLoadData: (params) {
                return viewModel.loadData(
                  params.isRefresh,
                  params.skip,
                );
              },
              itemCount: viewModel.listCount,
              itemBuilder: (context, index) {
                return NoticeListItem(item: viewModel.noticeList[index]);
              });
        },
      ),
    );
  }
}
