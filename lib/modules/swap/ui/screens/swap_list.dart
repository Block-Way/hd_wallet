part of swap_ui_module;

class SwapListPage extends StatelessWidget {
  const SwapListPage();
  static const routeName = '/swap/list';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      SwapListPage(),
    );
  }

  void doResubmit(BuildContext context, SwapListVM viewModel, Swap item) {
    LoadingDialog.show(context);
    viewModel.doReSubmit(item).then((value) {
      LoadingDialog.dismiss(context);
      viewModel.loadData(
        0,
        10,
      );
      Toast.show(tr('swap:msg_resubmit_success'));
    }).catchError((error) {
      LoadingDialog.dismiss(context);
      Toast.showError(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      title: tr('swap:list_title'),
      child: StoreConnector<AppState, SwapListVM>(
        distinct: true,
        converter: SwapListVM.fromStore,
        onInitialBuild: (viewModel) {},
        builder: (context, viewModel) => Container(
          decoration: ThemeBorders.borderTop,
          child: CSListViewStream(
            emptyLabel: tr('global:list_data_empty'),
            emptyImageUrl: 'assets/images/notify_empty_record.png',
            requestStream: null, // TODO
            onLoadData: (params) {
              return viewModel.loadData(
                params.skip,
                10,
              );
            },
            itemCount: viewModel.swapList.length ?? 0,
            itemBuilder: (context, index) {
              return SwapItem(
                item: viewModel.swapList[index],
                onPress: (item) {
                  doResubmit(
                    context,
                    viewModel,
                    item,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
