part of common_ui_module;

class HelpCenterGroup {
  HelpCenterGroup({
    required this.icon,
    required this.title,
    required this.links,
  });

  final String title;
  final IconData icon;
  final List<HelpCenterLink> links;
}

class HelpCenterLink {
  HelpCenterLink({
    required this.title,
    required this.url,
  });
  final String title;
  final String url;
}

class HelpCenterPage extends HookWidget {
  const HelpCenterPage();
  static const routeName = '/common/help';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      HelpCenterPage(),
    );
  }

  Widget buildGroup(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Container(
      width: context.mediaWidth * 0.32,
      padding: context.edgeAll,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: context.bodyColor,
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: context.textBody(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(
    BuildContext context, {
    required String question,
    required String url,
    required bool hideBorder,
  }) {
    return CSContainer(
      padding: context.edgeAll.copyWith(top: 20, bottom: 20),
      margin: EdgeInsets.zero,
      radius: 0,
      onTap: () {
        WebViewPage.open(url, question);
      },
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: context.greyColor),
          top: hideBorder != true
              ? BorderSide(color: context.greyColor)
              : BorderSide.none,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 7),
            child: CSBadge(
              color: context.primaryColor,
              size: 8,
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              question,
              style: context.textSecondary(
                color: context.bodyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final links = [
      HelpCenterGroup(
        icon: CSIcons.Help,
        title: tr('user:help_quick_title'),
        links: [
          HelpCenterLink(
            title: tr('user:help_quick_question_1'),
            url: tr('user:help_quick_question_1_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_quick_question_2'),
            url: tr('user:help_quick_question_2_url'),
          ),
        ],
      ),
      HelpCenterGroup(
        icon: CSIcons.Bookmark,
        title: tr('user:help_manual_title'),
        links: [
          HelpCenterLink(
            title: tr('user:help_manual_question_1'),
            url: tr('user:help_manual_question_1_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_manual_question_2'),
            url: tr('user:help_manual_question_2_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_manual_question_3'),
            url: tr('user:help_manual_question_3_url'),
          ),
        ],
      ),
      HelpCenterGroup(
        icon: CSIcons.Hand,
        title: tr('user:help_operation_title'),
        links: [
          HelpCenterLink(
            title: tr('user:help_operation_question_1'),
            url: tr('user:help_operation_question_1_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_operation_question_2'),
            url: tr('user:help_operation_question_2_url'),
          ),
        ],
      ),
      HelpCenterGroup(
        icon: CSIcons.Sugar,
        title: tr('user:help_asset_title'),
        links: [
          HelpCenterLink(
            title: tr('user:help_asset_question_1'),
            url: tr('user:help_asset_question_1_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_asset_question_2'),
            url: tr('user:help_asset_question_2_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_asset_question_3'),
            url: tr('user:help_asset_question_3_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_asset_question_4'),
            url: tr('user:help_asset_question_4_url'),
          ),
        ],
      ),
      HelpCenterGroup(
        icon: CSIcons.HelpDeposit,
        title: tr('user:help_transaction_title'),
        links: [
          HelpCenterLink(
            title: tr('user:help_transaction_question_1'),
            url: tr('user:help_transaction_question_1_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_transaction_question_2'),
            url: tr('user:help_transaction_question_2_url'),
          ),
          HelpCenterLink(
            title: tr('user:help_transaction_question_3'),
            url: tr('user:help_transaction_question_3_url'),
          ),
        ],
      ),
    ];

    final searchController = useTextEditingController(text: '');
    void handleSearch() {
      print('sjisoifjas');
    }

    return Container(child: CSTabBar());
    // return CSScaffold(
    //   hideLeading: true,
    //   titleCenter: false,
    //   title: tr('user:help_title'),
    //   headerBgColor: context.mainColor,
    //   backgroundColor: Colors.white,
    //   titleStyle: context.textHuge(fontWeight: FontWeight.w700, color: context.bgPrimaryColor),
    //   child: Column(
    //     children: [
    //       // Container(
    //       //   color: context.mainColor,
    //       //   child: Transform.translate(
    //       //     offset: Offset(0, context.edgeSize),
    //       //     child: Container(
    //       //       color: context.mainColor,
    //       //       padding: context.edgeAll.copyWith(top: 0),
    //       //       child: Row(
    //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //         children: [
    //       //           Text(
    //       //             tr('user:help_title'),
    //       //             style: context.textHuge(bold: true, color: context.iconColor),
    //       //           ),
    //       //           CSImage(
    //       //             'assets/images/help_bg.png',
    //       //             backgroundColor: Colors.transparent,
    //       //           ),
    //       //         ],
    //       //       ),
    //       //     ),
    //       //   ),
    //       // ),
    //
    //       // SizedBox(height: 32),
    //       // CSSearchInput(
    //       //   controller: searchController,
    //       //   autofocus: false,
    //       //   radius: 25,
    //       //   maxLength: 256,
    //       //   margin: context.edgeHorizontal,
    //       //   hintText: 'Please enter your problem',
    //       //   showSearchIcon: false,
    //       //   onChanged: (_) {},
    //       //   hintStyle: context.textSmall(),
    //       //   background: context.mainColor,
    //       //   cmpRight: CSButtonIcon(
    //       //     icon: CSIcons.Search,
    //       //       borderRadius: 40.0,
    //       //     background: context.mainColor,
    //       //     size: 16
    //       //   ),
    //       // ),
    //       // SizedBox(height: 32),
    //       // Container(
    //       //     child: CSTabBar()
    //       // ),
    //       // Expanded(
    //       //   child: Container(
    //       //     decoration: context.boxDecorationOnlyTop(),
    //       //     child: ListView(
    //       //       shrinkWrap: true,
    //       //       children: links
    //       //           .asMap()
    //       //           .entries
    //       //           .map(
    //       //             (group) => Column(
    //       //               children: [
    //       //                 Row(
    //       //                   children: [
    //       //                     buildGroup(
    //       //                       context,
    //       //                       icon: group.value.icon,
    //       //                       title: group.value.title,
    //       //                     ),
    //       //                     Expanded(
    //       //                       child: Column(
    //       //                         children: group.value.links
    //       //                             .asMap()
    //       //                             .entries
    //       //                             .map(
    //       //                               (question) => buildQuestion(
    //       //                                 context,
    //       //                                 question: question.value.title,
    //       //                                 url: question.value.url,
    //       //                                 hideBorder: question.key == 0,
    //       //                               ),
    //       //                             )
    //       //                             .toList(),
    //       //                       ),
    //       //                     ),
    //       //                   ],
    //       //                 ),
    //       //                 if (group.key != links.length - 1)
    //       //                   Divider(
    //       //                     color: context.greyColor,
    //       //                     height: 1,
    //       //                     thickness: 1,
    //       //                   ),
    //       //               ],
    //       //             ),
    //       //           )
    //       //           .toList(),
    //       //     ),
    //       //   ),
    //       // ),
    //       // DividerShadow(),
    //       // CSButton(
    //       //   margin: context.edgeVertical,
    //       //   label: tr('user:help_btn_more'),
    //       //     textColor: context.iconColor,
    //       //   onPressed: () {
    //       //     WebViewPage.open(tr('user:help_btn_more_url'));
    //       //   },
    //       // ),
    //     ],
    //   ),
    // );
  }
}
