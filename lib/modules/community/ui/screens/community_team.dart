part of community_ui_module;

class CommunityTeamPage extends HookWidget {
  const CommunityTeamPage(
    this.info,
    this.team,
  );
  final CommunityInfo info;
  final CommunityTeam team;

  static const routeName = '/community/team';

  static void open(CommunityInfo info, CommunityTeam team) {
    AppNavigator.push(routeName, params: MapEntry(info, team));
  }

  static Route<dynamic> route(RouteSettings settings) {
    final item = settings.arguments as MapEntry<CommunityInfo, CommunityTeam>;
    return DefaultTransition(
      settings,
      CommunityTeamPage(item.key, item.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        'value': team.describe,
      },
      {
        'label': tr('community:detail_lbl_leader'),
        'value': team.owner,
      },
      // Is not onChain, we can show telegram
      if (!info.joinIsOnChain)
        {
          'label': tr('community:join_sugar_develop_telegram_lbl'),
          'value': team.options.telegramAccount,
        },
      {
        'label': tr('community:detail_lbl_address'),
        'value': team.options.addressCount,
      },
      if (team.displayAverageSymbol.isNotEmpty)
        {
          'label': tr(
            'community:detail_lbl_average',
            namedArgs: {'symbol': team.displayAverageSymbol},
          ),
          'value': team.displayAverageBalance,
        },
      if (team.statusRejected && team.rejectedMessage.isNotEmpty)
        {
          'label': tr('community:create_lbl_reject'),
          'value': team.rejectedMessage,
        },
      if (team.statusBlack && team.blackMessage.isNotEmpty)
        {
          'label': tr('community:create_lbl_black'),
          'value': team.blackMessage,
        }
    ];

    void handleJoin(CommunityTeamVM viewModel) {
      CommunityJoinProcess.checkCanJoin(
        context: context,
        info: info,
        team: team,
        onGetTeamInfo: viewModel.getCommunityTeam,
        onCheckOnChain: viewModel.checkOnChainData,
      ).catchError((error) {
        Toast.showError(error);
      });
    }

    return CSScaffold(
      title: tr('community:team_detail_title'),
      scrollable: true,
      child: Column(
        children: [
          CSContainer(
            child: Column(
              children: [
                SizedBox(height: context.edgeSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SelectableText(
                        team.name,
                        style: context.textMedium(bold: true, lineHeight: 1.5),
                      ),
                    ),
                    SizedBox(width: context.edgeSize),
                    CSImage(
                      team.displayIcon,
                      fallbackUrl: 'assets/images/app_default_logo.png',
                      width: 80,
                      height: 80,
                      radius: 80,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                SizedBox(height: context.edgeSize),
                ...list
                    .map(
                      (item) => CSContainer(
                        margin: context.edgeTop,
                        secondary: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item['label'] != null)
                              Padding(
                                padding: context.edgeBottom5,
                                child: Text(
                                  item['label'].toString(),
                                  style: context.textSecondary(bold: true),
                                ),
                              )
                            else
                              Container(),
                            SelectableText(
                              item['value'].toString(),
                              autofocus: true,
                              style: context.textSecondary(
                                bold: true,
                                color: context.bodyColor,
                                lineHeight: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          if (team.black != true && team.isMine == null)
            StoreConnector<AppState, CommunityTeamVM>(
              distinct: true,
              converter: CommunityTeamVM.fromStore,
              builder: (context, viewModel) => CSButton(
                label: tr('community:detail_btn_join'),
                margin: EdgeInsets.only(top: 60, bottom: 30),
                onPressed: () {
                  handleJoin(viewModel);
                },
              ),
            ),
        ],
      ),
    );
  }
}
