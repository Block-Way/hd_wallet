library notice_ui_module;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/notice/domain/notice.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/widgets/widgets.dart';

part 'screens/notice_detail.dart';
part 'screens/notice_list.dart';
part 'widgets/notice_list_item.dart';

Route<dynamic>? moduleNoticeInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case NoticeListPage.routeName:
      return NoticeListPage.route(settings);
    case NoticeDetailPage.routeName:
      return NoticeDetailPage.route(settings);
    default:
      return null;
  }
}
