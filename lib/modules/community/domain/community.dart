library community_domain_module;

// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

// Project imports:
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/invitation/domain/invitation.dart';
import 'package:sugar/utils/utils.dart';

part 'logic/community_team_vm.dart';
part 'logic/community_detail_vm.dart';
part 'logic/community_create_vm.dart';
part 'logic/community_join_vm.dart';
part 'logic/community_blacklist_vm.dart';
part 'models/community_utils.dart';
part 'models/community_config.dart';
part 'models/community_info.dart';
part 'models/community_team.dart';
part 'models/community_team_options.dart';
part 'models/community_member_info.dart';
part 'models/community_member.dart';
part 'models/team_join.params.dart';
part 'models/team_create.params.dart';
part 'models/community_ecological.dart';
part 'services/community_api.dart';
part 'services/community_repository.dart';
part 'store/community_actions.dart';
part 'store/community_actions.config.dart';
part 'store/community_state.dart';
part 'community.g.dart';

Future<void> moduleCommunityInitHive() async {
  //
}

Future<void> moduleCommunityInitGetIt() async {
  //
}

const kModuleCommunitySerializeModels = [
  CommunityTeam,
  CommunityTeamOptions,
  CommunityConfig,
  CommunityMemberInfo,
  CommunityMember,
];
