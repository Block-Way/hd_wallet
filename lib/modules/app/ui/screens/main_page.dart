part of app_module;

class TabBarItem {
  TabBarItem(
    this.screen,
    this.label,
    this.iconDefault,
    this.iconSelect,
    this.iconRive,
    this.animationName, {
    this.isVisible = true,
  });

  int? index;
  final Widget screen;
  final String label;
  final String iconDefault;
  final String iconSelect;
  final String iconRive;
  final String animationName;
  final bool isVisible;
}

/// This is the Main App page
/// there can only be one of this page open in the entire app
class AppMainPage extends HookWidget {
  static const routeName = '/app/main';
  static final _tabChanger = StreamController<int>.broadcast();
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  static void changePage(int pageIndex) {
    _tabChanger.add(pageIndex);
  }

  static void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  static void open() {
    AppNavigator.push(routeName, replace: true);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return RevealRoute(
      settings: settings,
      page: AppMainPage(),
      minRadius: 0,
      maxRadius: 600,
      duration: 500,
    );
  }

  final tabBarItems = [
    TabBarItem(
      AssetMainTab(),
      'global:main_tab_wallet',
      '',
      '',
      'wallet',
      'Wallet',
    ),
    TabBarItem(
      HomeMainTab(),
      'global:main_tab_home',
      '',
      '',
      'home',
      'Home',
    ),
    // TabBarItem(
    //   TradeMainTab(),
    //   'global:main_tab_trade',
    //   '',
    //   '',
    //   'trade',
    //   'Trading',
    // ),

    if (AppConstants.isBeta)
      TabBarItem(
        InvestMainTab(),
        'global:main_tab_invest',
        '',
        '',
        'invest',
        'investment',
      ),
  ];

  // to store nested tabs
  // final pageKey = PageStorageKey('TabBar');
  final pageBucket = PageStorageBucket();

  Widget renderImageTabItem(
    BuildContext context,
    TabBarItem item,
    int currentTab,
    Function(int) onSelected,
  ) {
    final isSelect = currentTab == item.index;
    final color = isSelect ? context.bodyColor : context.secondaryColor;
    final iconPath = isSelect ? item.iconSelect : item.iconDefault;
    final isVisible = item.isVisible;
    final menuTabItemWidth = context.mediaWidth / tabBarItems.length;

    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: isVisible ? 1 : 0,
      child: InkWell(
        onTap: isVisible
            ? () {
                onSelected(item.index ?? 0);
              }
            : null,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          width: isVisible ? menuTabItemWidth : 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 2),
              Image.asset(
                iconPath,
                width: menuTabItemWidth,
                height: 25,
              ),
              Padding(
                padding: context.edgeHorizontal5.copyWith(top: 2),
                child: Text(
                  tr(item.label),
                  style: context.textSmall(color: color, bold: true),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderAnimatedTabItem(
    BuildContext context,
    TabBarItem item,
    int currentTab,
    Function(int) onSelected,
  ) {
    final isSelected = currentTab == item.index;
    // final color = isSelected ? context.bodyColor : context.secondaryColor;
    final color = Color(0xFFE2ECF7);
    final menuTabItemWidth = context.mediaWidth / tabBarItems.length;

    return InkWell(
      key: ValueKey(item.iconRive),
      onTap: () {
        Toast.hide();
        onSelected(item.index ?? 0);
      },
      child: SizedBox(
        width: menuTabItemWidth,
        height: 52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RiveToggleAnimation(
              fileName: item.iconRive,
              animationOnName: '${item.animationName}-on',
              animationOffName: '${item.animationName}-off',
              isOn: isSelected,
              size: 25,
            ),
            Padding(
              padding: context.edgeHorizontal5,
              child: Text(
                tr(item.label),
                style: context.textSmall(color: color, bold: true),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = useState(0);
    final backLastTime = useState(0);

    useEffect(() {
      tabBarItems.asMap().forEach((index, value) {
        value.index = index;
      });
      final subTab = _tabChanger.stream.listen((tabIndex) {
        currentTab.value =
            tabIndex > tabBarItems.length ? tabBarItems.length : tabIndex;
      });
      return () {
        subTab.cancel();
      };
    }, []);

    useEffect(() {
      // When change language, force refresh
      backLastTime.value = backLastTime.value - 1;
      return null;
    }, [context.locale.languageCode]);

    return WillPopScope(
      onWillPop: () async {
        final time = DateTime.now().millisecondsSinceEpoch;
        if (time - backLastTime.value < 2000) {
          return true;
        }
        backLastTime.value = time;
        Toast.show(tr('global:msg_app_confirm_exit'), duration: 3000);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        drawerEnableOpenDragGesture: false,
        drawerScrimColor: context.backdropColor,
        body: Stack(
          children: [
            PageStorage(
              // key: pageKey,
              bucket: pageBucket,
              child: tabBarItems[currentTab.value].screen,
            ),
            OfflineBuilder(
              builder: (context, status) => Positioned(
                right: 0,
                left: 0,
                bottom: 40,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 350),
                  child: (status.data ?? false) // true if is offline
                      ? Container(
                          height: 40,
                          width: 220,
                          padding: context.edgeHorizontal,
                          alignment: Alignment.center,
                          decoration: context.boxDecoration(
                            color: context.redColor.withOpacity(0.8),
                            radius: 20,
                          ),
                          child: Text(
                            tr('global:msg_app_offline'),
                            style: context.textSecondary(
                              color: context.whiteColor,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: context.bgPrimaryColor,
          shape: CircularNotchedRectangle(),
          elevation: 0.0,
          child: Container(
            decoration: BoxDecoration(
              // color: context.bgPrimaryColor,
              color: Color(0xFF24282D),
              boxShadow: [
                BoxShadow(
                  color: context.blackColor.withOpacity(0.1),
                  blurRadius: 0.5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            height: 52,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: tabBarItems
                  .map((item) => renderAnimatedTabItem(
                        context,
                        item,
                        currentTab.value,
                        (index) {
                          currentTab.value = index;
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
