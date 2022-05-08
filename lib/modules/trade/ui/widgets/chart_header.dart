part of trade_ui_module;

class ChartHeader extends HookWidget {
  const ChartHeader({
    Key key,
    this.isFullScreen = false,
    this.requestStream,
  }) : super(key: key);

  final bool isFullScreen;
  final Stream<RequestParams> requestStream;

  @override
  Widget build(BuildContext context) {
    const labelColor = Color(0xFF676f83);

    final chartRequest = useStream(requestStream);
    final tradePair = chartRequest.data?.tradePair;

    if (tradePair == null) {
      return SizedBox();
    }

    Widget renderRowItemBar(String label, String value) {
      return Padding(
        padding: isFullScreen ? context.edgeLeft16 : context.edgeVertical5,
        child: RichText(
          text: TextSpan(
            text: label,
            style: context.textTiny(
              color: labelColor,
              bold: true,
            ),
            children: [
              TextSpan(
                text: '    $value',
                style: context.textTinyPrice(
                  bold: true,
                  color: context.whiteLightColor,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget renderTradeInfo24h(TradeInfo24h data) {
      final list = [
        {
          'label': tr('trade:chart_lbl_high'),
          'value': data.displayHigh,
        },
        {
          'label': tr('trade:chart_lbl_low'),
          'value': data.displayLow,
        },
        {
          'label': tr('trade:chart_lbl_24'),
          'value': data.displayVol,
        },
      ];
      return isFullScreen
          ? Flex(
              direction: Axis.horizontal,
              children: list
                  .map(
                    (e) => renderRowItemBar(
                      e['label'].toString(),
                      e['value'].toString(),
                    ),
                  )
                  .toList(),
            )
          : Expanded(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ...list.map(
                    (e) => Padding(
                      padding: context.edgeBottom5,
                      child: RowItemBar(
                        e['label'].toString(),
                        e['value'].toString(),
                        textStyle: context.textTiny(color: labelColor),
                        valueStyle: context.textSmallPrice(
                          bold: true,
                          color: context.whiteLightColor,
                        ),
                        labelAlignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
            );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: isFullScreen ? EdgeInsets.zero : context.edgeTop10,
          child: AssetPriceListener(
            tradePairId: tradePair.id,
            builder: (
              context,
              fiatPrice,
              fiatCurrency,
              data,
            ) =>
                ChartHeaderPrice(
              data.displayPrice,
              fiatPrice,
              fiatCurrency,
              change: data.change,
              isVertical: !isFullScreen,
              color: labelColor,
              isFullScreen: isFullScreen,
            ),
          ),
        ),
        if (!isFullScreen) SizedBox(width: 30),
        BlocBuilder<TradeInfo24hCubit, TradeInfo24hState>(
          builder: (context, state) => renderTradeInfo24h(state.data),
        ),
      ],
    );
  }
}
