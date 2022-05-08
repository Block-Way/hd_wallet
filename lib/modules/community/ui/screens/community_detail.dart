part of community_ui_module;

class _GetCommunityListParams {
  _GetCommunityListParams(this.searchName);
  @override
  String toString() {
    return '_GetCommunityListParams(searchName: $searchName)';
  }

  final String searchName;
}

class CommunityDetailPage extends HookWidget {
  const CommunityDetailPage(this.info);
  final CommunityInfo info;

  static const routeName = '/community/detail';

  static void open(CommunityInfo info) {
    AppNavigator.push(routeName, params: info);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      CommunityDetailPage(settings.arguments as CommunityInfo),
    );
  }

  Widget buildCommunityInfo(
    BuildContext context,
    CommunityInfo info,
  ) {
    return CSContainer(
      child: Column(
        children: [
          SizedBox(height: context.edgeSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SelectableText(
                  info.name ?? '',
                  style: context.textMedium(bold: true, lineHeight: 1.5),
                ),
              ),
              SizedBox(width: context.edgeSize),
              CSImage(
                info.imageUrl,
                fallbackUrl: 'assets/images/app_default_logo.png',
                width: context.mediaWidth * 0.4,
                height: context.mediaWidth * 0.4 / 144 * 88,
                fit: BoxFit.contain,
                backgroundColor: Colors.transparent,
                placeholderUseLoading: false,
              ),
            ],
          ),
          SizedBox(height: context.edgeSize),
          CSContainer(
            secondary: true,
            height: 144,
            margin: context.edgeTop,
            child: Scrollbar(
              thickness: 2.0,
              radius: Radius.circular(20.0),
              child: SingleChildScrollView(
                child: SelectableLinkify(
                  onOpen: (link) => WebViewPage.open(link.url),
                  text: info.describe ?? '',
                  style: context.textSecondary(
                    color: context.bodyColor,
                    lineHeight: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchInput(
    BuildContext context,
    CommunityDetailVM viewModel,
    StreamController<CSListViewParams<_GetCommunityListParams>> request,
    CommunityInfo info,
    ValueNotifier<String> searchText,
  ) {
    return Row(
      children: [
        SizedBox(
          width: info.isTeamList == true
              ? context.mediaWidth * 0.85
              : context.mediaWidth,
          child: CSSearchInput(
            height: 44,
            radius: 22,
            value: searchText.value,
            hintText: info.isTeamList
                ? tr('community:team_list_hint_search')
                : tr('community:member_list_hint_search'),
            hintStyle: context.textSmall(),
            onChanged: (text) {
              searchText.value = text;
            },
            onSubmitted: (text) {
              viewModel.clearCommunityList(isTeamList: info.isTeamList);
              request.add(
                CSListViewParams.withParams(_GetCommunityListParams(text)),
              );
            },
            onClear: () {
              searchText.value = '';
              viewModel.clearCommunityList(isTeamList: info.isTeamList);
              request.add(
                CSListViewParams.withParams(_GetCommunityListParams('')),
              );
            },
          ),
        ),
        if (info.isTeamList == true)
          CSButtonIcon(
            padding: EdgeInsets.zero,
            background: context.whiteColor,
            containerSize: 44,
            size: 21,
            borderRadius: 44,
            onPressed: () {
              CommunityBlacklistPage.open(info);
            },
            icon: CSIcons.Blacklist,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = useBehaviorStreamController<
        CSListViewParams<_GetCommunityListParams>>();
    final searchText = useState('');
    // 当前分类 是否创建 或者 申请 加入过
    final hasHistory = useState<bool>(null);

    final actionBtText = hasHistory.value == true
        ? tr('community:create_btn_my_team')
        : info.canCreate
            ? tr('community:detail_btn_create')
            : tr('community:detail_btn_join');

    void loadDetail(CommunityDetailVM viewModel) {
      request.add(CSListViewParams.withParams(_GetCommunityListParams('')));
      // 获取我创建的社区信息
      if (info.canCreate || info.canJoin) {
        final type = info.isTeamList ? info.type.toString() : info.id;
        viewModel
            .getHasHistory(isTeam: info.isTeamList, type: type)
            .then((value) {
          hasHistory.value = value;
        }).catchError((error) {
          hasHistory.value = false;
          Toast.showError(error);
        });
      } else {
        hasHistory.value = false;
      }
    }

    void handleJoin(CommunityDetailVM viewModel) {
      CommunityJoinProcess.checkCanJoin(
          context: context,
          info: info,
          onGetTeamInfo: viewModel.getCommunityTeam,
          onCheckOnChain: viewModel.checkOnChainData,
          onJoinResult: (value) {
            if (value == true) {
              loadDetail(viewModel);
            }
          }).catchError((error) {
        Toast.showError(error);
      });
    }

    return CSScaffold(
      title: info.name,
      actions: [
        StoreConnector<AppState, CommunityDetailVM>(
          distinct: true,
          converter: CommunityDetailVM.fromStore,
          builder: (context, viewModel) => hasHistory.value == null
              ? SizedBox()
              : CSButton(
                  label: actionBtText,
                  margin:
                      context.edgeVertical5.copyWith(right: context.edgeSize),
                  textStyle: context.textSecondary(
                    color: context.bodyColor,
                    bold: true,
                  ),
                  autoWidth: true,
                  padding: context.edgeHorizontal,
                  borderRadius: 4,
                  onPressed: () {
                    info.canCreate
                        ? CommunityCreatePage.open(info).then((value) {
                            // 刷新数据
                            if (value == true) {
                              loadDetail(viewModel);
                            }
                          })
                        : handleJoin(viewModel);
                  },
                ),
        ),
      ],
      child: StoreConnector<AppState, CommunityDetailVM>(
        distinct: true,
        converter: CommunityDetailVM.fromStore,
        onInitialBuild: (viewModel) {
          viewModel.clearCommunityList(isTeamList: info.isTeamList);
          loadDetail(viewModel);
        },
        builder: (context, viewModel) =>
            CSListViewStream<_GetCommunityListParams>(
          emptyLabel: info.isTeamList
              ? tr('community:team_list_lbl_empty')
              : tr('community:member_list_lbl_empty'),
          emptyImageUrl: 'assets/images/empty_record.png',
          requestStream: request,
          margin: context.edgeAll.copyWith(
            top: info.isTeamList ? context.edgeSize : 0,
          ),
          decoration: context.boxDecoration(),
          slivers: [
            SliverToBoxAdapter(
              child: buildCommunityInfo(
                context,
                info,
              ),
            ),
            if (info.isTeamList)
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverHeaderContainer(
                  height: 44,
                  child: buildSearchInput(
                    context,
                    viewModel,
                    request,
                    info,
                    searchText,
                  ),
                ),
              ),
          ],
          onLoadData: (params) {
            return viewModel.loadData(
              isRefresh: params.isRefresh,
              skip: params.skip,
              searchName: params.params.searchName,
              type: info.isTeamList ? info.type.toString() : info.id.toString(),
              isTeamList: info.isTeamList,
            );
          },
          itemCount: info.isTeamList
              ? viewModel.communityTeamList.length
              : viewModel.communityMemberList.length,
          itemBuilder: (context, index) {
            return info.isTeamList
                ? CommunityListItem(
                    order: viewModel.communityTeamList[index].order,
                    name: viewModel.communityTeamList[index].name,
                    displayIcon: viewModel.communityTeamList[index].displayIcon,
                    hasWallet: viewModel.hasWallet,
                    isMine: viewModel.communityTeamList[index].isMine,
                    isSuccess: viewModel.communityTeamList[index].statusSuccess,
                    index: index,
                    onPress: () {
                      CommunityTeamPage.open(
                        info,
                        viewModel.communityTeamList[index],
                      );
                    },
                  )
                : CommunityListItem(
                    order: viewModel.communityMemberList[index].order,
                    name: viewModel.communityMemberList[index].info.name,
                    displayIcon:
                        viewModel.communityMemberList[index].info.displayIcon,
                    isMine: viewModel.communityMemberList[index].isMine,
                    hasWallet: viewModel.hasWallet,
                    index: index,
                    onPress: () {
                      CommunityMemberPage.open(
                        viewModel.communityMemberList[index],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
