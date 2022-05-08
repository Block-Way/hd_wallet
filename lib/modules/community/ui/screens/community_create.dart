part of community_ui_module;

class CommunityCreatePage extends HookWidget {
  CommunityCreatePage(this.typeInfo);
  final CommunityInfo typeInfo;

  static const routeName = '/community/create';

  static Future<bool> open(CommunityInfo type) {
    return AppNavigator.push<bool>(routeName, params: type);
  }

  static Route<bool> route(RouteSettings settings) {
    return DefaultTransition<bool>(
      settings,
      CommunityCreatePage(settings.arguments as CommunityInfo),
    );
  }

  final formKey = GlobalKey<FormState>();

  void showConfirmDataTip(
    BuildContext context, {
    void Function() onConfirm,
  }) {
    if (onConfirm != null) {
      showConfirmAgreementDialog(context, onConfirm);
    } else {
      showAlertDialog(
        context,
        content: tr('community:create_msg_data_tip'),
      );
    }
  }

  void handleSelectCoin(
    BuildContext context,
    List<AssetCoin> list,
    ValueNotifier<AssetCoin> selectCoin,
  ) {
    final options = list
        .map(
          (e) => CSOptionsItem<AssetCoin>(
              label: e.symbol,
              value: e,
              color: selectCoin.value != null &&
                      selectCoin.value.chain == e.chain &&
                      selectCoin.value.symbol == e.symbol
                  ? context.primaryColor
                  : null),
        )
        .toList();
    showOptionsDialog<AssetCoin>(
      context,
      options: options,
      onSelected: (coin) {
        selectCoin.value = coin;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final myTeam = useState<CommunityTeam>(CommunityTeam());
    final autovalidate = useState(false);
    final isLogoUploading = useValueNotifier(false);
    final isGroupUploading = useValueNotifier(false);
    final type = typeInfo.teamType;

    final selectCoin = useState<AssetCoin>(null);

    final name = useTextEditingController(text: '');
    final desc = useTextEditingController(text: '');
    final telegram = useTextEditingController(text: '');
    final logo = useTextEditingController(text: '');
    final images = useMemoized(() => <String>[]);

    final trBase = CommunityUtils.getCreateTransKey(type);
    final visibleItems = TeamCreateParams.getVisible(type);

    final lblTitle = tr('${trBase}_title');

    final nameLbl = tr('${trBase}_name_lbl');
    final nameHint = tr('${trBase}_name_hint');
    final nameReq = tr('${trBase}_name_req');

    final descLbl = tr('${trBase}_desc_lbl');
    final descHint = tr('${trBase}_desc_hint');
    final descReq = tr('${trBase}_desc_req');

    final ecologyLbl = tr('${trBase}_ecology_lbl');

    final telegramLbl = tr('${trBase}_telegram_lbl');
    final telegramHint = tr('${trBase}_telegram_hint');
    final telegramReq = tr('${trBase}_telegram_req');

    final logoLbl = tr('${trBase}_upload_logo_img_lbl');

    final canEdit = myTeam.value.statusDefault;

    void handleSubmit(CommunityCreateVM viewModel) {
      if (!autovalidate.value) {
        autovalidate.value = true;
      }
      if (formKey.currentState.validate() != true) {
        return;
      }

      final params = TeamCreateParams.toApiParams(
        type: typeInfo,
        name: name.text,
        desc: desc.text,
        fork: selectCoin.value?.contract,
        telegram: telegram.text,
        logo: logo.text,
        images: images,
      );

      final errorKey = params.isValid();
      if (errorKey != null) {
        return Toast.show(tr('community:error_msg_$errorKey'));
      }

      showConfirmDataTip(
        context,
        onConfirm: () {
          AnalyticsReport().reportLog('Community_Create', {
            'type': typeInfo.type,
            'name': typeInfo.name,
          });
          LoadingDialog.show(context);
          viewModel.createCommunity(params).then((_) {
            LoadingDialog.dismiss(context);
            AppNavigator.popWithResult(true);
            Toast.show(tr('community:create_msg_success'));
          }).catchError((error) {
            LoadingDialog.dismiss(context);
            Toast.showError(error);
          });
        },
      );
    }

    final imgItemWidth = (context.mediaWidth - context.edgeSize * 6) / 3;

    return WillPopScope(
      onWillPop: () async {
        if (isGroupUploading.value == true || isLogoUploading.value == true) {
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
              child: StoreConnector<AppState, CommunityCreateVM>(
                distinct: true,
                converter: CommunityCreateVM.fromStore,
                onInitialBuild: (viewModel) {
                  if (viewModel.walletId == null ||
                      viewModel.walletId.isEmpty) {
                    AppNavigator.gotoTabBar();
                    AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
                    Toast.show(tr('wallet:msg_create_wallet_need'));
                    return;
                  }
                  if (type == null) {
                    AppNavigator.goBack();
                    return;
                  }

                  if (viewModel.coinList.isEmpty == true) {
                    return;
                  }
                  LoadingDialog.show(context);
                  viewModel.getMyTeam(typeInfo.type).then((teamInfo) {
                    LoadingDialog.dismiss(context);
                    // 创建过
                    if (teamInfo != null && teamInfo.id != null) {
                      myTeam.value = teamInfo;
                      name.text = teamInfo.name;
                      desc.text = teamInfo.describe;
                      telegram.text = teamInfo.options.telegramAccount;

                      // 根据创建历史的字段 找到之前选中的币种
                      final coin = viewModel.coinList.firstWhere(
                          (e) =>
                              e.chain == teamInfo.chain &&
                              e.symbol == teamInfo.symbol,
                          orElse: () => viewModel.coinList.first);
                      selectCoin.value = coin;
                    } else {
                      // 没有创建过
                      showConfirmDataTip(context);
                      selectCoin.value = viewModel.coinList?.first;
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
                    if (visibleItems.contains('coin'))
                      AssetCoinBox(
                        title: ecologyLbl,
                        coinInfo: selectCoin.value,
                        onPress: canEdit
                            ? () {
                                handleSelectCoin(
                                  context,
                                  viewModel.coinList.toList(),
                                  selectCoin,
                                );
                              }
                            : null,
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
                          uploadType: 'hd_team_icon',
                          onRemove: () {
                            logo.text = '';
                          },
                          onUploadSuccess: (path, _) {
                            logo.text = path;
                          },
                          onUploadChange: (uploading) {
                            isLogoUploading.value = uploading;
                          },
                        ),
                      ),
                    if (visibleItems.contains('images') && canEdit)
                      FormBox(
                        title: tr('community:upload_info_img_lbl'),
                        type: FormBoxType.child,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: UploadButtonGroup(
                            itemSize: imgItemWidth,
                            maxImages: 5,
                            signature: viewModel.walletId,
                            uploadType: 'business_license',
                            onChanges: (paths) {
                              images.clear();
                              images.addAll(paths);
                            },
                            onUploadChange: (uploading) {
                              isGroupUploading.value = uploading;
                            },
                          ),
                        ),
                      ),
                    if (myTeam.value.statusRejected || myTeam.value.statusBlack)
                      FormBox(
                        title: myTeam.value.statusRejected
                            ? tr('community:create_lbl_reject')
                            : tr('community:create_lbl_black'),
                        type: FormBoxType.child,
                        child: CSContainer(
                          margin: EdgeInsets.zero,
                          child: Text(
                            myTeam.value.statusRejected
                                ? myTeam.value.rejectedMessage
                                : myTeam.value.blackMessage,
                            style: context.textBody(),
                          ),
                        ),
                      ),
                    CSButton(
                      label: tr(myTeam.value.statusTransKey),
                      disabled: !myTeam.value.canSubmit,
                      margin: context.edgeTop20,
                      onPressed: myTeam.value.canSubmit
                          ? () {
                              if (myTeam.value.statusRejected) {
                                myTeam.value = CommunityTeam();
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
