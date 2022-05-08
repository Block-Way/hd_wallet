part of trade_ui_module;

class TradeOrderMqttProvider extends TradeBaseMqttProvider {
  const TradeOrderMqttProvider({
    @required TradeMqtt mqtt,
    @required Widget child,
    Key key,
  }) : super(key: key, mqtt: mqtt, child: child);

  @override
  Widget build(BuildContext context) {
    final pricesCubit = GetIt.I<CoinPriceCubit>();
    final ordersCubit = GetIt.I<TradeOrdersPendingCubit>();

    useEffect(() {
      final tickersCubit = BlocProvider.of<TradeTickersCubit>(context);

      final subChecker = getManualFetchTimer([
        TradeMqttMsgTypes.deep,
        TradeMqttMsgTypes.price,
        TradeMqttMsgTypes.orderMatch,
      ], (type) {
        final tradePairId = tickersCubit.state.tradePair.id;
        // Manually refresh
        switch (type) {
          case TradeMqttMsgTypes.deep:
            if (getLastUpdateTime(TradeMqttMsgTypes.deep).inSeconds > 30) {
              tickersCubit.reloadCurrent();
            }
            break;
          case TradeMqttMsgTypes.price:
            pricesCubit.updateSingle(tradePairId);
            if (getLastUpdateTime(TradeMqttMsgTypes.deep).inSeconds > 30) {
              tickersCubit.reloadCurrent();
            }
            break;
          case TradeMqttMsgTypes.orderMatch:
            // TODO: ordersCubit should have a reloadCurrent method
            // ignore: missing_required_param
            ordersCubit.loadData(
              walletId: mqtt.walletId,
              tradePairId: tradePairId,
            );
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
              final orderTxId = event.data['id']?.toString();
              if (isAlreadyReceived(event.type, orderTxId)) {
                break;
              }
              ordersCubit.updateFromMqtt(
                txId: orderTxId,
                walletId: mqtt.walletId,
                tradePairId: tradePairId,
              );
              tickersCubit.updateFromMqttAmount(
                json: event.data as Map<String, dynamic>,
                tradePairId: tradePairId,
              );
              break;
            case TradeMqttMsgTypes.price:
              pricesCubit.updateFromMqtt(
                json: event.data as Map<String, dynamic>,
                tradePairId: tradePairId,
              );
              if (getLastUpdateTime(TradeMqttMsgTypes.change).inSeconds > 5) {
                pricesCubit.updateSingle(tradePairId);
                updateLastReceivedTime(TradeMqttMsgTypes.change);
              }
              // FIXME: wait new api, push data of price
              // is not good enough for tickers
              // tickersCubit.updateFromMqttPrice(
              //   tradePair: tradePair,
              //   json: event.data as Map<String, dynamic>,
              // );
              if (getLastUpdateTime(TradeMqttMsgTypes.price).inSeconds > 5) {
                tickersCubit.reloadCurrent();
              }
              break;
            case TradeMqttMsgTypes.orderMatch:
              final orderTxId = event.data?.toString();
              if (isAlreadyReceived(event.type, orderTxId)) {
                break;
              }
              ordersCubit.updateFromMqtt(
                txId: orderTxId,
                walletId: mqtt.walletId,
                tradePairId: tradePairId,
              );
              tickersCubit.reloadCurrent();
              break;
            default:
          }
          updateLastReceivedTime(event.type);
        } catch (error, stackTrace) {
          CrashesReport().reportEvent(
            'TradeLog_01_MqttOrderDecodeError',
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
