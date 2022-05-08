library admission_ui_module;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/admission/domain/admission.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/asset/ui/asset.dart';
import 'package:sugar/modules/common/ui/common.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/modules/wallet/ui/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'dialog/admission_submit_dialog.dart';
part 'screens/admission_create.dart';
part 'widgets/admission_latest.dart';
part 'process/admission_submit_process.dart';

Route<dynamic> moduleAdmissionInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AdmissionCreatePage.routeName:
      return AdmissionCreatePage.route(settings);
    default:
      return null;
  }
}
