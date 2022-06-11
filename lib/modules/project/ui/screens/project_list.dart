part of project_ui_module;

class ProjectDetailParams {
  const ProjectDetailParams({
    this.id,
    this.iconUrl,
  });
  final int? id;
  final String? iconUrl;
}

class ProjectListPage extends HookWidget {
  static const routeName = '/project/list';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      ProjectListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = useBehaviorStreamController<CSListViewParams>();

    return CSScaffold(
      title: tr('project:list_title'),
      backgroundColor: context.whiteColor,
      child: StoreConnector<AppState, ProjectListVM>(
        distinct: true,
        converter: ProjectListVM.fromStore,
        builder: (context, viewModel) => CSListViewStream(
          emptyLabel: tr('project:list_lbl_empty'),
          emptyImageUrl: 'assets/images/notify_empty_record.png',
          requestStream: request,
          onLoadData: (params) {
            return viewModel.loadData(
              isRefresh: params.isRefresh,
              skip: params.skip,
            );
          },
          itemCount: viewModel.listCount,
          itemBuilder: (context, index) {
            return ProjectItem(
              item: viewModel.projectsList[index],
              onPress: () {
                ProjectDetailPage.open(ProjectDetailParams(
                  id: viewModel.projectsList[index].id,
                  iconUrl: viewModel.projectsList[index].iconUrl,
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
