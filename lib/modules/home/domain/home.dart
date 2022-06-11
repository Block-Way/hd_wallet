library home_domain_module;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:sugar/modules/admission/domain/admission.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/community/domain/community.dart';
import 'package:sugar/modules/notice/domain/notice.dart';
import 'package:sugar/modules/trade/domain/trade.dart';
import 'package:sugar/utils/utils.dart';

part 'home.g.dart';
part 'logic/home_page_vm.dart';
part 'models/home_banner.dart';
part 'services/home_api.dart';
part 'services/home_repository.dart';
part 'store/home_actions.dart';
part 'store/home_state.dart';

Future<void> moduleHomeInitHive() async {
//
}

Future<void> moduleHomeInitGetIt() async {
  //
}

const kModuleHomeSerializeModels = [
  HomeBanner,
];
