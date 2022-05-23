library common_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:network_flutter/network_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../../../modules/app/app.dart';
import '../../../utils/utils.dart';

part 'common.g.dart';
part 'logic/app_common_vm.dart';
part 'models/coin_config.dart';
part 'models/config.dart';
part 'models/config_coin.dart';
part 'models/config_coin_fee.dart';
part 'models/config_otc.dart';
part 'models/config_system.dart';
part 'models/config_system_app.dart';
part 'models/config_update.dart';
part 'models/config_update_data.dart';
part 'models/enums.dart';
part 'models/settings.entity.dart';
part 'services/common_api.dart';
part 'services/common_repository.dart';
part 'store/common_actions.config.dart';
part 'store/common_actions.dart';
part 'store/common_actions.load.dart';
part 'store/common_errors.dart';
part 'store/common_state.dart';

const int kHiveTypeSettings = 1;

Future<void> moduleCommonInitHive() async {
  Hive.registerAdapter(SettingsAdapter());

  await CommonRepository().initializeCache();
}

Future<void> moduleCommonInitGetIt() async {
  GetIt.instance.registerLazySingleton<CoinConfig>(
    () => CoinConfig(),
  );
}

const kModuleCommonSerializeModels = [
  Config,
  ConfigCoin,
  ConfigOtc,
  ConfigUpdate,
  ConfigSystem,
  ConfigSystemApp,
  ConfigUpdateData,
  ConfigCoinFee,
];
