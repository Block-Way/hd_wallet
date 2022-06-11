part of open_ui_module;

class OpenWebViewPage extends HookWidget {
  const OpenWebViewPage(this.appUrl, this.appTitle);

  static const routeName = '/open/webview';

  static void open(String url, [String? title]) {
    AppNavigator.push(routeName, params: {'url': url, 'title': title});
  }

  static Route<dynamic> route(RouteSettings settings) {
    final params = settings.arguments as Map<String, String>;
    final url = params['url'];
    final title = params['title'];
    return DefaultTransition(
      settings,
      OpenWebViewPage(url!, title!),
    );
  }

  final String appUrl;
  final String appTitle;

  dynamic onCallJsMethod(
    String methodName,
    List<dynamic> args,
    OpenWebviewVM viewModel,
  ) {
    switch (methodName) {
      case JsMethods.getBalance:
        final params = JsMethods.getParamsChainSymbol(args);
        if (params == null) {
          Toast.show('Args error');
          return null;
        }
        return viewModel.getCoinBalance(
          chain: params.key,
          symbol: params.value,
        );
      case JsMethods.getAddress:
        final params = JsMethods.getParamsChainSymbol(args);
        if (params == null) {
          Toast.show('Args error');
          return null;
        }
        return viewModel.getCoinAddress(
          chain: params.key,
          symbol: params.value,
        );
      case JsMethods.getWalletId:
        return viewModel.activeWalletId;
      case JsMethods.getLanguage:
        return tr('global:language_api');
      case JsMethods.getFiatCurrency:
        return viewModel.fiatCurrency;
      default:
        return Future.error('Not Supported');
    }
  }

  Future<void> onBindJsMethods(
    InAppWebViewController controller,
    OpenWebviewVM viewModel,
  ) async {
    // Load Debug Demo App
    if (AppConstants.isBeta) {
      /*
      final fileText = await rootBundle.loadString('assets/files/dapp.html');
      controller.loadUrl(
        url: Uri.dataFromString(
          fileText,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString(),
      );*/
    }

    for (final methodName in JsMethods.allMethods) {
      controller.addJavaScriptHandler(
        handlerName: methodName,
        callback: (args) => onCallJsMethod(methodName, args, viewModel),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = useState(appTitle);
    //final webViewCtrl = useValueNotifier<InAppWebViewController>();

    final canGoBack = useState(false);
    final canGoForward = useState(false);

    return WillPopScope(
      onWillPop: () async {
        /*
        return webViewCtrl.value
            .evaluateJavascript(
          source: '',
        )
            .then((value) {
          if (value == false) {
            Toast.show('Wait for DApp');
          }
          return value != false;
        });*/
        return true;
      },
      child: CSScaffold(
        title: title.value,
        leadingIcon: CSIcons.Delete,
        backgroundColor: context.bgPrimaryColor,
        child: StoreConnector<AppState, OpenWebviewVM>(
          distinct: true,
          converter: OpenWebviewVM.fromStore,
          builder: (context, viewModel) => Column(
            children: [
              Expanded(
                child: InAppWebView(
                  //initialUrl: appUrl,
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      //debuggingEnabled: true,
                      transparentBackground: true,
                      useShouldOverrideUrlLoading: true,
                      userAgent: 'Mozilla/5.0 MarsApp',
                    ),
                  ),
                  onConsoleMessage: (ctrl, message) {
                    debugPrint('message ${message.message}');
                  },
                  onWebViewCreated: (controller) {
                    //webViewCtrl.value = controller;
                    onBindJsMethods(controller, viewModel);
                  },
                  //shouldOverrideUrlLoading: (controller, request) async {
                  //  return ShouldOverrideUrlLoadingAction.ALLOW;
                  //},
                  onLoadStart: (controller, url) {
                    //
                  },
                  onLoadStop: (controller, url) {
                    //
                  },
                  onProgressChanged: (controller, progress) {
                    //
                  },
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: <Widget>[
                  CSButtonIcon(
                    icon: CSIcons.Back,
                    size: 20.0,
                    color: canGoBack.value
                        ? context.bodyColor
                        : context.secondaryColor,
                    background: Colors.transparent,
                    onPressed: () {},
                  ),
                  SizedBox(width: 8),
                  CSButtonIcon(
                    icon: CSIcons.Forward,
                    size: 20.0,
                    color: canGoForward.value
                        ? context.bodyColor
                        : context.secondaryColor,
                    background: Colors.transparent,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
