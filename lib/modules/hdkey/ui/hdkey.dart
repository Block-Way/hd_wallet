library hdkey_ui_module;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/hdkey/domain/hdkey.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'dialogs/hdkey_connect_dialog.dart';
part 'dialogs/hdkey_import_dialog.dart';
part 'listeners/hdkey_device_listener.dart';
part 'providers/hdkey_device_provider.dart';
part 'screens/hdkey_management.dart';
part 'screens/hdkey_mnemonic_import.dart';
part 'screens/hdkey_mnemonic_list.dart';
part 'widgets/hdkey_device_authorize.dart';
part 'widgets/hdkey_device_empty.dart';
part 'widgets/hdkey_mnemonic_item.dart';

Route<dynamic> moduleHDKeyInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case HDKeyMnemonicListPage.routeName:
      return HDKeyMnemonicListPage.route(settings);
    case HDKeyMnemonicImportPage.routeName:
      return HDKeyMnemonicImportPage.route(settings);
    case HDKeyManagementPage.routeName:
      return HDKeyManagementPage.route(settings);

    default:
      return null;
  }
}
