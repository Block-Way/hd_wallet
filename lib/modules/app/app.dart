library app_module;

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter/services.dart';

// Package imports:
import 'package:amplitude_flutter/amplitude.dart';
import 'package:async_redux/async_redux.dart';
import 'package:async_redux/local_persist.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:convert/convert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart' hide Request;
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/admission/domain/admission.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/asset/ui/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/common/ui/common.dart';
import 'package:sugar/modules/community/domain/community.dart';
import 'package:sugar/modules/hdkey/domain/hdkey.dart';
import 'package:sugar/modules/home/domain/home.dart';
import 'package:sugar/modules/home/ui/home.dart';
import 'package:sugar/modules/invest/domain/invest.dart';
import 'package:sugar/modules/invest/ui/invest.dart';
import 'package:sugar/modules/invitation/domain/invitation.dart';
import 'package:sugar/modules/notice/domain/notice.dart';
import 'package:sugar/modules/project/domain/project.dart';
import 'package:sugar/modules/settings/domain/settings.dart';
import 'package:sugar/modules/settings/ui/settings.dart';
import 'package:sugar/modules/swap/domain/swap.dart';
import 'package:sugar/modules/trade/domain/trade.dart';
import 'package:sugar/modules/trade/ui/trade.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/common/offline.dart';
import 'package:sugar/widgets/widgets.dart';

export 'package:sentry_flutter/sentry_flutter.dart' show SentryFlutter;

export 'setup/app_serializers.dart';

part 'app.g.dart';
part 'config/app_coins.dart';
part 'config/app_config.dart';
part 'config/app_constants.dart';
part 'config/app_languages.dart';
part 'config/app_links.dart';
part 'permission/module_permission.dart';
part 'permission/module_permission_vm.dart';
part 'permission/module_permission_view.dart';
part 'setup/app_actions.dart';
part 'setup/app_errors.dart';
part 'setup/app_getit.dart';
part 'setup/app_hive.dart';
part 'setup/app_localizations.dart';
part 'setup/app_persistor.dart';
part 'setup/app_state.dart';
part 'tracking/analytics.dart';
part 'tracking/crashes.dart';
part 'ui/screens/main_page.dart';
part 'ui/screens/splash_page.dart';
part 'ui/screens/welcome_page.dart';
part 'ui/widgets/app_drawer.dart';
part 'ui/widgets/app_drawer_background.dart';
part 'ui/widgets/app_drawer_menu_lang.dart';
part 'ui/widgets/app_drawer_menu_link.dart';
part 'ui/widgets/app_drawer_menu_social.dart';
part 'ui/widgets/app_drawer_menu_tap.dart';
part 'ui/widgets/app_drawer_menu_version.dart';

Future<void> moduleAppInitGetIt() async {
  GetIt.instance.registerLazySingleton<ModulePermissionUtils>(
    () => ModulePermissionUtils(),
  );
}
