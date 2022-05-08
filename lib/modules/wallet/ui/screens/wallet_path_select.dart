part of wallet_ui_module;

class WalletPathSelectPage extends HookWidget {
  static const routeName = '/wallet/path/select';

  static Future<WalletPathConfig> open() {
    return AppNavigator.push<WalletPathConfig>(routeName);
  }

  static Route<WalletPathConfig> route(RouteSettings settings) {
    return DefaultTransition<WalletPathConfig>(
      settings,
      WalletPathSelectPage(),
    );
  }

  Widget buildItem(BuildContext context, WalletPathConfig item) {
    return CSContainer(
      margin: context.edgeAll.copyWith(top: 0),
      padding: EdgeInsets.zero,
      child: FormCell(
        label: item.transKey != null ? tr(item.transKey) : item.name,
        cmpLeft: Padding(
          padding: context.edgeRight8,
          child: CSImage(
            item.logo,
            width: 30,
            height: 30,
            radius: 30,
            fit: BoxFit.contain,
          ),
        ),
        padding: context.edgeHorizontal,
        onPress: () {
          AppNavigator.popWithResult(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = WalletPathUtils.pathConfigs;
    return CSScaffold(
      scrollable: true,
      title: tr('wallet:select_path_title'),
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          if (index >= list.length) {
            return Padding(
              padding: context.edgeAll.copyWith(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('wallet:select_path_tip'),
                    style: context.textSecondary(),
                  ),
                  CSButton(
                    label: tr('wallet:select_path_btn_contact_us'),
                    flat: true,
                    textStyle: context.textSecondary().copyWith(
                          decoration: TextDecoration.underline,
                        ),
                    onPressed: () {
                      WebViewPage.open(
                        AppLinks.appContactUrl(context.locale.languageCode),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          final item = list[index];
          return buildItem(context, item);
        },
      ),
    );
  }
}
