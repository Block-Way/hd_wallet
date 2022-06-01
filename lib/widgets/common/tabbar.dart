part of widgets;

class CSTabBar extends StatefulWidget {
  @override
  _CSTabBarState createState() => _CSTabBarState();
}

class _CSTabBarState extends State<CSTabBar>
    with SingleTickerProviderStateMixin {
  // final searchController = useTextEditingController(text: '');
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  List listDataQuick = [
    {
      'title': 'Generate wallet',
      'pageUrl': 'http://119.8.55.78:7711/Generate_wallet.html'
    },
    {
      'title': 'How to check the mnemonic',
      'pageUrl': 'http://119.8.55.78:7711/How_to_check_the_mnemonic.html'
    },
    {
      'title': 'How to send and receive money with Block Saver',
      'pageUrl': 'http://119.8.55.78:7711/How_to_send_and_receive_money_with_Block_Saver.html'
    },
    {
      'title': 'How to use the wallet?',
      'pageUrl': 'http://119.8.55.78:7711/How_to_use_the wallet.html'
    },
    {
      'title': 'Import your wallet',
      'pageUrl': 'http://119.8.55.78:7711/Import_your_wallet.html'
    },
    {
      'title': 'Wallet Management',
      'pageUrl': 'http://119.8.55.78:7711/Wallet_Management.html'
    }
  ];

  List listDataManual = [
    {
      'title': 'Node Vote/Withdrawal Introduction',
      'pageUrl': 'http://119.8.55.78:7711/Node_Vote_Withdrawal.html'
    },
    {
      'title': 'Vote/Compound Interest',
      'pageUrl': 'http://119.8.55.78:7711/Vote_Compound_Interest.html'
    },
    {
      'title': 'Withdrawal',
      'pageUrl': 'http://119.8.55.78:7711/Withdrawal.html'
    }
  ];

  List listDataOperation = [
    {
      'title': 'Wallet address and private key',
      'pageUrl': 'http://119.8.55.78:7711/Wallet_address_and_private_key.html'
    },
    {
      'title': 'What are crypto assets?',
      'pageUrl': 'http://119.8.55.78:7711/What_are_crypto_assets.html'
    },
    {
      'title': 'What is a wallet',
      'pageUrl': 'http://119.8.55.78:7711/What_is_a_wallet.html'
    },
    {
      'title': 'What is Wallet Software',
      'pageUrl': 'http://119.8.55.78:7711/What_is_Wallet_Software.html'
    }
  ];

  List listDataAsset = [
    {
      'title': 'Node reward calcuation method',
      'pageUrl': 'http://119.8.55.78:7711/Node_reward_calculation_method.html'
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
          title: Text(tr('user:help_title'),
              style: context.textHuge(
                  fontWeight: FontWeight.w700, color: context.bgPrimaryColor)),
        ),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 180,
                automaticallyImplyLeading: false, //hide left back arrow
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    // height: double.infinity,
                    height: 500,
                    color: context.searchBgColor,
                    // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 54),
                    child: Column(
                      children: <Widget>[_searchInput()],
                    ),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: tr('A Must Read Of Beginners')),
                    Tab(text: tr('Node Vote/Withdrawal')),
                    Tab(text: tr('Quick Start')),
                    Tab(text: tr('View Rewaeds')),
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
            children: [
              _buildListView(listDataQuick),
              _buildListView(listDataManual),
              _buildListView(listDataOperation),
              _buildListView(listDataAsset)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getQuestionList(List targetList) {
    var tempList = targetList.map((value) {
      return ListTile(
        title: Text(tr(value['title'].toString())),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => {
          // doOpenUrl((value['pageUrl']).toString());
          print('${value['pageUrl']}')
        },
      );
    });
    return tempList.toList();
  }

  Widget _searchInput() {
    return CSSearchInput(
      // controller: searchController,
      autofocus: false,
      radius: 25,
      maxLength: 256,
      margin: context.edgeHorizontal,
      hintText: 'Please enter your problem',
      showSearchIcon: false,
      onChanged: (_) {},
      hintStyle: context.textSmall(),
      background: context.mainColor,
      cmpRight: CSButtonIcon(
          icon: CSIcons.Search,
          borderRadius: 40.0,
          background: context.mainColor,
          size: 16),
    );
  }

  Widget _buildListView(List listView) {
    // return Text(tr('dasdfasdf'));
    return ListView.separated(
        itemCount: listView.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(
              color: context.mainColor,
              height: 0.8,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: context.mainColor,
            child: ListTile(
              title: Text(
                  tr('${listView[index]['title']}'),
                  style: TextStyle(
                      color: context.tabContentColor
                  )
              ),
              trailing: Icon(
                  Icons.keyboard_arrow_right,
                 color: context.tabContentColor
              ),
            ),
          );
        });
 }
}
