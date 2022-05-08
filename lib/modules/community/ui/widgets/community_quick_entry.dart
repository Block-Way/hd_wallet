part of community_ui_module;

class CommunityQuickEntry extends StatelessWidget {
  const CommunityQuickEntry({
    Key key,
    this.hasWallet,
    this.communityConfig,
  }) : super(key: key);

  final bool hasWallet;
  final CommunityConfig communityConfig;

  @override
  Widget build(BuildContext context) {
    final currentLangCode = context.locale.languageCode;
    final isZh = currentLangCode == 'zh';
    final items = communityConfig != null
        ? communityConfig.types
            .where((info) => info.homeQuickEntry != 'off')
            .toList()
        : <CommunityInfo>[];
    final firstLine =
        isZh ? items : items.sublist(0, items.length > 3 ? 3 : items.length);
    final secondLine = isZh
        ? <CommunityInfo>[]
        : items.length > 3
            ? items.sublist(3)
            : <CommunityInfo>[];

    void handleJoin(CommunityTeamVM viewModel, CommunityInfo info) {
      CommunityJoinProcess.checkCanJoin(
        context: context,
        info: info,
        onGetTeamInfo: viewModel.getCommunityTeam,
        onCheckOnChain: viewModel.checkOnChainData,
      ).catchError((error) {
        Toast.showError(error);
      });
    }

    void openNewPage(CommunityTeamVM viewModel, CommunityInfo info) {
      if (hasWallet) {
        if (info == null) {
          return;
        }

        AnalyticsReport().reportLog('Community_Quick', {
          'type': info.type,
          'name': info.name,
        });

        if (info.homeQuickEntry == 'new') {
          CommunityCreatePage.open(info);
        } else if (info.homeQuickEntry == 'join_apply') {
          handleJoin(viewModel, info);
        }
      } else {
        Toast.show(tr('wallet:msg_create_wallet_need'));
        AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
      }
    }

    return StoreConnector<AppState, CommunityTeamVM>(
      distinct: true,
      converter: CommunityTeamVM.fromStore,
      builder: (context, viewModel) => Column(
        children: [
          if (firstLine.isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...firstLine.map(
                    (info) => buildQuickEntry(
                      context,
                      name: tr(CommunityUtils.getEntryTransKey(info.teamType)),
                      onPress: () {
                        openNewPage(viewModel, info);
                      },
                      icon: getIcon(info.teamType),
                    ),
                  ),
                  SizedBox(width: context.edgeSize),
                ],
              ),
            ),
          if (secondLine.isNotEmpty)
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...secondLine.map(
                    (info) => buildQuickEntry(
                      context,
                      name: tr(CommunityUtils.getEntryTransKey(info.teamType)),
                      icon: getIcon(info.teamType),
                      onPress: () {
                        openNewPage(viewModel, info);
                      },
                    ),
                  ),
                  SizedBox(width: context.edgeSize),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildQuickEntry(
  BuildContext context, {
  String name,
  void Function() onPress,
  IconData icon,
}) {
  return CSContainer(
    onTap: onPress,
    height: 48,
    width: null,
    margin: context.edgeAll.copyWith(
      right: 0,
      top: 0,
    ),
    padding: context.edgeAll8,
    child: Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: context.bodyColor,
        ),
        Padding(
          padding: EdgeInsets.only(left: 6),
          child: Text(
            name,
            style: context.textSecondary(color: context.bodyColor),
          ),
        ),
      ],
    ),
  );
}

IconData getIcon(CommunityTypes type) {
  switch (type) {
    case CommunityTypes.market:
      return CSIcons.Market;
    case CommunityTypes.media:
      return CSIcons.Media;
    case CommunityTypes.develop:
      return CSIcons.Technical;
    case CommunityTypes.investor:
      return CSIcons.User;
    case CommunityTypes.operations:
      return CSIcons.Capital;
    default:
      return CSIcons.Mark;
  }
}
