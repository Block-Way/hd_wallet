part of settings_ui_module;

class SettingsDevPage extends HookWidget {
  static const routeName = '/settings/dev';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      SettingsDevPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = useState<SettingsConfig>();
    final apiAppVersion = useTextEditingController(text: '');
    final apiBaseUrl = useTextEditingController(text: '');
    final mqttUseTls = useTextEditingController(text: '');
    final mqttDisabled = useTextEditingController(text: '');
    final proxyUrl = useTextEditingController(text: '');

    useEffect(() {
      SettingsRepository().getSettings().then((value) {
        apiAppVersion.text = value.apiAppVersion;
        apiBaseUrl.text = value.apiBaseUrl;
        mqttUseTls.text = value.mqttUseTls;
        mqttDisabled.text = value.mqttDisabled;
        proxyUrl.text = value.proxyUrl;
        settings.value = value;
      });

      // HDKeyCore.addEventListener((event) {
      //   Toast.show('$event');
      // });

      return null;
    }, []);

    void saveSettings() {
      LoadingDialog.show(context);

      final newSettings = settings.value.rebuild(
        (a) => a
          ..apiAppVersion = apiAppVersion.text
          ..apiBaseUrl = apiBaseUrl.text
          ..mqttUseTls = mqttUseTls.text
          ..mqttDisabled = mqttDisabled.text
          ..proxyUrl = proxyUrl.text,
      );

      SettingsRepository().saveSettings(newSettings).then(
        (value) async {
          await Future.delayed(Duration(milliseconds: 200));
          if (newSettings.hasApiBaseUrl) {
            Request().updateBaseUrl(newSettings.apiBaseUrl);
          }
          if (newSettings.hasApiAppVersion) {
            Request().updateHeader('app-version', newSettings.apiAppVersion);
          }
          if (newSettings.hasProxyUrl && Platform.isAndroid) {
            Request().setupProxy(newSettings.proxyUrl);
          }
          LoadingDialog.dismiss(context);
        },
      ).catchError((error) {
        Toast.showError(error);
      });
    }

    return CSScaffold(
      title: 'Settings Api',
      scrollable: true,
      actions: [
        CSButton(
          label: 'Save',
          flat: true,
          padding: context.edgeAll,
          onPressed: () {
            saveSettings();
          },
        ),
      ],
      child: Column(
        children: [
          FormBox(
            title: 'Api App Version',
            controller: apiAppVersion,
            hintText: '1.0.1',
          ),
          FormBox(
            title: 'Api Base Url',
            controller: apiBaseUrl,
            hintText: AppConstants.apiUrl.first,
            titleAction: CSCheckBox(
              key: ValueKey(apiBaseUrl.text),
              label: '用测试环境',
              value: AppConstants.apiUrlDev.contains(apiBaseUrl.text),
              onChanged: (value) {
                apiBaseUrl.text = value
                    ? AppConstants.apiUrlDev.first
                    : AppConstants.apiUrl.first;
              },
            ),
          ),
          FormBox(
            title: 'MQTT Settings',
            editable: false,
            controller: mqttUseTls,
            child: Row(
              children: [
                Text(
                  'Disabled:',
                  style: context.textBody(bold: true),
                ),
                CSSwitch(
                  key: ValueKey('$mqttDisabled-${mqttDisabled.text}'),
                  value: mqttDisabled.text == 'true',
                  onChanged: (value) {
                    mqttDisabled.text = value ? 'true' : 'false';
                  },
                ),
                SizedBox(width: 20),
                Text(
                  'Use TLS:',
                  style: context.textBody(bold: true),
                ),
                CSSwitch(
                  key: ValueKey('$mqttUseTls-${mqttUseTls.text}'),
                  value: mqttUseTls.text == 'true',
                  onChanged: (value) {
                    mqttUseTls.text = value ? 'true' : 'false';
                  },
                ),
              ],
            ),
          ),
          FormBox(
            title: 'Android PC Proxy',
            controller: proxyUrl,
            hintText: '10.0.0.31:8888',
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 16 / 4,
            padding: context.edgeAll,
            children: [
              CSButton(
                label: 'Clear Trade Order Cache',
                onPressed: () {
                  final store = StoreProvider.of<AppState>(context, false);
                  TradeRepository().clearTradeOrdersCache(
                    store.state.walletState.activeWalletId,
                  );
                  Toast.show('Cache orders cleared');
                },
              ),
              CSButton(
                label: '删除全部钱包',
                onPressed: () {
                  showConfirmDialog(
                    context,
                    content: '确认要删除全部钱包？？？',
                    confirmBtnText: '确认删除',
                    confirmBtnStyle: context.textBody(
                      bold: true,
                      color: context.redColor,
                    ),
                    onConfirm: () {
                      final store = StoreProvider.of<AppState>(context, false);
                      LoadingDialog.show(context);
                      store
                          .dispatchFuture(WalletActionWalletRemoveAll())
                          .then((value) => Toast.show('wallet remove success'))
                          .whenComplete(() => LoadingDialog.dismiss(context));
                    },
                  );
                },
              ),
              CSButton(
                label: '导入本地测试钱包',
                onPressed: () {
                  final store = StoreProvider.of<AppState>(context, false);
                  LoadingDialog.show(context);
                  store
                      .dispatchFuture(WalletActionWalletFromEnv())
                      .then((value) => Toast.show('import wallet success'))
                      .whenComplete(() => LoadingDialog.dismiss(context));
                },
              ),
              CSButton(
                label: '我要20个钱包',
                onPressed: () {
                  final store = StoreProvider.of<AppState>(context, false);
                  LoadingDialog.show(context);
                  store
                      .dispatchFuture(WalletActionWalletFromEnv(20))
                      .then((value) => Toast.show('wallet create success'))
                      .whenComplete(() => LoadingDialog.dismiss(context));
                },
              ),
              CSButton(
                label: 'Open Webview',
                onPressed: () {
                  OpenWebViewPage.open('about:blank');
                },
              ),
              CSButton(
                label: 'Debug open any page',
                onPressed: () {
                  //
                },
              ),
              CSButton(
                label: '清除邀请码缓存',
                onPressed: () {
                  final store = StoreProvider.of<AppState>(context, false);
                  InvitationRepository().clearInvitationCodeCache(
                    store.state.walletState.activeWalletId,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
