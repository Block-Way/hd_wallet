library notice_domain_module;

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/utils/utils.dart';

part 'logic/notice_detail_vm.dart';
part 'logic/notice_list_vm.dart';
part 'models/notice_info.dart';
part 'services/notice_api.dart';
part 'services/notice_repository.dart';
part 'store/notice_actions.dart';
part 'store/notice_state.dart';
part 'notice.g.dart';

Future<void> moduleNoticeInitHive() async {
//
}

Future<void> moduleNoticeInitGetIt() async {
  //
}

const kModuleNoticeSerializeModels = [
  NoticeInfo,
];
