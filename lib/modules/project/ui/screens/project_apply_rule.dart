part of project_ui_module;

class ProjectApplyRulePage extends HookWidget {
  static const routeName = '/project/apply/rule';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      ProjectApplyRulePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
        title: tr('project:create_title'),
        backgroundColor: context.whiteColor,
        scrollable: true,
        child: StoreConnector<AppState, ProjectApplyVM>(
          distinct: true,
          converter: ProjectApplyVM.fromStore,
          onInitialBuild: (viewModel) {
            LoadingDialog.show(context);
            viewModel.getProjectConfig().catchError((e) {
              Toast.showError(e);
              LoadingDialog.dismiss(context);
            }).whenComplete(() {
              LoadingDialog.dismiss(context);
            });
          },
          builder: (context, viewModel) => Container(
            padding: context.edgeAll,
            child: StoreConnector<AppState, ProjectApplyVM>(
                distinct: true,
                converter: ProjectApplyVM.fromStore,
                builder: (context, viewModel) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('project:create_lbl_tips'),
                          style: context.textTitle(),
                        ),
                        Padding(
                          padding: context.edgeVertical10,
                          child: Text(
                            viewModel.projectRules ?? '',
                            style: context
                                .textBody(color: Color(0xFF000000))
                                .copyWith(height: 2),
                            softWrap: true,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: CSButton(
                            label: tr('project:create_btn_apply'),
                            onPressed: () {
                              ProjectApplyCreatePage.open(
                                viewModel.lastProjectCreateParams ??
                                    ProjectCreateParams(),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
          ),
        ));
  }
}
