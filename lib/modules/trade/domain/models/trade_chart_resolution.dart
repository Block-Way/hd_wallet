part of trade_domain_module;

class ResolutionItem {
  const ResolutionItem({
    this.label,
    this.id,
    this.key,
  });

  final String? label;
  final String? id;
  final String? key;
}

const kChartResolutions = [
  ResolutionItem(
    id: '900',
    label: 'trade:kline_btn_item_1',
    key: '15MIN',
  ),
  ResolutionItem(
    id: '1800',
    label: 'trade:kline_btn_item_2',
    key: '30MIN',
  ),
  ResolutionItem(
    id: '3600',
    label: 'trade:kline_btn_item_3',
    key: '60MIN',
  ),
  ResolutionItem(
    id: '14400',
    label: 'trade:kline_btn_item_4',
    key: '240MIN',
  ),
  ResolutionItem(
    id: '86400',
    label: 'trade:kline_btn_item_5',
    key: '1DAY',
  ),
  ResolutionItem(
    id: '604800',
    label: 'trade:kline_btn_item_6',
    key: '1DAY',
  ),
  ResolutionItem(
    id: 'depth',
    label: 'trade:kline_btn_item_depth',
  ),
];
