part of trade_ui_module;

class ChartKLine extends HookWidget {
  const ChartKLine({
    @required this.chartDataStream,
    @required this.chartDepthStream,
    @required this.chartIsLoading,
    @required this.selectedResolution,
    @required this.onChangeResolution,
    Key key,
    this.isFullScreen = false,
  }) : super(key: key);

  final bool isFullScreen;
  final Stream<List<KLineEntity>> chartDataStream;
  final Stream<Map<String, List<DepthEntity>>> chartDepthStream;
  final Stream<bool> chartIsLoading;
  final ResolutionItem selectedResolution;
  final Function(ResolutionItem resolution) onChangeResolution;

  @override
  Widget build(BuildContext context) {
    final chartData = useStream(chartDataStream);
    final depthData = useStream(chartDepthStream);
    final isLine = useState(false);
    final mainState = useState(MainState.MA);
    final secondaryState = useState(SecondaryState.MACD);

    const resolutionsBarHeight = 40.0;
    final statusBarHeight =
        MediaQuery.of(context).viewPadding.bottom + kToolbarHeight;
    final chartHeight =
        context.mediaHeight - statusBarHeight - resolutionsBarHeight;

    final infoNames = [
      tr('trade:kline_lbl_time'),
      tr('trade:kline_lbl_open'),
      tr('trade:kline_lbl_high'),
      tr('trade:kline_lbl_low'),
      tr('trade:kline_lbl_close'),
      tr('trade:kline_lbl_change'),
      tr('trade:kline_lbl_increase'),
      tr('trade:kline_lbl_deal_amount'),
    ];

    const bgColor = Color(0xFF1b1e26);

    final resolutionsBar = ChartKLineResolutions(
      onSelected: (value) {
        onChangeResolution(value);
      },
      height: resolutionsBarHeight,
      selected: selectedResolution,
      color: context.whiteLightColor,
    );

    return Container(
      color: bgColor,
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isFullScreen ? 0 : resolutionsBarHeight,
            child: resolutionsBar,
          ),
          Stack(
            children: <Widget>[
              if (selectedResolution.id == 'depth')
                SizedBox(
                  height: isFullScreen ? chartHeight : 450,
                  width: double.infinity,
                  child: DepthChart(
                    depthData.data != null ? depthData.data['bids'] : [],
                    depthData.data != null ? depthData.data['asks'] : [],
                  ),
                ),
              if (selectedResolution.id != 'depth')
                SizedBox(
                  height: isFullScreen ? chartHeight : 450,
                  width: double.infinity,
                  child: KChartWidget(
                    chartData.data,
                    isLine: isLine.value,
                    mainState: mainState.value,
                    secondaryState: secondaryState.value,
                    fractionDigits: 4,
                    infoNames: infoNames,
                    key: kChartWidgetKey,
                  ),
                ),
              StreamBuilder<bool>(
                stream: chartIsLoading,
                initialData: true,
                builder: (context, snapshot) => snapshot.data
                    ? AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: double.infinity,
                        height: isFullScreen ? chartHeight : 450,
                        alignment: Alignment.center,
                        child: CSProgressIndicator(),
                      )
                    : SizedBox(),
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isFullScreen ? resolutionsBarHeight : 0,
            child: resolutionsBar,
          ),
        ],
      ),
    );
  }
}
