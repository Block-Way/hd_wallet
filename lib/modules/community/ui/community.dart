library community_ui_module;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:network_flutter/network_flutter.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/asset/ui/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/common/ui/common.dart';
import 'package:sugar/modules/community/domain/community.dart';
import 'package:sugar/modules/home/ui/home.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'dialogs/join_status_dialog.dart';
part 'dialogs/join_onchain_dialog.dart';
part 'dialogs/create_confirm_agreement.dart';
part 'screens/community_team.dart';
part 'screens/community_detail.dart';
part 'screens/community_create.dart';
part 'screens/community_blacklist.dart';
part 'screens/community_join.dart';
part 'screens/community_member.dart';
part 'widgets/community_list_item.dart';
part 'widgets/community_type_card.dart';
part 'widgets/community_quick_entry.dart';
part 'process/community_join_process.dart';

Route<dynamic> moduleCommunityInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case CommunityTeamPage.routeName:
      return CommunityTeamPage.route(settings);
    case CommunityMemberPage.routeName:
      return CommunityMemberPage.route(settings);
    case CommunityDetailPage.routeName:
      return CommunityDetailPage.route(settings);
    case CommunityCreatePage.routeName:
      return CommunityCreatePage.route(settings);
    case CommunityJoinPage.routeName:
      return CommunityJoinPage.route(settings);
    case CommunityBlacklistPage.routeName:
      return CommunityBlacklistPage.route(settings);

    default:
      return null;
  }
}
