part of explorer_ui_module;

class ExplorerHomePage extends StatelessWidget {
  static const routeName = '/explorer/home';

  static void open() {
    AppNavigator.push(
      routeName,
    );
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      ExplorerHomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      title: tr('explorer:blockchain_browsers_title'),
      headerBgColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      outerChild: Positioned(
        left: 0,
        top: 0,
        right: 0,
        height: context.mediaHeight,
        child: Container(
          height: context.mediaHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/explorer_bg.png'),
            ),
          ),
        ),
      ),
      child: StoreConnector<AppState, ExplorerHomeVM>(
        distinct: true,
        converter: ExplorerHomeVM.fromStore,
        builder: (context, viewModel) => ExplorerBar(
          explorerList: viewModel.explorerList,
        ),
      ),
    );
  }
}
