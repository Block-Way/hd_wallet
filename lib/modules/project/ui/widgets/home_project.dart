part of project_ui_module;

class HomeProject extends HookWidget {
  const HomeProject({this.hasWallet});
  final bool hasWallet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: context.edgeSize,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: context.edgeSize,
        vertical: 10,
      ),
      decoration: context.boxDecoration(
        color: context.whiteColor,
        radius: 10,
      ),
      child: Row(
        children: [
          tableItem(
            context,
            image: 'assets/images/project_list.png',
            name: tr('project:home_btn_list'),
            label: tr('project:home_lbl_list'),
            onPress: () {
              ProjectListPage.open();
            },
          ),
          Container(
            height: 20,
            width: 1,
            color: Color(0xFFf2f2f2),
            margin: context.edgeHorizontal10,
          ),
          tableItem(
            context,
            image: 'assets/images/project_apply.png',
            name: tr('project:home_btn_create'),
            label: tr('project:home_lbl_create'),
            onPress: () {
              if (hasWallet) {
                ProjectApplyRulePage.open();
              } else {
                Toast.show(tr('wallet:msg_create_wallet_need'));
                AppNavigator.gotoTabBarPage(AppTabBarPages.wallet);
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget tableItem(
  BuildContext context, {
  String image,
  String name,
  String label,
  Function onPress,
}) {
  final width = (context.mediaWidth - 71) / 2;
  return InkWell(
    onTap: () {
      onPress();
    },
    child: SizedBox(
      width: width,
      child: Row(
        children: [
          Transform.translate(
            offset: Offset(0, 2),
            child: Image.asset(
              image,
              width: 23,
              height: 23,
            ),
          ),
          SizedBox(
            width: 9,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr(name),
                style: context.textBody(bold: true),
              ),
              Container(
                padding: context.edgeTop5,
                width: context.mediaWidth * 0.3,
                child: Text(
                  tr(label),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textSecondary(),
                  softWrap: false,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
