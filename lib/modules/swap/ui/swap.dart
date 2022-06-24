library swap_ui_module;

// Dart imports:
import 'dart:async';
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/asset/ui/asset.dart';
import 'package:sugar/modules/swap/domain/swap.dart';
import 'package:sugar/modules/trade/ui/trade.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/modules/wallet/ui/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'dialogs/swap_submit_dialog.dart';
part 'dialogs/swap_tip_dialog.dart';
part 'screens/swap_create.dart';
part 'screens/swap_list.dart';
part 'widgets/swap_item.dart';
part 'widgets/swap_coin.dart';
part 'widgets/swap_approve_balance.dart';
part 'process/swap_submit_process.dart';

Route<dynamic>? moduleSwapInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SwapCreatePage.routeName:
      return SwapCreatePage.route(settings);
    case SwapListPage.routeName:
      return SwapListPage.route(settings);
    default:
      return null;
  }
}
