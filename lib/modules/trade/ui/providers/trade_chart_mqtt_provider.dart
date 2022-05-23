part of trade_ui_module;

class TradeChartMqttProvider extends TradeBaseMqttProvider {
  const TradeChartMqttProvider({
    @required TradeMqtt mqtt,
    @required Widget child,
    Key key,
  }) : super(key: key, mqtt: mqtt, child: child);

  @override
  Widget build(BuildContext context) {
    final pricesCubit = GetIt.I<CoinPriceCubit>();

    useEffect(() {
      final chartKLineCubit = BlocProvider.of<TradeChartKLineCubit>(context);
      final chartDepthCubit = BlocProvider.of<TradeChartDepthCubit>(context);
      final info24hCubit = BlocProvider.of<TradeInfo24hCubit>(context);
      final dealsCubit = BlocProvider.of<TradeDealsCubit>(context);
      final tickersCubit = BlocProvider.of<TradeTickersCubit>(context);

      final subChecker = getManualFetchTimer([
        TradeMqttMsgTypes.deep,
        TradeMqttMsgTypes.price,
        TradeMqttMsgTypes.chartInfo,
        TradeMqttMsgTypes.chartKLine,
        TradeMqttMsgTypes.newest,
      ], (type) {
        // Manually refresh
        switch (type) {
          case TradeMqttMsgTypes.deep:
            tickersCubit.reloadCurrent();
            chartDepthCubit.reloadCurrent();
            break;
          case TradeMqttMsgTypes.chartInfo:
            info24hCubit.reloadCurrent();
            break;
          case TradeMqttMsgTypes.chartKLine:
            chartKLineCubit.reloadCurrent();
            break;
          case TradeMqttMsgTypes.newest:
            dealsCubit.reloadCurrent();
            break;
          case TradeMqttMsgTypes.price:
            // TODO: find a better way to pass current trade pair
            pricesCubit.updateSingle(tickersCubit.state.tradePair.id);
            break;
          default:
        }
      });

      final subMessages = mqtt.messages.listen((event) {
        try {
          final tradePairId = event.topicArgs?.split('/')?.reversed?.join('/');

          if (tradePairId == null) {
            return;
          }

          switch (event.type) {
            case TradeMqttMsgTypes.deep:
              if (isAlreadyReceived(event.type, event.data['id']?.toString())) {
                return;
              }
              tickersCubit.reloadCurrent();
              chartDepthCubit.reloadCurrent();
              break;
            case TradeMqttMsgTypes.price:
              pricesCubit.updateFromMqtt(
                json: event.data as Map<String, dynamic>,
                tradePairId: tradePairId,
              );
              // FIXME: wait new api, push data of price is
              // not good enough for tickers
              // tickersCubit.updateFromPriceMqtt(
              //   tradePair: tradePair,
              //   json: event.data as Map<String, dynamic>,
              // );
              // TODO: since there is no push, call api on every price change
              if (getLastUpdateTime(TradeMqttMsgTypes.deep).inSeconds > 30) {
                tickersCubit.reloadCurrent();
                chartDepthCubit.reloadCurrent();
              }
              if (getLastUpdateTime(TradeMqttMsgTypes.newest).inSeconds > 30) {
                dealsCubit.reloadCurrent();
              }
              if (getLastUpdateTime(TradeMqttMsgTypes.chartInfo).inSeconds >
                  30) {
                info24hCubit.reloadCurrent();
              }
              if (getLastUpdateTime(TradeMqttMsgTypes.chartKLine).inSeconds >
                  45) {
                chartKLineCubit.reloadCurrent();
              }
              break;
            // case TradeMqttMsgTypes.chartInfo:
            //   info24hCubit.updateFromMqtt(json: {});
            //   break;
            // case TradeMqttMsgTypes.chartKLine:
            //   chartKLineCubit.updateFromMqtt(json: {});
            //   break;
            default:
          }

          updateLastReceivedTime(event.type);
        } catch (error, stackTrace) {
          CrashesReport().reportEvent(
            'TradeLog_02_MqttChartDecodeError',
            error,
            stackTrace,
            {
              'topic': event.topic,
            },
          );
        }
      });
      return () {
        subMessages.cancel();
        subChecker.cancel();
      };
    }, []);

    return super.build(context);
  }
}
