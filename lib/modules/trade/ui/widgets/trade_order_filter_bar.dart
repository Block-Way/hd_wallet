part of trade_ui_module;

class FilterType {
  FilterType({
    this.id,
    this.label,
  });
  final String? id;
  final String? label;
}

class _FilterHeader {
  _FilterHeader({
    this.id,
    this.title,
    this.onTap,
  });

  final String? id;
  final String? title;
  final Function? onTap;
}

class TradeOrderFilterBar extends HookWidget {
  TradeOrderFilterBar({
    required this.onChange,
    required this.filterTradePair,
    Key? key,
    this.isHistory = false,
  }) : super(key: key);

  final Function(
    String tradeSide,
    String status,
  ) onChange;
  final bool isHistory;
  final TradePair filterTradePair;

  final tradeSide = [
    FilterType(id: 'all', label: tr('global:btn_all')),
    FilterType(id: 'buy', label: tr('trade:btn_buy')),
    FilterType(id: 'sale', label: tr('trade:btn_sell')),
  ];
  final status = [
    FilterType(
      id: TradeOrderApiStatus.history,
      label: tr('global:btn_all'),
    ),
    FilterType(
      id: TradeOrderApiStatus.traded,
      label: tr('trade:order_status_traded'),
    ),
    FilterType(
      id: TradeOrderApiStatus.cancelled,
      label: tr('trade:order_status_cancelled'),
    ),
    FilterType(
      id: TradeOrderApiStatus.partialCancel,
      label: tr('trade:order_status_partial_cancel'),
    ),
    FilterType(
      id: TradeOrderApiStatus.dusts,
      label: tr('trade:order_status_dusts'),
    ),
    FilterType(
      id: TradeOrderApiStatus.matchFailed,
      label: tr('trade:order_status_match_failed'),
    ),
    FilterType(
      id: TradeOrderApiStatus.failed,
      label: tr('trade:order_status_failed'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedTradePair = useState<TradePair?>(null);
    final selectedTradeSide = useState<FilterType>(tradeSide.first);
    final selectedStatus = useState<FilterType>(status.first);

    useEffect(() {
      selectedTradePair.value = filterTradePair;
      return null;
    }, [filterTradePair]);

    void doApplyFilters() {
      onChange.call(
        selectedTradeSide.value.id ?? '',
        selectedStatus.value.id ?? '',
      );
    }

    final filterList = [
      _FilterHeader(
        id: 'tradePair',
        title: selectedTradePair.value == null
            ? tr('trade:order_list_filter_trade_pair')
            : selectedTradePair.value?.id,
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      _FilterHeader(
        id: 'tradeSide',
        title: selectedTradeSide.value.id == 'all'
            ? tr('trade:order_list_filter_trade_side')
            : selectedTradeSide.value.label,
        onTap: () {
          showOrderListTradeFilterDialog(
            context,
            tradeSide,
            selectedTradeSide.value.id ?? '',
            onSelect: (type) {
              if (type.id != selectedTradeSide.value.id) {
                selectedTradeSide.value = type;
                doApplyFilters();
              }
            },
          );
        },
      ),
      if (isHistory)
        _FilterHeader(
          id: 'status',
          title: selectedStatus.value.id == TradeOrderApiStatus.history
              ? tr('trade:order_list_filter_status')
              : selectedStatus.value.label,
          onTap: () {
            showOrderListTradeFilterDialog(
              context,
              status,
              selectedStatus.value.id ?? '',
              onSelect: (type) {
                if (type.id != selectedStatus.value.id) {
                  selectedStatus.value = type;
                  doApplyFilters();
                }
              },
            );
          },
        ),
    ];

    return Row(
      children: filterList
          .asMap()
          .keys
          .map(
            (index) => Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: CSButton(
                      label: filterList[index].title ?? '',
                      textStyle: context.textSecondary(
                        bold: true,
                        color: context.bodyColor,
                        fontWeight: FontWeight.normal,
                      ),
                      cmpRight: Padding(
                        padding: EdgeInsets.only(
                          top: 2,
                          left: 8,
                        ),
                        child: Icon(
                          CSIcons.ArrowDownBold,
                          size: 5,
                          color: context.placeholderColor,
                        ),
                      ),
                      borderRadius: 0,
                      margin: EdgeInsets.zero,
                      autoWidth: true,
                      height: 40,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        filterList[index].onTap?.call();
                      },
                    ),
                  ),
                  if (index < filterList.length - 1)
                    Container(
                      width: 1,
                      height: 12,
                      color: context.borderColor,
                    ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
