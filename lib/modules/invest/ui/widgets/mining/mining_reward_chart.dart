part of invest_ui_module;

class MiningRewardChart extends StatefulWidget {
  const MiningRewardChart(this.chartList);
  final List<MintChart> chartList;

  @override
  _LineChartHoldState createState() => _LineChartHoldState();
}

class _LineChartHoldState extends State<MiningRewardChart> {
  List<Color> gradientColors = [
    Color(0xffff8c2e),
    Color(0xffff8c2e).withOpacity(0.8),
  ];

  final showCount = [0.25, 0.5, 0.75];

  void selectSort(List<MintChart> a) {
    for (var i = 0; i < a.length - 1; i++) {
      var mi = i;
      for (var j = i + 1; j < a.length; j++) {
        if (NumberUtil.isLess(a[j].balance, a[mi].balance)) {
          mi = j;
        }
      }
      if (i != mi) {
        final t = a[i];
        a[i] = a[mi];
        a[mi] = t;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chartList == null || widget.chartList.isEmpty) {
      return Container();
    }

    selectSort(widget.chartList);

    final data = (widget.chartList ?? [])
        .map(
          (e) => FlSpot(
            NumberUtil.getDouble(e.balance),
            NumberUtil.getDouble(e.reward),
          ),
        )
        .toList();
    final showIndex = (widget.chartList ?? []).indexWhere((e) => e.isBalance);
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 30, bottom: 12),
          child: SizedBox(
            width: context.mediaWidth - context.edgeSizeDouble,
            child: LineChart(
              mainData(context, data, showIndex),
            ),
          ),
        ),
        Row(
          children: [
            Text(
              tr('invest:reward_lbl_chart_tip'),
              style: context.textSmall(),
            ),
            /*
            Spacer(),
            Container(
              margin: EdgeInsets.only(top: 2),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                border: Border.all(color: context.primaryColor, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            
            SizedBox(width: 2),
            Text(
              tr('invest:reward_lbl_chart_where'),
              style: context.textSmall(),
            )*/
          ],
        ),
      ],
    );
  }

  double filter(
      List<FlSpot> data, double v, double Function(double a, FlSpot b) check) {
    double value = v;
    for (final item in data) {
      value = check(value, item);
    }
    return value;
  }

  String formatLbl(double value, {bool isZh}) {
    if (isZh) {
      final date = DateTime.fromMillisecondsSinceEpoch((value * 1000).toInt());
      return '${date.month}-${date.day}';
    } else {
      return StringUtils.displaySize(value);
    }
  }

  bool checkToShowTitle(
    double minValue,
    double maxValue,
    SideTitles sideTitles,
    double appliedInterval,
    double value,
  ) {
    if (value == maxValue || value == minValue) {
      return true;
    }

    final totalCount = (maxValue - minValue) ~/ appliedInterval;
    if (totalCount > 8) {
      for (final item in showCount) {
        final mNum = NumberUtil.plus<double>(
          (item * totalCount).round() * appliedInterval,
          minValue,
        );
        if (value == mNum) {
          return true;
        }
      }
      return false;
    }
    return defaultCheckToShowTitle(
        minValue, maxValue, sideTitles, appliedInterval, value);
  }

  LineChartData mainData(
      BuildContext context, List<FlSpot> data, int showIndex) {
    final isZh = context.locale.languageCode == 'zh';

    // final dv = data[0];
    // final minX = filter(data, dv.x, (a, b) => b.x < a ? b.x : a);
    // final maxX = filter(data, dv.x, (a, b) => b.x > a ? b.x : a);
    // final minY = filter(data, 0, (a, b) => b.y < a ? b.y : a);
    final maxY = filter(data, 0, (a, b) => b.y > a ? b.y : a);

    return LineChartData(
      // minX: minX,
      // maxX: maxX,
      minY: 0,
      maxY: maxY * 1.1,
      lineTouchData: LineTouchData(
        enabled: false,
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.transparent,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: context.whiteColor,
                  strokeWidth: 1.5,
                  strokeColor: context.primaryColor,
                ),
              ),
            );
          }).toList();
        },
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xffeeeeee),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xffeeeeee),
            strokeWidth: 0.5,
          );
        },
      ),
      // clipData: FlClipData.horizontal(),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          checkToShowTitle: checkToShowTitle,
          // 下面文字
          getTextStyles: (_) => context.textSmall(
            color: context.placeholderColor,
          ),
          getTitles: (value) {
            return formatLbl(value, isZh: isZh);
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => context.textSmall(
            color: context.placeholderColor,
          ),
          getTitles: (value) {
            final ret = value.toStringAsFixed(2);
            //NumberUtil.divide<double>(value, 10, 2).toStringAsFixed(2);
            return ret;
          },
          checkToShowTitle: checkToShowTitle,
          reservedSize: 28,
          margin: 5,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: context.bgSecondaryColor,
            width: 0.5,
          )),
      lineBarsData: [
        LineChartBarData(
          showingIndicators: showIndex >= 0 ? [showIndex] : [],
          spots: data,
          // isCurved: true,
          // curveSmoothness: 0.05,
          colors: gradientColors,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.05)).toList(),
          ),
        ),
      ],
    );
  }
}
