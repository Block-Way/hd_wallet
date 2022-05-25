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
      data: ThemeData(primaryColor: Colors.orange),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          centerTitle: true,
          title: Text('首页',style: TextStyle(fontSize: 24.0,color: Colors.white),),
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
                  Tab(text: "test1",),
                  Tab(text: "test2",),
                  Tab(text: "test3",),
                  Tab(text: "test4",),
                  Tab(text: "test5",),
                ],
                  isScrollable: true,
                  indicatorColor: Color(0xffff0000),
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 10.0),
//                  labelPadding: EdgeInsets.only(left: 20),
                  labelColor: Color(0xff333333),
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                  unselectedLabelColor: Colors.yellowAccent,
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