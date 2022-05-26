part of widgets;

class CSTabBar extends StatefulWidget {
  @override
  _CSTabBarState createState() => _CSTabBarState();
}

class _CSTabBarState extends State<CSTabBar>
  with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  List listDataQuick = [
    {
      "title": "user:help_quick_question_1",
    },
    {
      "title": "user:help_quick_question_2",
    },
    {
      "title": "user:help_quick_question_3",
    }
  ];

  List listDataManual = [
    {
      "title": "user:help_manual_question_1",
    },
    {
      "title": "user:help_manual_question_2",
    },
    {
      "title": "user:help_manual_question_3",
    }
  ];

  List listDataOperation = [
    {
      "title": "user:help_operation_question_1",
    },
    {
      "title": "user:help_operation_question_2",
    }
  ];

  List listDataAsset = [
    {
      "title": "user:help_asset_question_1",
    },
    {
      "title": "user:help_asset_question_2",
    },
    {
      "title": "user:help_asset_question_3",
    },
    {
      'title': 'user:help_asset_question_4'
    }
  ];

  List listDataTransaction = [
    {
      "title": "user:help_transaction_question_1",
    },
    {
      "title": "user:help_transaction_question_2",
    },
    {
      "title": "user:help_transaction_question_3",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: context.cardColor),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          centerTitle: false,
          title: Text(tr('user:help_title'),style: context.textHuge(fontWeight: FontWeight.w700, color: context.bgPrimaryColor)),
        ),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 80,
                automaticallyImplyLeading: false, //hide left back arrow
                bottom: TabBar(controller: _tabController, tabs: [
                  Tab(text: tr('user:help_quick_title')),
                  Tab(text: tr('user:help_manual_title')),
                  Tab(text: tr('user:help_operation_title')),
                  Tab(text: tr('user:help_asset_title')),
                  Tab(text: tr('user:help_transaction_title')),
                ],
                  isScrollable: true,
                  indicatorColor: context.tabBarColor,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 10.0),
//                  labelPadding: EdgeInsets.only(left: 20),
                  labelColor: context.tabBarColor,
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                  unselectedLabelColor: context.tabBarColor,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildListView(listDataQuick),
              _buildListView(listDataManual),
              _buildListView(listDataOperation),
              _buildListView(listDataAsset),
              _buildListView(listDataTransaction),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getQuestionList(List targetList) {
    var tempList = targetList.map((value) {
      return ListTile(
        title: Text(tr(value["title"].toString())),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => {
          doOpenUrl('https://www.google.com')
        },
      );
    });
    return tempList.toList();
  }


  Widget _buildListView(List listView) {
    return ListView(
        // itemCount: 4,
        // separatorBuilder: (BuildContext context, int index) =>
        //     Divider(
        //       color: Colors.grey,
        //       height: 1,
        //     ),
        // itemBuilder: (BuildContext context, int index) {
        //   return ListView(
        //     children: getQuestionList(),
        //   );
        // }
      children: getQuestionList(listView),
        );
  }
}