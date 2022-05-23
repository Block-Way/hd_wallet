part of community_ui_module;

class CommunityMemberPage extends HookWidget {
  const CommunityMemberPage(this.item);
  final CommunityMember item;

  static const routeName = '/community/member';

  static void open(CommunityMember item) {
    AppNavigator.push(routeName, params: item);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      CommunityMemberPage(settings.arguments as CommunityMember),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        'value': item.info.describe,
      },
      {
        'label': tr('community:detail_lbl_address_mine'),
        'value': item.bbcAddress,
      },
      {
        'label': tr('community:join_sugar_develop_telegram_lbl'),
        'value': item.info.telegramAccount,
      },
      if (item.statusRejected && item.rejectedMessage.isNotEmpty)
        {
          'label': tr('community:create_lbl_reject'),
          'value': item.rejectedMessage,
        },
      if (item.statusBlack && item.blackMessage.isNotEmpty)
        {
          'label': tr('community:create_lbl_black'),
          'value': item.blackMessage,
        }
    ];
    return CSScaffold(
      title: tr('community:member_detail_title'),
      scrollable: true,
      child: CSContainer(
        child: Column(
          children: [
            SizedBox(height: context.edgeSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SelectableText(
                    item.info.name ?? '',
                    style: context.textMedium(bold: true, lineHeight: 1.5),
                  ),
                ),
                SizedBox(width: context.edgeSize),
                CSImage(
                  item.info.displayIcon,
                  fallbackUrl: 'assets/images/app_default_logo.png',
                  width: 80,
                  height: 80,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            SizedBox(height: context.edgeSize),
            ...list.map(
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
                      style: context.textSecondary(
                        bold: true,
                        color: context.bodyColor,
                        lineHeight: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
