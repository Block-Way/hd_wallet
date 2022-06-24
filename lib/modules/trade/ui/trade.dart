library trade_ui_module;

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:async_redux/src/store.dart';
//import 'package:async_redux/async_redux.dart';
// import 'package:mars/modules/wallet/domain/wallet.dart';
// import 'package:mars/modules/app/app.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_k_chart/flutter_k_chart.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:date_format/date_format.dart';

// Project imports:
import 'package:sugar/dialogs/dialogs.dart';
import 'package:sugar/modules/app/app.dart';
import 'package:sugar/modules/asset/domain/asset.dart';
import 'package:sugar/modules/asset/ui/asset.dart';
import 'package:sugar/modules/common/domain/common.dart';
import 'package:sugar/modules/trade/domain/trade.dart';
import 'package:sugar/modules/wallet/domain/wallet.dart';
import 'package:sugar/modules/wallet/ui/wallet.dart';
import 'package:sugar/routers/navigator.dart';
import 'package:sugar/themes/themes.dart';
import 'package:sugar/utils/utils.dart';
import 'package:sugar/widgets/widgets.dart';

part 'dialogs/trade_transaction_dialog.dart';
part 'dialogs/trade_order_list_dialog.dart';
part 'providers/trade_base_mqtt_provider.dart';
part 'providers/trade_chart_mqtt_provider.dart';
part 'providers/trade_order_mqtt_provider.dart';
part 'process/order_cancel_process.dart';
part 'process/order_submit_process.dart';
part 'screens/main_tab.dart';
part 'screens/trade_chart.dart';
part 'screens/trade_home.dart';
part 'screens/trade_order_closing.dart';
part 'screens/trade_order_detail.dart';
part 'screens/trade_order_list.dart';
part 'widgets/chart_footer.dart';
part 'widgets/chart_header.dart';
part 'widgets/chart_kline.dart';
part 'widgets/chart_kline_resolutions.dart';
part 'widgets/chart_order_tickers.dart';
part 'widgets/ticker_item.dart';
part 'widgets/ticker_list.dart';
part 'widgets/chart_header_price.dart';
part 'widgets/row_item_bar.dart';
part 'widgets/trade_select_drawer.dart';
part 'widgets/chart_order_deals.dart';
part 'widgets/home_tickers_card.dart';
part 'widgets/trade_order_cancel_item.dart';
part 'widgets/trade_order_filter_bar.dart';
part 'widgets/home_input_card.dart';
part 'widgets/trade_order_list_item.dart';
part 'widgets/home_orders_card.dart';
part 'widgets/trade_pair_item.dart';
part 'widgets/trade_title.dart';

Route<dynamic>? moduleTradeInitRoutes(RouteSettings settings) {
  switch (settings.name) {
    case TradeChartPage.routeName:
      return TradeChartPage.route(settings);
    case TradeOrderListPage.routeName:
      return TradeOrderListPage.route(settings);
    case TradeOrderDetailPage.routeName:
      return TradeOrderDetailPage.route(settings);
    case TradeOrderClosingPage.routeName:
      return TradeOrderClosingPage.route(settings);
    default:
      return null;
  }
}
