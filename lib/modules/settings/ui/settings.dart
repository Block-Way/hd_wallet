library settings_ui_module;

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/invitation/domain/invitation.dart';
import 'package:sugar/modules/open/ui/open.dart';
import 'package:sugar/modules/settings/domain/settings.dart';
import 'package:sugar/modules/trade/domain/trade.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'screens/settings_dev.dart';
part 'screens/settings_testnet.dart';

Route<dynamic>? moduleSettingsInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SettingsDevPage.routeName:
      return SettingsDevPage.route(settings);
    case SettingsTestnetPage.routeName:
      return SettingsTestnetPage.route(settings);
    default:
      return null;
  }
}
