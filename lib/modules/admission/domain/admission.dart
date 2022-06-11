library admission_domain_module;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:wallet_sdk_flutter/wallet_sdk_flutter.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/utils/utils.dart';

part 'logic/admission_create_vm.dart';
part 'models/admission_info.dart';
part 'models/admission_config.dart';
part 'models/admission_condition.dart';
part 'services/admission_api.dart';
part 'services/admission_repository.dart';
part 'store/admission_actions.dart';
part 'store/admission_actions.config.dart';
part 'store/admission_actions.submit.dart';
part 'store/admission_state.dart';
part 'admission.g.dart';

Future<void> moduleAdmissionInitHive() async {
//
}

Future<void> moduleAdmissionInitGetIt() async {
  //
}

const kModuleAdmissionSerializeModels = [
  AdmissionInfo,
  AdmissionConfig,
];
