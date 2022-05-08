library wallet_ui_module;

// Dart imports:
import 'dart:async';
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dabank/dabank_window_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/common/ui/common.dart';
import 'package:sugar/modules/invitation/ui/invitation.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'dialogs/wallet_create_dialog.dart';
part 'dialogs/wallet_double_trans_dialog.dart';
part 'dialogs/wallet_password_dialog.dart';
part 'screens/wallet_backup.dart';
part 'screens/wallet_change_name.dart';
part 'screens/wallet_change_password.dart';
part 'screens/wallet_create.dart';
part 'screens/wallet_export.dart';
part 'screens/wallet_import.dart';
part 'screens/wallet_management.dart';
part 'screens/wallet_path_select.dart';
part 'widgets/mnemonic_backup_img_tip.dart';
part 'widgets/mnemonic_backup_msg_tip.dart';
part 'widgets/mnemonic_card.dart';
part 'widgets/password_check_tip.dart';
part 'widgets/wallet_create_buttons.dart';

Route<dynamic> moduleWalletInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case WalletManagementPage.routeName:
      return WalletManagementPage.route(settings);
    case WalletCreatePage.routeName:
      return WalletCreatePage.route(settings);
    case WalletBackupPage.routeName:
      return WalletBackupPage.route(settings);
    case WalletImportPage.routeName:
      return WalletImportPage.route(settings);
    case WalletExportPage.routeName:
      return WalletExportPage.route(settings);
    case WalletChangePasswordPage.routeName:
      return WalletChangePasswordPage.route(settings);
    case WalletChangeNamePage.routeName:
      return WalletChangeNamePage.route(settings);
    case WalletPathSelectPage.routeName:
      return WalletPathSelectPage.route(settings);
    default:
      return null;
  }
}
