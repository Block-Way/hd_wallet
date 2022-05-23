library invitation_domain_module;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:dio/dio.dart';
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
import '../../../utils/utils.dart';
import '../../app/app.dart';
import '../../asset/domain/asset.dart';
import '../../wallet/domain/wallet.dart';

part 'invitation.g.dart';
part 'logic/common_with.dart';
part 'logic/invitation_create_vm.dart';
part 'logic/invitation_list_vm.dart';
part 'logic/invitation_select_vm.dart';
part 'models/invitation.dart';
part 'models/invitation_code.data.dart';
part 'models/invitation_code.entity.dart';
part 'services/invitation_api.dart';
part 'services/invitation_repository.dart';
part 'store/invitation_actions.dart';
part 'store/invitation_actions.submit.dart';
part 'store/invitation_errors.dart';
part 'store/invitation_state.dart';
part 'utils/invitation_code_utils.dart';

const int kHiveTypeInvitationCode = 60;

Future<void> moduleInvitationInitHive() async {
  Hive.registerAdapter(InvitationCodeAdapter());

  await InvitationRepository().initializeCache();
}

Future<void> moduleInvitationInitGetIt() async {
  //
}

const kModuleInvitationSerializeModels = [
  //
];
