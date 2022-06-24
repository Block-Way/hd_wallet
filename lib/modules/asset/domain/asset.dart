library asset_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/crypto/hah.dart';

part 'asset.g.dart';

part 'logic/asset_deposit_vm.dart';
part 'logic/asset_detail_vm.dart';
part 'logic/asset_address_vm.dart';
part 'logic/asset_list_vm.dart';
part 'logic/asset_management_vm.dart';
part 'logic/asset_transaction_vm.dart';
part 'logic/asset_withdraw_vm.dart';
part 'logic/common_with.dart';
part 'models/asset_coin.dart';
part 'models/asset_price.dart';
part 'models/prices.entity.dart';
part 'models/asset_balance.dart';
part 'models/transaction.entity.dart';
part 'models/asset_address.dart';
part 'services/asset_api.dart';
part 'services/asset_repository.dart';
part 'store/asset_actions.balance.dart';
part 'store/asset_actions.dart';
part 'store/asset_actions.address.dart';
part 'store/asset_actions.detail.dart';
part 'store/asset_actions.notifications.dart';
part 'store/asset_actions.prices.dart';
part 'store/asset_actions.transaction.dart';
part 'store/asset_errors.dart';
part 'store/asset_state.dart';
part 'cubit/asset_balance.cubit.dart';
part 'cubit/coin_price.cubit.dart';
part 'cubit/asset_detail.cubit.dart';
part 'cubit/asset_dpos.cubit.dart';
part 'cubit/asset_dpos_trans.cubit.dart';
part 'cubit/asset_transaction.cubit.dart';
part 'cubit/fiat_price.cubit.dart';
part 'store/utils.dart';

const int kHiveTypePrices = 20;
const int kHiveTypeTransaction = 21;
const int kHiveTypeTransactionType = 22;

Future<void> moduleAssetInitHive() async {
  Hive.registerAdapter(PricesAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());

  await AssetRepository().initializeCache();
}

Future<void> moduleAssetInitGetIt() async {
  GetIt.instance.registerLazySingleton<FiatPriceCubit>(
    () => FiatPriceCubit(),
  );
  GetIt.instance.registerLazySingleton<CoinPriceCubit>(
    () => CoinPriceCubit(),
  );
  GetIt.instance.registerLazySingleton<AssetBalanceCubit>(
    () => AssetBalanceCubit(),
  );
  GetIt.instance.registerLazySingleton<AssetTransactionCubit>(
    () => AssetTransactionCubit(),
  );
}

const kModuleAssetSerializeModels = [
  AssetCoin,
  AssetPrice,
  AssetAddress,
];
