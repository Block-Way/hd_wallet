part of community_ui_module;

class CommunityBlacklistPage extends HookWidget {
  const CommunityBlacklistPage(this.info);
  final CommunityInfo info;

  static const routeName = '/community/blacklist';

  static void open(CommunityInfo info) {
    AppNavigator.push(routeName, params: info);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      CommunityBlacklistPage(settings.arguments as CommunityInfo),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = useBehaviorStreamController<CSListViewParams>();

    return CSScaffold(
      title: tr('community:blacklist_title'),
      child: StoreConnector<AppState, CommunityBlacklistVM>(
        distinct: true,
        converter: CommunityBlacklistVM.fromStore,
        onInitialBuild: (viewModel) {
          viewModel.clearCommunityBlacklist();
          request.add(CSListViewParams(
            take: 20,
          ));
        },
        builder: (context, viewModel) => CSListViewStream(
          emptyLabel: tr('community:blacklist_list_empty'),
          emptyImageUrl: 'assets/images/empty_record.png',
          requestStream: request,
          onLoadData: (params) {
            return viewModel.loadData(
              isRefresh: params.isRefresh,
              skip: params.skip,
              searchName: '',
              type: '${info.type}',
            );
          },
          itemCount: viewModel.communityBlacklist.length,
          itemBuilder: (context, index) => CommunityListItem(
            name: viewModel.communityBlacklist[index].name,
            displayIcon: viewModel.communityBlacklist[index].displayIcon,
            hasWallet: viewModel.hasWallet,
            isBlacklist: true,
            index: index,
            onPress: () {
              CommunityTeamPage.open(
                info,
                viewModel.communityBlacklist[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
