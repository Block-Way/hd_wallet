library hdkey_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:developer' as dev;

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_hdkey/flutter_hdkey.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';

part 'hdkey.g.dart';
part 'logic/hdkey_management_vm.dart';
part 'services/hdkey_api.dart';
part 'services/hdkey_device.dart';
part 'services/hdkey_repository.dart';
part 'store/hdkey_actions.dart';
part 'store/hdkey_state.dart';

Future<void> moduleHDKeyInitHive() async {
  //
}

Future<void> moduleHdKeyInitGetIt() async {
  GetIt.instance.registerLazySingleton<HDKeyDevice>(
    () => HDKeyDevice(),
  );
}

const kModuleHDKeySerializeModels = [
  //
];
