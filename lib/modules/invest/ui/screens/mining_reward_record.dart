part of invest_ui_module;

class MiningRewardRecordPage extends HookWidget {
  const MiningRewardRecordPage();
  static const routeName = '/invest/reward/record';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      MiningRewardRecordPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = useBehaviorStreamController<CSListViewParams>();

    return CSScaffold(
      title: tr('invest:mining_record_title'),
      child: StoreConnector<AppState, InvestProfitVM>(
        converter: InvestProfitVM.fromStore,
        onInitialBuild: (_) {
          request.add(CSListViewParams());
        },
        builder: (context, viewModel) {
          final list = viewModel.profitRecordList;
          return CSListViewStream(
            emptyLabel: tr('invest:mining_record_lbl_list_empty'),
            emptyImageUrl: 'assets/images/empty_record.png',
            requestStream: request,
            onLoadData: (params) {
              return viewModel.getProfitRecordList(
                isRefresh: params.isRefresh,
                skip: params.skip,
                take: 10,
              );
            },
            itemCount: list.length,
            itemBuilder: (context, index) {
              return MiningRewardItem(
                item: list[index],
                mintItem: viewModel.activeMint,
              );
            },
          );
        },
      ),
    );
  }
}
