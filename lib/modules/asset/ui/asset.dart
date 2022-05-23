library asset_ui_module;

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/common/ui/common.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/modules/wallet/ui/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'listeners/asset_balance_listener.dart';
part 'listeners/asset_price_listener.dart';
part 'screens/asset_deposit.dart';
part 'screens/asset_detail.dart';
part 'screens/asset_list.dart';
part 'screens/asset_wallet_select.dart';
part 'screens/asset_management.dart';
part 'screens/asset_transaction.dart';
part 'screens/asset_withdraw.dart';
part 'screens/main_tab.dart';
part 'screens/asset_address_add.dart';
part 'screens/asset_address_list.dart';
part 'screens/asset_dpos_list.dart';
part 'screens/asset_dpos_detail.dart';
part 'widgets/asset_list_item.dart';
part 'widgets/asset_bg_circle.dart';
part 'widgets/transaction_list_item.dart';
part 'widgets/trans_drop_item.dart';
part 'widgets/asset_withdraw_fee.dart';
part 'widgets/asset_coin_box.dart';
part 'widgets/asset_wallet_card.dart';
part 'widgets/asset_wallet_status.dart';
part 'process/asset_withdraw_process.dart';

Route<dynamic> moduleAssetInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AssetWalletSelectPage.routeName:
      return AssetWalletSelectPage.route(settings);
    case AssetDepositPage.routeName:
      return AssetDepositPage.route(settings);
    case AssetWithdrawPage.routeName:
      return AssetWithdrawPage.route(settings);
    case AssetDetailPage.routeName:
      return AssetDetailPage.route(settings);
    case AssetManagementPage.routeName:
      return AssetManagementPage.route(settings);
    case AssetTransactionPage.routeName:
      return AssetTransactionPage.route(settings);
    case AssetAddressAddPage.routeName:
      return AssetAddressAddPage.route(settings);
    case AssetAddressListPage.routeName:
      return AssetAddressListPage.route(settings);
    case AssetDposList.routeName:
      return AssetDposList.route(settings);
    case AssetDposDetail.routeName:
      return AssetDposDetail.route(settings);

    default:
      return null;
  }
}
