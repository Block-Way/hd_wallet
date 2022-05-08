part of community_ui_module;

class CommunityJoinPage extends HookWidget {
  CommunityJoinPage(
    this.info,
    this.team,
  );
  final CommunityInfo info;
  final CommunityTeam team;

  static const routeName = '/community/join';

  static Future<bool> open(CommunityInfo info, CommunityTeam team) {
    return AppNavigator.push<bool>(routeName, params: MapEntry(info, team));
  }

  static Route<bool> route(RouteSettings settings) {
    final item = settings.arguments as MapEntry<CommunityInfo, CommunityTeam>;
    return DefaultTransition<bool>(
      settings,
      CommunityJoinPage(item.key, item.value),
    );
  }

  final formKey = GlobalKey<FormState>();

  void showConfirmDataTip(
    BuildContext context, {
    void Function() onConfirm,
  }) {
    if (onConfirm != null) {
      showConfirmDialog(
        context,
        content: tr('community:create_msg_data_tip'),
        confirmBtnText: tr('global:btn_continue'),
        onConfirm: onConfirm,
      );
    } else {
      showAlertDialog(
        context,
        content: tr('community:create_msg_data_tip'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final myMember = useState<CommunityMember>(CommunityMember());

    final autovalidate = useState(false);
    final isUploading = useValueNotifier(false);

    final name = useTextEditingController(text: '');
    final desc = useTextEditingController(text: '');
    final github = useTextEditingController(text: '');
    final telegram = useTextEditingController(text: '');
    final logo = useTextEditingController(text: '');

    final trBase = CommunityUtils.getJoinTransKey(info.teamType);
    final visibleItems = TeamJoinParams.getVisible(info.teamType);

    final lblTitle = tr('${trBase}_title');

    final nameLbl = tr('${trBase}_name_lbl');
    final nameHint = tr('${trBase}_name_hint');
    final nameReq = tr('${trBase}_name_req');

    final descLbl = tr('${trBase}_desc_lbl');
    final descHint = tr('${trBase}_desc_hint');
    final descReq = tr('${trBase}_desc_req');

    final githubLbl = tr('${trBase}_github_lbl');
    final githubHint = tr('${trBase}_github_hint');
    final githubReq = tr('${trBase}_github_req');

    final telegramLbl = tr('${trBase}_telegram_lbl');
    final telegramHint = tr('${trBase}_telegram_hint');
    final telegramReq = tr('${trBase}_telegram_req');

    final logoLbl = tr('${trBase}_upload_logo_img_lbl');

    final canEdit = myMember.value.statusDefault;

    void handleSubmit(CommunityJoinVM viewModel) {
      if (!autovalidate.value) {
        autovalidate.value = true;
      }
      if (formKey.currentState.validate() != true) {
        return;
      }

      final params = TeamJoinParams.toApiParams(
        type: info.type,
        teamId: team.id,
        name: name.text,
        desc: desc.text,
        github: github.text,
        telegram: telegram.text,
        logo: logo.text,
        // images: images,
      );

      final errorKey = params.isValid();
      if (errorKey != null) {
        return Toast.show(tr('community:error_msg_$errorKey'));
      }

      showConfirmDataTip(context, onConfirm: () {
        AnalyticsReport().reportLog('Community_Join', {
          'type': info.type,
          'name': info.name,
        });
        LoadingDialog.show(context);
        viewModel.joinTeam(params).then((_) {
          LoadingDialog.dismiss(context);
          AppNavigator.popWithResult(true);
          Toast.show(tr('community:join_msg_success'));
        }).catchError((error) {
          LoadingDialog.dismiss(context);
          Toast.showError(error);
        });
      });
    }

    final imgItemWidth = (context.mediaWidth - context.edgeSize * 6) / 3;

    return WillPopScope(
      onWillPop: () async {
        if (isUploading.value == true) {
          Toast.show(tr('community:upload_msg_image_uploading'));
          return false;
        }
        return true;
      },
      child: CSScaffold(
        title: lblTitle,
        actions: [
          CSButtonIcon(
            icon: CSIcons.Mark,
            size: 20,
            padding: EdgeInsets.zero,
            background: Colors.transparent,
            onPressed: () {
              showConfirmDataTip(context);
            },
          ),
        ],
        child: ModelPermissionView(
          moduleName: ModuleName.community,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: autovalidate.value
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: StoreConnector<AppState, CommunityJoinVM>(
                distinct: true,
                converter: CommunityJoinVM.fromStore,
                onInitialBuild: (viewModel) {
                  if (viewModel.walletId == null ||
                      viewModel.walletId.isEmpty) {
                    AppNavigator.gotoTabBar();
                    AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
                    Toast.show(tr('wallet:msg_create_wallet_need'));
                    return;
                  }
                  if (info == null) {
                    AppNavigator.goBack();
                  }

                  LoadingDialog.show(context);
                  viewModel.getMyJoin(team.id).then((memberInfo) {
                    LoadingDialog.dismiss(context);
                    // 创建过
                    if (memberInfo != null && memberInfo.id != null) {
                      myMember.value = memberInfo;
                      name.text = memberInfo.info.name;
                      desc.text = memberInfo.info.describe;
                      github.text = memberInfo.info.github;
                      telegram.text = memberInfo.info.telegramAccount;
                    } else {
                      // 没有创建过
                      showConfirmDataTip(context);
                    }
                  }).catchError((error) {
                    LoadingDialog.dismiss(context);
                    Toast.showError(error);
                  });
                },
                builder: (context, viewModel) => Column(
                  children: [
                    FormBox(
                      title: nameLbl,
                      controller: name,
                      editable: canEdit,
                      type: FormBoxType.inputText,
                      hintText: nameHint,
                      validator: RequiredValidator(errorText: nameReq),
                      maxLength: 40,
                      maxLengthChineseDouble: true,
                    ),
                    FormBox(
                      title: descLbl,
                      controller: desc,
                      editable: canEdit,
                      type: FormBoxType.inputText,
                      maxLines: 5,
                      hintText: descHint,
                      validator: RequiredValidator(errorText: descReq),
                      maxLength: 1000,
                      maxLengthChineseDouble: true,
                    ),
                    if (visibleItems.contains('github'))
                      FormBox(
                        title: githubLbl,
                        controller: github,
                        editable: canEdit,
                        type: FormBoxType.inputText,
                        maxLength: 50,
                        hintText: githubHint,
                        validator: RequiredValidator(errorText: githubReq),
                      ),
                    FormBox(
                      title: telegramLbl,
                      controller: telegram,
                      editable: canEdit,
                      type: FormBoxType.inputText,
                      maxLength: 50,
                      hintText: telegramHint,
                      validator: RequiredValidator(errorText: telegramReq),
                    ),
                    if (canEdit)
                      FormBox(
                        title: logoLbl,
                        type: FormBoxType.child,
                        child: UploadButton(
                          size: imgItemWidth,
                          signature: viewModel.walletId,
                          uploadType: 'hd_team_user_icon',
                          onRemove: () {
                            logo.text = '';
                          },
                          onUploadSuccess: (path, _) {
                            logo.text = path;
                          },
                          onUploadChange: (uploading) {
                            isUploading.value = uploading;
                          },
                        ),
                      ),
                    if (myMember.value.statusRejected ||
                        myMember.value.statusBlack)
                      FormBox(
                        title: myMember.value.statusRejected
                            ? tr('community:create_lbl_reject')
                            : tr('community:create_lbl_black'),
                        type: FormBoxType.child,
                        child: CSContainer(
                          margin: EdgeInsets.zero,
                          child: Text(
                            myMember.value.statusRejected
                                ? myMember.value.rejectedMessage
                                : myMember.value.blackMessage,
                            style: context.textBody(),
                          ),
                        ),
                      ),
                    CSButton(
                      label: tr(myMember.value.statusTransKey),
                      disabled: !myMember.value.canSubmit,
                      margin: context.edgeTop20,
                      onPressed: myMember.value.canSubmit
                          ? () {
                              if (myMember.value.statusRejected) {
                                myMember.value = CommunityMember();
                              } else {
                                handleSubmit(viewModel);
                              }
                            }
                          : null,
                    ),
                    SizedBox(height: context.edgeSizeDouble),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
