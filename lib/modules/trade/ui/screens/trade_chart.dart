part of trade_ui_module;

class RequestParams {
  RequestParams({
    @required this.tradePair,
    @required this.resolution,
  });

  TradePair tradePair;
  ResolutionItem resolution;

  void update(RequestParams data) {
    tradePair = data.tradePair;
    resolution = data.resolution;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is RequestParams &&
        o.tradePair == tradePair &&
        o.resolution == resolution;
  }

  @override
  int get hashCode => tradePair.hashCode ^ resolution.hashCode;

  RequestParams copyWith({
    TradePair tradePair,
    ResolutionItem resolution,
  }) {
    return RequestParams(
      tradePair: tradePair ?? this.tradePair,
      resolution: resolution ?? this.resolution,
    );
  }
}

class TradeChartPage extends HookWidget {
  TradeChartPage(this.openTradePair, {Key key}) : super(key: key);
  final TradePair openTradePair;

  static const routeName = '/trade/chart';

  static void open(TradePair openTradePair) {
    AppNavigator.push(routeName, params: openTradePair);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      MultiBlocProvider(
        providers: [
          BlocProvider<TradeTickersCubit>(
            create: (context) => TradeTickersCubit(),
          ),
          BlocProvider<TradeChartKLineCubit>(
            create: (context) => TradeChartKLineCubit(),
          ),
          BlocProvider<TradeChartDepthCubit>(
            create: (context) => TradeChartDepthCubit(),
          ),
          BlocProvider<TradeInfo24hCubit>(
            create: (context) => TradeInfo24hCubit(),
          ),
          BlocProvider<TradeDealsCubit>(
            create: (context) => TradeDealsCubit(),
          ),
        ],
        child: TradeChartMqttProvider(
          mqtt: GetIt.I<TradeMqtt>(),
          child: TradeChartPage(
            settings.arguments as TradePair,
          ),
        ),
      ),
    );
  }

  final refreshController = CSRefresherController();

  Future<List<dynamic>> doLoadData(
    BuildContext context,
    RequestParams params,
    StreamController<bool> dataIsLoading,
  ) {
    final tickersCubit = context.read<TradeTickersCubit>();
    final newestCubit = context.read<TradeDealsCubit>();
    final chartInfoCubit = context.read<TradeInfo24hCubit>();
    final kLineCubit = context.read<TradeChartKLineCubit>();
    final depthCubit = context.read<TradeChartDepthCubit>();
    kChartWidgetKey?.currentState?.closeInfoWindow();

    return Future.wait([
      GetIt.I<CoinPriceCubit>().updateSingle(params.tradePair.id),
      newestCubit.loadData(params.tradePair),
      chartInfoCubit.loadData(params.tradePair),
      tickersCubit.loadData(params.tradePair),
      if (params.resolution.id == 'depth')
        depthCubit.loadData(
          tradePair: params.tradePair,
          chartLoadingStream: dataIsLoading,
        ),
      if (params.resolution.id != 'depth')
        kLineCubit.loadData(
          resolution: params.resolution,
          tradePairId: params.tradePair.id,
          chartLoadingStream: dataIsLoading,
        ),
    ]).catchError((error) {
      Toast.showError(error);
    });
  }

  void doExitFullScreen(ValueNotifier<bool> isFullScreen) {
    kChartWidgetKey?.currentState?.closeInfoWindow();
    isFullScreen.value = false;
    ThemeDisplay.setPortraitMode();
  }

  void doEnterFullScreen(ValueNotifier<bool> isFullScreen) {
    kChartWidgetKey?.currentState?.closeInfoWindow();
    isFullScreen.value = true;
    ThemeDisplay.setLandscapeMode();
  }

  @override
  Widget build(BuildContext context) {
    final isFullScreen = useState(false);
    final tradePair = useState(openTradePair);
    final currentResolution =
        context.select<TradeChartKLineCubit, ResolutionItem>(
      (cubit) => cubit.getResolution(tradePair.value.id),
    );
    final params = useMemoized(
      () => RequestParams(
        tradePair: tradePair.value,
        resolution: currentResolution,
      ),
    );
    final dataIsLoading = useStreamController<bool>();
    final request = useBehaviorStreamController<RequestParams>();

    useEffect(() {
      final subRequest = request.stream
          .distinct()
          .doOnData((value) {
            dataIsLoading.add(true);
            if (params.tradePair != value.tradePair) {
              context.read<TradeChartKLineCubit>().clearData();
              context.read<TradeChartDepthCubit>().clearData();
              context.read<TradeInfo24hCubit>().clearData();
            }
            params.update(value);
          })
          .debounceTime(Duration(seconds: 1))
          .switchMap((value) {
            return doLoadData(
              context,
              params,
              dataIsLoading,
            ).asStream();
          })
          .listen((event) {
            //
          });

      request.add(params);

      return () {
        subRequest.cancel();
        context.read<TradeChartKLineCubit>().clearData();
        context.read<TradeChartDepthCubit>().clearData();
        context.read<TradeInfo24hCubit>().clearData();
      };
    }, []);

    const bgColor = Color(0xFF1b1e26);

    return WillPopScope(
      onWillPop: () async {
        if (isFullScreen.value) {
          doExitFullScreen(isFullScreen);
          return false;
        } else {
          return true;
        }
      },
      child: CSScaffold(
        addBottomInset: !isFullScreen.value,
        extendBodyBehindAppBar: true,
        hideLeading: true,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF15171d),
        headerBgColor: bgColor,
        drawer: CSDrawer(
          width: context.mediaWidth * 0.826,
          elevation: 100,
          decoration: BoxDecoration(
            color: context.bgSecondaryColor,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(24.0),
            ),
          ),
          child: TradeSelectDrawer(
            selected: tradePair.value,
            onSelected: (value) {
              tradePair.value = value;
              request.add(
                params.copyWith(tradePair: value),
              );
            },
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: context.whiteLightColor),
          leadingWidth: isFullScreen.value
              ? Platform.isIOS
                  ? context.edgeSize
                  : context.edgeSizeDouble
              : 56.0,
          leading: isFullScreen.value
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    CSIcons.Back,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
          title: Row(
            children: [
              Builder(
                builder: (context) => Transform.translate(
                  offset: Offset(-context.edgeSize, 0),
                  child: TradeTitle(
                    tradePair: tradePair.value,
                    hideChange: true,
                    color: context.whiteLightColor,
                    isFullScreen: isFullScreen.value,
                    onPressed: isFullScreen.value == true
                        ? null
                        : () {
                            Scaffold.of(context).openDrawer();
                          },
                  ),
                ),
              ),
              if (isFullScreen.value == true)
                Expanded(
                  child: ChartHeader(
                    requestStream: request.stream,
                    isFullScreen: true,
                  ),
                ),
            ],
          ),
          actions: [
            CSButtonIcon(
              icon: isFullScreen.value ? CSIcons.Delete : CSIcons.FullScreen,
              size: 20,
              color: context.whiteLightColor,
              background: Colors.transparent,
              padding: context.edgeAll.copyWith(right: 0),
              onPressed: () {
                if (isFullScreen.value) {
                  doExitFullScreen(isFullScreen);
                } else {
                  AnalyticsReport().reportLog('Chart_Enter_FullScreen', {});
                  doEnterFullScreen(isFullScreen);
                }
              },
            ),
          ],
        ),
        child: CSRefresher(
          refreshDelay: Duration(seconds: 10),
          onRefresh: () {
            doLoadData(
              context,
              params,
              dataIsLoading,
            ).then((_) {
              refreshController.refreshCompleted();
            }).catchError((error) {
              refreshController.refreshFailed();
              Toast.showError(error);
            });
          },
          header: ListViewHeader(background: Colors.transparent),
          controller: refreshController,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 100,
                  padding: context.edgeHorizontal,
                  color: bgColor,
                  child: ChartHeader(
                    requestStream: request.stream,
                  ),
                ),
                AnimatedPadding(
                  padding: EdgeInsets.only(
                    top: isFullScreen.value ? 0 : 80,
                  ),
                  duration: Duration(milliseconds: 500),
                  child: ChartKLine(
                    key: ValueKey('chart'),
                    selectedResolution: currentResolution,
                    chartDataStream: request.stream.switchMap(
                      (value) => context
                          .read<TradeChartKLineCubit>()
                          .byTradePair(value.tradePair.id),
                    ),
                    chartDepthStream: request.stream.switchMap(
                      (value) => context
                          .read<TradeChartDepthCubit>()
                          .byTradePair(value.tradePair.id),
                    ),
                    chartIsLoading: dataIsLoading.stream,
                    isFullScreen: isFullScreen.value,
                    onChangeResolution: (resolution) {
                      context
                          .read<TradeChartKLineCubit>()
                          .changeResolution(resolution);
                      request.add(params.copyWith(
                        resolution: resolution,
                      ));
                    },
                  ),
                ),
                if (!isFullScreen.value)
                  AnimatedPadding(
                    duration: Duration(milliseconds: 500),
                    padding: EdgeInsets.only(
                      top: isFullScreen.value ? context.mediaHeight : 575,
                    ),
                    child: ChartFooter(
                      tradePair: tradePair.value,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
