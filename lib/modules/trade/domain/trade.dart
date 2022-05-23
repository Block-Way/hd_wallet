library trade_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_k_chart/flutter_k_chart.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:network_flutter/network_flutter.dart';

// Project imports:
import '../../../modules/app/app.dart';
import '../../../modules/asset/domain/asset.dart';
import '../../../modules/common/domain/common.dart';
import '../../../modules/settings/domain/settings.dart';
import '../../../modules/wallet/domain/wallet.dart';
import '../../../utils/utils.dart';

part 'logic/trade_order_detail_vm.dart';
part 'logic/trade_order_list_vm.dart';
part 'logic/trade_home_vm.dart';
part 'logic/trade_pair_vm.dart';
part 'models/config.dart';
part 'models/config_coin.dart';
part 'models/config_pair.dart';
part 'models/config_pair_item.dart';
part 'models/config_pair_item_info.dart';
part 'models/enums.dart';
part 'models/trade_market.dart';
part 'models/trade_chart_resolution.dart';
part 'models/trade_deal.dart';
part 'models/trade_order.entity.dart';
part 'models/trade_preference.entity.dart';
part 'models/trade_order_detail.dart';
part 'models/trade_pair.dart';
part 'models/trade_info_24h.dart';
part 'models/trade_ticker.dart';

part 'services/trade_api.dart';
part 'services/trade_mqtt.dart';
part 'services/trade_repository.dart';
part 'cubit/trade_chart_depth.cubit.dart';
part 'cubit/trade_info.cubit.dart';
part 'cubit/trade_chart_kline.cubit.dart';
part 'cubit/trade_deals.cubit.dart';
part 'cubit/trade_orders.cubit.dart';
part 'cubit/trade_orders_deal_fail.cubit.dart';
part 'cubit/trade_orders_history.cubit.dart';
part 'cubit/trade_orders_pending.cubit.dart';
part 'cubit/trade_tickers.cubit.dart';
part 'store/trade_actions.config.dart';
part 'store/trade_actions.dart';
part 'store/trade_actions.mqtt.dart';
part 'store/trade_actions.order.cancel.dart';
part 'store/trade_actions.order.create.dart';
part 'store/trade_actions.order.approve.dart';
part 'store/trade_actions.order.dart';
part 'store/trade_errors.dart';
part 'store/trade_state.dart';
part 'trade.g.dart';

const int kHiveTypeTradeOrder = 30;
const int kHiveTypeTradeOrderStatus = 31;
const int kHiveTypeTradePreference = 32;

Future<void> moduleTradeInitHive() async {
  Hive.registerAdapter(TradeOrderAdapter());
  Hive.registerAdapter(TradeOrderStatusAdapter());
  Hive.registerAdapter(TradePreferenceAdapter());

  await TradeRepository().initializeCache();
}

Future<void> moduleTradeInitGetIt() async {
  GetIt.instance.registerLazySingleton<TradeMqtt>(
    () => TradeMqtt(),
  );
  GetIt.instance.registerLazySingleton<TradeOrdersPendingCubit>(
    () => TradeOrdersPendingCubit(),
  );
}

const kModuleTradeSerializeModels = [
  TradeConfig,
  TradeConfigCoin,
  TradeConfigPair,
  TradeConfigPairItem,
  TradeConfigPairItemInfo,
  TradePair,
  TradeMarket,
  TradeDeal,
  TradeTicker,
  TradeInfo24h,
  TradeOrderDetail,
  TradeOrderDetailItem,
];
