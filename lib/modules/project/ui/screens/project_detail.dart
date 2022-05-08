part of project_ui_module;

class ProjectDetailStatus {
  static const introduction = 'introduction';
  static const detail = 'detail';
}

class ProjectDetailPage extends HookWidget {
  const ProjectDetailPage(
    this.params, {
    Key key,
  }) : super(key: key);

  static const routeName = '/project/detail';

  static void open(ProjectDetailParams params) {
    AppNavigator.push(
      routeName,
      params: params,
    );
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      ProjectDetailPage(settings.arguments as ProjectDetailParams),
    );
  }

  final ProjectDetailParams params;

  @override
  Widget build(BuildContext context) {
    final selectedStatusId = useState(ProjectDetailStatus.introduction);
    final projectInfo = useState<ProjectInfo>(ProjectInfo());

    final detailList = [
      {
        'name': tr('project:detail_lbl_id'),
        'label': projectInfo.value?.fork ?? '',
      },
      {
        'name': tr('project:detail_lbl_coin_name'),
        'label': projectInfo.value?.symbol ?? '',
      },
      {
        'name': tr('project:detail_lbl_price', namedArgs: {'symbol': 'USDT'}),
        'label': projectInfo.value?.displayPrice ?? '',
      },
      {
        'name': tr('project:detail_lbl_total_amount'),
        'label':
            '''${projectInfo.value?.displayTotalAmount ?? ''} ${projectInfo.value?.symbol ?? ''}''',
      },
      {
        'name': tr('project:detail_lbl_init_amount'),
        'label':
            '''${projectInfo.value?.displayInitAmount ?? ''} ${projectInfo.value?.symbol ?? ''}''',
      },
      {
        'name': tr('project:detail_lbl_owner_name'),
        'label': projectInfo.value != null &&
                projectInfo.value.ownerName != null &&
                projectInfo.value.ownerName.isNotEmpty
            ? projectInfo.value?.ownerName['default'].toString()
            : '',
      },
      {
        'name': tr('project:detail_detail_web'),
        'label': projectInfo.value?.ownerWebsite ?? '',
        'isWebAddress': true,
      },
    ];

    return CSScaffold(
      title: tr('project:detail_title'),
      backgroundColor: context.whiteColor,
      child: StoreConnector<AppState, ProjectDetailVM>(
        distinct: true,
        converter: ProjectDetailVM.fromStore,
        onInitialBuild: (viewModel) {
          LoadingDialog.show(context);
          viewModel.getProjectDetail(params.id).then((value) {
            projectInfo.value = value;
          }).catchError((e) {
            Toast.showError(e);
          }).whenComplete(() {
            LoadingDialog.dismiss(context);
          });
        },
        builder: (context, viewModel) => Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: context.edgeAll,
                  child: Row(
                    children: [
                      CSImage(
                        params.iconUrl ?? 'assets/images/image_error.png',
                        width: 17,
                        height: 17,
                        radius: 17,
                      ),
                      Container(
                        width: context.mediaWidth * 0.8,
                        padding: context.edgeLeft10,
                        child: Text(
                          projectInfo.value?.projectName ?? '',
                          style: context.textBody(bold: true),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                CSButtonTabs(
                  items: [
                    CSButtonTabsItem(
                      id: ProjectDetailStatus.introduction,
                      label: tr('project:detail_table_info'),
                    ),
                    CSButtonTabsItem(
                      id: ProjectDetailStatus.detail,
                      label: tr('project:detail_table_description'),
                    ),
                  ],
                  selectedId: selectedStatusId.value,
                  onSelectedId: (id) {
                    selectedStatusId.value = id;
                  },
                ),
                if (selectedStatusId.value == ProjectDetailStatus.introduction)
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 40),
                      children: [
                        ...detailList.map((item) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.edgeSize,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item['name'].toString() ?? '',
                                    style: context.textBody(
                                        color: context.secondaryColor),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: item['isWebAddress'] == true
                                          ? () {
                                              WebViewPage.open(
                                                item['label'].toString(),
                                              );
                                            }
                                          : null,
                                      child: Text(
                                        item['label'].toString() ?? '',
                                        textAlign: TextAlign.end,
                                        style: context
                                            .textBody(
                                              color:
                                                  item['isWebAddress'] == true
                                                      ? context.orangeColor
                                                      : context.bodyColor,
                                            )
                                            .copyWith(height: 1.71),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                if (selectedStatusId.value == ProjectDetailStatus.detail)
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: context.edgeSize,
                            right: context.edgeSize,
                            bottom: 30,
                          ),
                          child: Text(
                            projectInfo.value != null &&
                                    projectInfo.value.projectDescription !=
                                        null &&
                                    projectInfo
                                        .value.projectDescription.isNotEmpty
                                ? projectInfo
                                    .value.projectDescription['default']
                                    .toString()
                                : '',
                            style: context.textBody().copyWith(height: 2),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (projectInfo.value.displayPoolBtn)
              Positioned(
                right: 0,
                left: 0,
                bottom: -15,
                child: Container(
                  alignment: Alignment.center,
                  child: CSButton(
                    label: tr('project:detail_btn_go_pool'),
                    fullwidth: true,
                    borderRadius: 0,
                    onPressed: () {
                      LoadingDialog.show(context);
                      viewModel.setActivePool(projectInfo.value.id).then(
                        (value) {
                          LoadingDialog.dismiss(context);
                          AppNavigator.gotoTabBar();
                          //todo go pool
                          // AppNavigator.gotoTabBarPage(1);
                        },
                      ).catchError(
                        (e) {
                          LoadingDialog.dismiss(context);
                          Toast.showError(e);
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
