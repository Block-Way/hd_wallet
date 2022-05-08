part of trade_ui_module;

String getOrderListTitle(String state) {
  final tradeOrderOptions = [
    CSOptionsItem(
      label: tr('trade:order_list_tab_pending'),
      value: TradeOrderApiStatus.pending,
    ),
    CSOptionsItem(
      label: tr('trade:order_list_tab_history'),
      value: TradeOrderApiStatus.history,
    ),
    CSOptionsItem(
      label: tr('trade:order_list_tab_cancel'),
      value: TradeOrderApiStatus.cancelled,
    ),
  ];

  final item = tradeOrderOptions.firstWhere(
    (e) => e.value == state,
    orElse: () => null,
  );
  return item != null ? item.label : '';
}

void showOrderListMenuDialog(
  BuildContext context,
  String activeMenu,
  Function(String type) onSelect,
) {
  final tradeOrderOptions = [
    CSOptionsItem(
      label: tr('trade:order_list_tab_pending'),
      value: TradeOrderApiStatus.pending,
      color: activeMenu == TradeOrderApiStatus.pending
          ? context.primaryColor
          : null,
    ),
    CSOptionsItem(
      label: tr('trade:order_list_tab_history'),
      value: TradeOrderApiStatus.history,
      color: activeMenu == TradeOrderApiStatus.history
          ? context.primaryColor
          : null,
    ),
    CSOptionsItem(
      label: tr('trade:order_list_tab_cancel'),
      value: TradeOrderApiStatus.cancelled,
      color: activeMenu == TradeOrderApiStatus.cancelled
          ? context.primaryColor
          : null,
    ),
  ];

  showOptionsDialog(
    context,
    options: tradeOrderOptions,
    onSelected: onSelect,
  );
}

void showOrderListTradeFilterDialog(
  BuildContext context,
  List<FilterType> data,
  String activeId, {
  Function(FilterType type) onSelect,
}) {
  final list = data
      .map((e) => CSOptionsItem(
            label: e.label,
            value: e.id,
            color: activeId == e.id ? context.primaryColor : null,
          ))
      .toList();

  showOptionsDialog(
    context,
    options: list,
    onSelected: (value) {
      onSelect(data.firstWhere((e) => e.id == value));
    },
  );
}

void showOrderCloseMenuDialog(
  BuildContext context,
  String activeMenu,
  Function(String type) onSelect,
) {
  final tradeOrderOptions = [
    CSOptionsItem(
      label: tr('trade:order_list_tab_pending'),
      value: TradeOrderApiStatus.pending,
      color: activeMenu == TradeOrderApiStatus.pending
          ? context.primaryColor
          : null,
    ),
    CSOptionsItem(
      label: tr('trade:order_list_tab_cancel'),
      value: TradeOrderApiStatus.cancelled,
      color: activeMenu == TradeOrderApiStatus.cancelled
          ? context.primaryColor
          : null,
    ),
  ];
  showOptionsDialog(
    context,
    options: tradeOrderOptions,
    onSelected: onSelect,
  );
}
