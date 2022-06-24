part of community_ui_module;

class CommunityTypeCard extends HookWidget {
  const CommunityTypeCard({
    required this.config,
    required this.configState,
    required this.onPressed,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  final CommunityConfig config;
  final int configState;
  final Function(CommunityInfo item) onPressed;
  final Function() onRefresh;

  Widget buildTableCard({
    BuildContext? context,
    List<CommunityInfo>? typeList,
    Function(CommunityInfo item)? onPress,
  }) {
    String imageUrl(CommunityTypes type) {
      switch (type) {
        case CommunityTypes.market:
          return 'assets/images/community_menu_market.png';

        case CommunityTypes.develop:
          return 'assets/images/community_menu_develop.png';

        case CommunityTypes.media:
          return 'assets/images/community_menu_media.png';

        case CommunityTypes.operations:
          return 'assets/images/community_menu_operations.png';

        case CommunityTypes.investor:
          return 'assets/images/community_menu_investor.png';

        case CommunityTypes.education:
          return 'assets/images/community_menu_education.png';
        case CommunityTypes.sugarDevelop:
          return 'assets/images/community_menu_sugar.png';
        default:
          return 'assets/images/community_menu_develop.png';
      }
    }

    final width = (context!.mediaWidth - 48) / 4;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...typeList!.map(
          (item) => InkWell(
            onTap: () {
              AnalyticsReport().reportLog('Community_Card', {
                'type': item.type,
                'name': item.name,
              });
              onPress?.call(item);
            },
            child: SizedBox(
              width: width,
              child: Column(
                children: [
                  CSImage(
                    imageUrl(item.teamType),
                    width: 40,
                    height: 40,
                    radius: 40,
                    backgroundColor: Colors.transparent,
                  ),
                  Padding(
                    padding: context.edgeTop8,
                    child: Text(
                      item.name ?? '',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textSecondary(
                        color: context.bodyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildContent(BuildContext context) {
    if (configState == ConfigState.loading.index) {
      return Center(
        child: CSProgressIndicator(
          size: 40,
          strokeWidth: 1.5,
          color: context.primaryColor,
        ),
      );
    }

    if (configState == ConfigState.error.index) {
      return Center(
        child: CSButton(
          label: tr('global:btn_refresh'),
          onPressed: () {
            onRefresh();
          },
          cmpLeft: Padding(
            padding: context.edgeRight5,
            child: Icon(
              CSIcons.Refresh,
              size: 14,
              color: context.bodyColor,
            ),
          ),
        ),
      );
    }

    final list = config.types?.toList() ?? [];
    list.retainWhere((x) => config.homeList!.contains(x.type));
    final swiperNumber = (list.length / 4).ceil();

    return Swiper(
      itemBuilder: (context, index) => buildTableCard(
        context: context,
        typeList: index + 1 < swiperNumber
            ? list.sublist(index * 4, (index + 1) * 4)
            : list.sublist((swiperNumber - 1) * 4, list.length),
        onPress: onPressed,
      ),
      loop: false,
      itemCount: swiperNumber,
      pagination: SwiperCSPagination(
        margin: EdgeInsets.zero,
        builder: DotBuilder(
          color: Color(0xFFe5e5e5),
          activeColor: context.primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      height: 123,
      child: buildContent(context),
    );
  }
}
