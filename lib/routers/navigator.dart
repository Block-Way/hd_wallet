// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import 'package:sugar/modules/admission/ui/admission.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/ui/asset.dart';
import 'package:sugar/modules/common/ui/common.dart';
import 'package:sugar/modules/community/ui/community.dart';
import 'package:sugar/modules/explorer/ui/explorer.dart';
import 'package:sugar/modules/hdkey/ui/hdkey.dart';
import 'package:sugar/modules/invest/ui/invest.dart';
import 'package:sugar/modules/invitation/ui/invitation.dart';
import 'package:sugar/modules/notice/ui/notice.dart';
import 'package:sugar/modules/open/ui/open.dart';
import 'package:sugar/modules/project/ui/project.dart';
import 'package:sugar/modules/settings/ui/settings.dart';
import 'package:sugar/modules/swap/ui/swap.dart';
import 'package:sugar/modules/trade/ui/trade.dart';
import 'package:sugar/modules/wallet/ui/wallet.dart';

export 'transitions.dart';

final navigatorKey = GlobalKey<NavigatorState>();

enum AppTabBarPages {
  home,
  trade,
  wallet,
  investment,
}

class AppNavigator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Entry Pages
      case Navigator.defaultRouteName:
        return AppSplashPage.route(settings);
      case AppMainPage.routeName:
        return AppMainPage.route(settings);
      default:
        if (settings.name.startsWith('/common')) {
          return moduleCommonInitRoutes(settings);
        }
        if (settings.name.startsWith('/wallet')) {
          return moduleWalletInitRoutes(settings);
        }
        if (settings.name.startsWith('/invitation')) {
          return moduleInvitationInitRoutes(settings);
        }
        if (settings.name.startsWith('/community')) {
          return moduleCommunityInitRoutes(settings);
        }
        if (settings.name.startsWith('/asset')) {
          return moduleAssetInitRoutes(settings);
        }
        if (settings.name.startsWith('/notice')) {
          return moduleNoticeInitRoutes(settings);
        }
        if (settings.name.startsWith('/explorer')) {
          return moduleExplorerInitRoutes(settings);
        }
        if (settings.name.startsWith('/settings')) {
          return moduleSettingsInitRoutes(settings);
        }
        if (settings.name.startsWith('/open')) {
          return moduleOpenInitRoutes(settings);
        }
        if (settings.name.startsWith('/trade')) {
          return moduleTradeInitRoutes(settings);
        }
        if (settings.name.startsWith('/invest')) {
          return moduleInvestRoutes(settings);
        }
        if (settings.name.startsWith('/project')) {
          return moduleProjectInitRoutes(settings);
        }
        if (settings.name.startsWith('/swap')) {
          return moduleSwapInitRoutes(settings);
        }
        if (settings.name.startsWith('/hdkey')) {
          return moduleHDKeyInitRoutes(settings);
        }
        if (settings.name.startsWith('/admission')) {
          return moduleAdmissionInitRoutes(settings);
        }
        return null;
    }
  }

  static Future<T> push<T>(
    String routeName, {
    Object params,
    bool replace = false,
  }) {
    if (replace == true) {
      return navigatorKey.currentState.pushReplacementNamed(
        routeName,
        arguments: params,
      );
    } else {
      return navigatorKey.currentState.pushNamed(
        routeName,
        arguments: params,
      );
    }
  }

  static void popAndPushNamed(
    String routeName, {
    Object params,
    bool replace = false,
  }) {
    if (replace) {
      navigatorKey.currentState.pushReplacementNamed(
        routeName,
        arguments: params,
      );
    } else {
      navigatorKey.currentState.popAndPushNamed(
        routeName,
        arguments: params,
      );
    }
  }

  static bool canPop() {
    return navigatorKey.currentState.canPop();
  }

  static void goBack() {
    navigatorKey.currentState.pop();
  }

  static void popWithResult(dynamic result) {
    navigatorKey.currentState.pop(result);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  static void gotoTabBar() {
    navigatorKey.currentState.popUntil(
      ModalRoute.withName(AppMainPage.routeName),
    );
  }

  static void gotoTabBarPage(AppTabBarPages page) {
    AppMainPage.changePage(page.index);
  }
}
