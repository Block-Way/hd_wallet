part of settings_ui_module;

class SettingsTestnetPage extends HookWidget {
  static const routeName = '/settings/testnet';
  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      SettingsTestnetPage(),
    );
  }

  List<MapEntry<String, bool>> getNetMaps() {
    return [
      MapEntry('BBC', WalletConfigNetwork.hah),
      MapEntry('BTC', WalletConfigNetwork.btc),
      MapEntry('ETH', WalletConfigNetwork.eth),
      MapEntry('TRX', WalletConfigNetwork.trx),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final nets = useState(getNetMaps());

    return CSScaffold(
      title: 'Settings TestNet',
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: nets.value
            .map(
              (item) => FormBox(
                key: Key('${item.key}_${item.value}'),
                title: item.key,
                value: item.value == true ? '测试链' : '正式链',
                editable: false,
                child: CSSwitch(
                  value: item.value,
                  onChanged: (value) {
                    WalletConfigNetwork.setTestNetByChain(
                      item.key,
                      value: value,
                    );
                    nets.value = getNetMaps();
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
