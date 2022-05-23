library wallet_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// Flutter imports:
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ed25519_dart_base/ed25519_dart.dart';
import 'package:hex/hex.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:network_flutter/network_flutter.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wallet_sdk_flutter/wallet_sdk_flutter.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/utils/utils.dart';

part 'logic/common_with.dart';
part 'logic/wallet_backup_vm.dart';
part 'logic/wallet_management_vm.dart';
part 'models/broadcast_info.entity.dart';
part 'models/coin_address.entity.dart';
part 'models/coin_balance.entity.dart';
part 'models/coin_info.entity.dart';
part 'models/wallet.config.dart';
part 'models/wallet.entity.dart';
part 'models/wallet.private.dart';
part 'models/wallet.path.dart';
part 'models/wallet.template.dart';
part 'models/wallet.withdraw.dart';
part 'services/wallet_api.dart';
part 'services/wallet_repository.dart';
part 'store/wallet_actions.broadcast.dart';
part 'store/wallet_actions.create.dart';
part 'store/wallet_actions.dart';
part 'store/wallet_actions.dex.dart';
part 'store/wallet_actions.management.dart';
part 'store/wallet_actions.wallet.dart';
part 'store/wallet_actions.withdraw.before.dart';
part 'store/wallet_actions.withdraw.submit.dart';
part 'store/wallet_errors.dart';
part 'store/wallet_state.dart';
part 'utils/wallet_path_utils.dart';
part 'utils/wallet_fee_utils.dart';
part 'wallet.g.dart';

const int kHiveTypeWallet = 10;
const int kHiveTypeWalletType = 11;
const int kHiveTypeWalletStatus = 15;
const int kHiveTypeCoinInfo = 12;
const int kHiveTypeCoinAddress = 13;
const int kHiveTypeCoinBalance = 14;
const int kHiveTypeBroadcastTxType = 50;
const int kHiveTypeBroadcastTxInfo = 51;

Future<void> moduleWalletInitHive() async {
  Hive.registerAdapter(WalletAdapter());
  Hive.registerAdapter(WalletTypeAdapter());
  Hive.registerAdapter(WalletStatusAdapter());
  Hive.registerAdapter(CoinInfoAdapter());
  Hive.registerAdapter(CoinAddressAdapter());
  Hive.registerAdapter(CoinBalanceAdapter());
  Hive.registerAdapter(BroadcastTxTypeAdapter());
  Hive.registerAdapter(BroadcastTxInfoAdapter());

  await WalletRepository().initializeCache();
}

Future<void> moduleWalletInitGetIt() async {
  //
}

const kModuleWalletSerializeModels = [
  //
];
