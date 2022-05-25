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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: context.mainColor),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          centerTitle: true,
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

                bottom: TabBar(controller: _tabController, tabs: [
                  Tab(text: tr('user:help_quick_title')),
                  Tab(text: tr('user:help_manual_title')),
                  Tab(text: tr('user:help_operation_title')),
                  Tab(text: tr('user:help_asset_title')),
                  Tab(text: tr('user:help_transaction_title')),
                ],
                  isScrollable: true,
                  indicatorColor: context.tabBarColor,
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 20.0),
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
              _buildListView("test1:"),
              _buildListView("test2:"),
              _buildListView("test3:"),
              _buildListView("test4:"),
              _buildListView("test5:"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(String s) {
    return ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(
              color: Colors.grey,
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.white,
              child: ListTile(title: Text("$s第$index 个条目")));
        });
  }
}