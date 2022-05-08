library project_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Builder;

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:network_flutter/network_flutter.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/project/ui/project.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/modules/wallet/ui/wallet.dart';
import 'package:sugar/utils/utils.dart';

// Package imports:
part 'project.g.dart';
part 'logic/project_apply_vm.dart';
part 'logic/project_detail_vm.dart';
part 'logic/project_list_vm.dart';
part 'models/project_create.mint.dart';
part 'models/project_config.dart';
part 'models/project_create.params.dart';
part 'models/project_info.dart';
part 'services/project_repository.dart';
part 'services/project_api.dart';
part 'store/project_actions.dart';
part 'store/project_actions.submit.dart';
part 'store/project_state.dart';
part 'utils/project_submit_process.dart';

const kModuleProjectSerializeModels = [
  ProjectInfo,
  ProjectConfig,
  ProjectCreateMint,
  ProjectCreateParams,
];
