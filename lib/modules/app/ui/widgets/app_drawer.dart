part of app_module;

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var debugTabCount = 0;
    return CSDrawer(
      width: 264,
      elevation: 100,
      decoration: AppDrawerBackground(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: StoreConnector<AppState, AppCommonVM>(
          distinct: true,
          converter: AppCommonVM.fromStore,
          builder: (context, viewModel) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: GestureDetector(
                  onTap: () {
                    debugTabCount++;
                    if (debugTabCount > 10) {
                      showAlertDialog(
                        context,
                        content: viewModel.debugStrings.join('\n\n'),
                        onDismiss: () {
                          copyTextToClipboard(
                            viewModel.debugStrings.join('\n\n'),
                          );
                          Toast.show(tr('global:msg_copy_success'));
                        },
                      );
                    }
                  },
                ),
              ),
              Spacer(),
              AppDrawerMenuLink(
                label: tr('user:menu_website'),
                url: AppLinks.appWebsiteUrl,
              ),
              AppDrawerMenuTap(
                label: tr('user:menu_help'),
                onPress: () {
                  HelpCenterPage.open();
                },
              ),
              // AppDrawerMenuVersion(
              //   label: tr('user:menu_version'),
              //   hasNew: viewModel.hasNewVersion,
              //   version: viewModel.appVersion,
              //   // onPressed: () {
              //   //   LoadingDialog.show(context);
              //   //   viewModel.doCheckForUpdates(false).then((data) {
              //   //     LoadingDialog.dismiss(context);
              //   //     if (data != null) {
              //   //       showUpdateAppDialog(
              //   //         context,
              //   //         downloadUrl: data.downloadUrl,
              //   //         description: data.description,
              //   //         version: data.version,
              //   //       );
              //   //     } else {
              //   //       Toast.show(tr('global:update_dialog_msg_last'));
              //   //     }
              //   //   }).catchError((error) {
              //   //     LoadingDialog.dismiss(context);
              //   //     Toast.showError(error);
              //   //   });
              //   // },
              // ),
              // AppDrawerMenuLanguage(
              //   onSelected: (language) {
              //     // ignore: deprecated_member_use
              //     context.locale = Locale(language);
              //     viewModel.doChangeLanguage(language);
              //   },
              // ),
              // AppDrawerMenuVersion(
              //   label: tr('user:menu_version'),
              //   hasNew: viewModel.hasNewVersion,
              //   version: viewModel.appVersion, onPressed: () {},
              //   // onPressed: () {
              //   //   LoadingDialog.show(context);
              //   //   viewModel.doCheckForUpdates(false).then((data) {
              //   //     LoadingDialog.dismiss(context);
              //   //     if (data != null) {
              //   //       showUpdateAppDialog(
              //   //         context,
              //   //         downloadUrl: data.downloadUrl,
              //   //         description: data.description,
              //   //         version: data.version,
              //   //       );
              //   //     } else {
              //   //       Toast.show(tr('global:update_dialog_msg_last'));
              //   //     }
              //   //   }).catchError((error) {
              //   //     LoadingDialog.dismiss(context);
              //   //     Toast.showError(error);
              //   //   });
              //   // },
              // ),
              // if (AppConstants.isBeta)
              //   AppDrawerMenuVersion(
              //     label: 'D- ????????????',
              //     hasNew: viewModel.hasNewVersion,
              //     version: viewModel.appVersionBeta,
              //     onPressed: () {
              //       LoadingDialog.show(context);
              //       viewModel.doCheckForUpdates(true).then((data) {
              //         LoadingDialog.dismiss(context);
              //         if (data != null) {
              //           showUpdateAppDialog(
              //             context,
              //             downloadUrl: data.downloadUrl,
              //             description: data.description,
              //             version: data.version,
              //           );
              //         } else {
              //           Toast.show(tr('global:update_dialog_msg_last'));
              //         }
              //       }).catchError((error) {
              //         LoadingDialog.dismiss(context);
              //         Toast.showError(error);
              //       });
              //     },
              //   ),
              // if (AppConstants.isBeta)
              //   AppDrawerMenuTap(
              //     label: 'D- ?????????????????????',
              //     onPress: () {
              //       SettingsDevPage.open();
              //     },
              //   ),
              // if (AppConstants.isBeta)
              //   AppDrawerMenuTap(
              //     label: 'D- ?????????????????????',
              //     onPress: () {
              //       SettingsTestnetPage.open();
              //     },
              //   ),
              // if (AppConstants.isBeta)
              //   AppDrawerMenuTap(
              //     label: 'D- APP??????',
              //     onPress: () {
              //       showAlertDialog(
              //         context,
              //         content: viewModel.debugStrings.join('\n\n'),
              //         onDismiss: () {
              //           copyTextToClipboard(
              //             viewModel.debugStrings.join('\n\n'),
              //           );
              //           Toast.show(tr('global:msg_copy_success'));
              //         },
              //       );
              //     },
              //   ),
              Spacer(),
              Row(
                children: const [
                  AppDrawerMenuSocial(
                    icon: 'assets/images/social_twitter.png',
                    url: AppLinks.appTwitter,
                  ),
                  AppDrawerMenuSocial(
                    icon: 'assets/images/social_facebook.png',
                    url: AppLinks.appFacebook,
                  ),
                  AppDrawerMenuSocial(
                    icon: 'assets/images/social_ins.png',
                    url: AppLinks.appInstagram,
                  ),
                  AppDrawerMenuSocial(
                    icon: 'assets/images/social_tele.png',
                    url: AppLinks.appTelegram,
                  ),
                ],
              ),
              Padding(
                padding: context.edgeAll.copyWith(top: 0),
                child: Text(
                  tr('user:drawer_copyright'),
                  style: context.textTiny(color: context.labelColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
