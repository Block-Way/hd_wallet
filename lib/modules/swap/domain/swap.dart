library swap_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive/hive.dart';
import 'package:network_flutter/network_flutter.dart';
import 'package:wallet_sdk_flutter/wallet_sdk_flutter.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/utils/utils.dart';

part 'logic/swap_create_vm.dart';
part 'logic/swap_list_vm.dart';
part 'models/config.dart';
part 'models/config_coin.dart';
part 'models/swap.entity.dart';
part 'services/swap_api.dart';
part 'services/swap_repository.dart';
part 'store/swap_actions.dart';
part 'store/swap_actions.config.dart';
part 'store/swap_actions.list.dart';
part 'store/swap_actions.order.approve.dart';
part 'store/swap_actions.order.create.dart';
part 'store/swap_state.dart';
part 'store/swap_errors.dart';
part 'swap.g.dart';

// Swap
const int kHiveTypeSwapStatus = 40;
const int kHiveTypeSwap = 41;

Future<void> moduleSwapInitHive() async {
  Hive.registerAdapter(SwapAdapter());
  Hive.registerAdapter(SwapStatusAdapter());

  await SwapRepository().initializeCache();
}

Future<void> moduleSwapInitGetIt() async {
  //
}

const kModuleSwapSerializeModels = [
  SwapConfig,
  SwapConfigCoin,
];
