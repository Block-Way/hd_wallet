part of app_module;

class ModelPermissionView extends StatelessWidget {
  const ModelPermissionView({
    @required this.moduleName,
    @required this.child,
    this.onRefreshSuccess,
  });

  final Widget child;
  final String moduleName;
  final void Function() onRefreshSuccess;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModulePermissionVM>(
      distinct: true,
      converter: ModulePermissionVM.fromStore,
      builder: (context, viewModel) {
        final permission = viewModel.getModulePermission(moduleName);

        return Stack(
          children: [
            child,
            if (permission != ModulePermissionState.valid)
              Container(
                color: context.backdropColor,
                width: double.infinity,
                child: Center(
                  child: permission == ModulePermissionState.loading
                      ? CSProgressIndicator(
                          strokeWidth: 4,
                          color: context.whiteColor,
                          size: context.mediaWidth * 0.1,
                        )
                      : SizedBox(),
                ),
              ),
            if (permission != ModulePermissionState.valid &&
                permission != ModulePermissionState.loading)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CSContainer(
                  height: context.mediaHeight * 0.25,
                  child: buildPermissionWidget(
                    context,
                    viewModel,
                    permission,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildPermissionWidget(
    BuildContext context,
    ModulePermissionVM viewModel,
    ModulePermissionState permission,
  ) {
    var message = '', btnText = '', showLoading = false;

    switch (permission) {
      case ModulePermissionState.disable:
        message = tr('global:lbl_module_disable');
        btnText = tr('global:btn_refresh');
        showLoading = true;
        break;
      case ModulePermissionState.needConfig:
      case ModulePermissionState.needModuleConfig:
        message = tr('global:lbl_net_error_refresh');
        btnText = tr('global:btn_refresh');
        showLoading = true;
        break;
      case ModulePermissionState.needUpdate:
        message = tr('global:update_btn_update');
        btnText = tr('global:update_dialog_btn_confirm');
        break;
      default:
    }

    return CSContainer(
      secondary: true,
      margin: EdgeInsets.zero,
      height: context.mediaHeight * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: context.edgeSize),
          Text(
            message,
            style: context.textBody(color: context.secondaryColor),
          ),
          SizedBox(height: context.edgeSize),
          if (btnText.isNotEmpty)
            CSButton(
              label: btnText,
              fullwidth: true,
              cmpLeft: Padding(
                padding: context.edgeRight5,
                child: Icon(
                  CSIcons.Refresh,
                  size: 14,
                  color: context.bodyColor,
                ),
              ),
              onPressed: () {
                if (permission == ModulePermissionState.needUpdate) {
                  showUpdateAppDialog(
                    context,
                    downloadUrl: viewModel.newVersionData.downloadUrl,
                    description: viewModel.newVersionData.description,
                    version: viewModel.newVersionData.version,
                  );
                  return;
                }
                if (showLoading) {
                  LoadingDialog.show(context);
                }
                viewModel
                    .doRefreshModulePermission(moduleName, permission)
                    .then((value) {
                  if (onRefreshSuccess != null && value == true) {
                    onRefreshSuccess();
                  }
                }).catchError((error) {
                  Toast.showError(error);
                }).whenComplete(() {
                  if (showLoading) {
                    LoadingDialog.dismiss(context);
                  }
                });
              },
            ),
        ],
      ),
    );
  }
}
