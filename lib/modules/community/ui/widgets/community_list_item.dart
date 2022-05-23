part of community_ui_module;

class CommunityListItem extends StatelessWidget {
  const CommunityListItem({
    @required this.name,
    @required this.onPress,
    @required this.displayIcon,
    Key key,
    this.isMine,
    this.hasWallet,
    this.isBlacklist = false,
    this.isSuccess = false,
    this.order,
    this.index,
  }) : super(key: key);

  final Function() onPress;
  final int order;
  final bool isMine;
  final bool hasWallet;
  final bool isBlacklist;
  final bool isSuccess;
  final String displayIcon;
  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    Color iconColor(int index) {
      switch (index) {
        case 1:
          return Color(0xFFffb806);
        case 2:
          return Color(0xFFa7bae9);
        case 3:
          return Color(0xFFb67742);
        default:
          return context.bodyColor;
      }
    }

    return Column(
      children: [
        CSContainer(
            height: 42,
            padding: EdgeInsets.zero,
            margin: context.edgeAll.copyWith(top: index == 0 ? 12 : 0),
            decoration: context.boxDecoration(
              color: !isBlacklist
                  ? isMine == true
                      ? Color(0xFFFFF9D7)
                      : context.bgSecondaryColor
                  : context.bgPrimaryColor,
            ),
            onTap: () {
              if (hasWallet) {
                onPress();
              } else {
                Toast.show(tr('wallet:msg_create_wallet_need'));
                AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
              }
            },
            child: Stack(
              children: [
                Padding(
                  padding: context.edgeHorizontal,
                  child: SizedBox(
                    height: 42,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CSImage(
                          displayIcon,
                          fallbackUrl: 'assets/images/app_default_logo.png',
                          width: 16,
                          height: 16,
                          radius: 16,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textSecondary(
                              color: context.bodyColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        if (order != null &&
                            order < 4 &&
                            order > 0 &&
                            isBlacklist == false &&
                            isSuccess)
                          CSImage(
                            'assets/images/community_list_$order.png',
                            width: 14,
                            height: 14,
                            backgroundColor: Colors.transparent,
                          ),
                        if (order != null && isBlacklist == false && isSuccess)
                          Padding(
                            padding: context.edgeLeft5,
                            child: Text(
                              'No.$order',
                              style: context.textSmall(
                                bold: true,
                                color: iconColor(order),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (isMine == true)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 14,
                      color: context.primaryColor,
                      child: Text(
                        'Mine',
                        textAlign: TextAlign.center,
                        style: context.textSmall(
                          bold: true,
                          color: context.blackColor,
                        ),
                      ),
                    ),
                  ),
              ],
            )),
        if (isMine == true)
          Container(
            margin: context.edgeBottom,
            width: context.mediaWidth,
            height: 0.5,
            color: context.greyColor,
          )
      ],
    );
  }
}
