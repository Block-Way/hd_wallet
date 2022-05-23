part of common_ui_module;

class WebViewPage extends HookWidget {
  const WebViewPage(
    this.url,
    this.defaultTitle,
  );
  final String url;
  final String defaultTitle;

  static const routeName = '/common/webview';

  static void open(String url, [String title]) {
    AppNavigator.push(routeName, params: {'url': url, 'title': title});
  }

  static Route<dynamic> route(RouteSettings settings) {
    final params = settings.arguments as Map<String, String>;
    final url = params['url'];
    final title = params['title'];
    return DefaultTransition(
      settings,
      WebViewPage(url, title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = useState(defaultTitle ?? tr('global:webview_title'));
    final loading = useState(true);
    final controller = useState<WebViewController>(null);
    final openUrl = useState<String>(url ?? '');

    final canGoBack = useState(false);
    final canGoForward = useState(false);

    useEffect(() {
      if (Platform.isAndroid) {
        WebView.platform = SurfaceAndroidWebView();
      }
      return null;
    }, []);

    void _onPageFinished(String url) {
      loading.value = false;
      openUrl.value = url;

      controller.value.getTitle().then((value) {
        title.value = value;
      });

      controller.value.canGoBack().then((value) {
        canGoBack.value = value;
      });

      controller.value.canGoForward().then((value) {
        canGoForward.value = value;
      });
    }

    void _onPageStarted(String url) {
      loading.value = true;
    }

    void _onWebViewCreated(WebViewController c) {
      controller.value = c;
    }

    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: CSScaffold(
        title: title.value,
        leadingIcon: CSIcons.Delete,
        backgroundColor: context.bgPrimaryColor,
        child: Column(
          children: [
            if (loading.value)
              LinearProgressIndicator(
                backgroundColor: context.primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  context.btnPrimaryBgColor,
                ),
              ),
            Expanded(
              child: WebView(
                onPageStarted: _onPageStarted,
                onWebViewCreated: _onWebViewCreated,
                onPageFinished: _onPageFinished,
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted, //JS执行模式 是否允许JS执行
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  CSButtonIcon(
                    icon: CSIcons.Back,
                    size: 20.0,
                    color: canGoBack.value
                        ? context.bodyColor
                        : context.secondaryColor,
                    background: Colors.transparent,
                    onPressed: () {
                      if (canGoBack.value) {
                        controller.value?.goBack();
                      }
                    },
                  ),
                  SizedBox(width: 8),
                  CSButtonIcon(
                    icon: CSIcons.Forward,
                    size: 20.0,
                    color: canGoForward.value
                        ? context.bodyColor
                        : context.secondaryColor,
                    background: Colors.transparent,
                    onPressed: () {
                      if (canGoForward.value) {
                        controller.value?.goForward();
                      }
                    },
                  ),
                  Spacer(),
                  CSButtonIcon(
                    icon: CSIcons.Explorer,
                    size: 22,
                    background: Colors.transparent,
                    onPressed: () {
                      doOpenUrl(openUrl.value);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
