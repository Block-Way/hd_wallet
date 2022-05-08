library explorer_ui_module;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/common/ui/common.dart';
import 'package:sugar/modules/explorer/domain/explorer.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'screens/explorer_home.dart';
part 'widgets/explorer_bar.dart';

Route<dynamic> moduleExplorerInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case ExplorerHomePage.routeName:
      return ExplorerHomePage.route(settings);

    default:
      return null;
  }
}
