part of trade_domain_module;

class TradeOrderApiStatus {
  static const all = 'all';
  static const history = 'history';
  static const pending = 'normal';
  static const traded = 'deal';
  static const cancelled = 'cancel';
  static const partialCancel = 'part_cancel';
  static const matchFailed = 'match_failed';
  static const dusts = 'insufficient_balance';
  static const failed = 'failed';
}

/// 10-正常
/// 11-部分撤销
/// 12-全部成交
/// 13-全部撤销
@HiveType(typeId: kHiveTypeTradeOrderStatus)
enum TradeOrderStatus {
  /// [App Only] Order has been submitted, waiting for network to confirm it
  @HiveField(0)
  confirming,

  /// 10-正常
  /// Order confirmed, pending for trade
  @HiveField(1)
  pending,

  /// 12-全部成交
  /// Order completely filled/traded
  @HiveField(2)
  traded,

  /// 11-部分撤销
  /// Order that has partially traded and be cancelled by user
  @HiveField(3)
  partialCancel,

  /// 13-全部撤销
  /// Order that has NOT been traded and be cancelled by user
  @HiveField(4)
  cancelled,

  /// 14-不够退换矿工费
  /// Order with remaining balance to low to be cancel or withdraw
  @HiveField(5)
  dusts,

  /// [App Only] Order has been submitted for cancel
  @HiveField(6)
  cancelling,

  @HiveField(7)
  failed,

  /// 15-Order Match without TxId
  @HiveField(8)
  matchFailed,
}

@HiveType(typeId: kHiveTypeTradeOrder)
class TradeOrder extends HiveObject {
  TradeOrder();

  factory TradeOrder.fromSubmit({
    required DexCreateOrderParams params,
    required WalletTemplateData result,
    required String txId,
  }) =>
      TradeOrder()
        ..txId = txId
        ..type = 'order'
        ..status = TradeOrderStatus.confirming
        ..chain = params.withdrawData.chain
        ..symbol = params.withdrawData.symbol
        ..tradeSideId =
            params.isBuy ? TradeSide.buy.index : TradeSide.sell.index
        ..tradePairId = params.tradePairId
        ..tradeSymbol = params.tradePairId.split('/').first
        ..priceSymbol = params.tradePairId.split('/').last
        ..templateAddress = result.templateAddress
        ..templateHex = result.templateHex
        ..fromAddress = params.withdrawData.fromAddress
        ..submitAt = DateTime.now().millisecondsSinceEpoch ~/ 1000
        ..confirmations = 0
        ..matchFee = params.matchFee
        ..networkFee = params.withdrawData.fee.feeValue
        ..feeSymbol = params.withdrawData.fee.feeSymbol
        ..validHeight = params.validHeight
        ..currentHeight = params.currentHeight
        ..price = params.price
        ..filled = 0
        ..remaining = params.amount
        ..amount = params.amount
        ..total = params.total
        ..dealAmount = 0;

  factory TradeOrder.fromApi({
    required TradeOrder cached,
    required Map<String, dynamic> json,
  }) =>
      TradeOrder()
        ..txId = json['tx'].toString()
        ..type = 'order'
        ..status = _mapStatusFromInt(
          NumberUtil.getInt(json['status']),
          cached.status,
        )!
        ..chain = json['chain'].toString()
        ..symbol = json['symbol'].toString()
        ..tradeSideId =
            json['side'] == 'BUY' ? TradeSide.buy.index : TradeSide.sell.index
        ..tradePairId = json['coin_pair'].toString()
        ..tradeSymbol = json['coin_pair'].toString().split('/').first
        ..priceSymbol = json['coin_pair'].toString().split('/').last
        // For ETH or TRX, the template field is the PrimaryKey
        // We keep the cached templateAddress
        // and use the template for the templateHex
        ..templateAddress = ['ETH', 'TRX'].contains(json['chain'].toString())
            ? cached.templateAddress
            : json['template'].toString()
        ..templateHex = ['ETH', 'TRX'].contains(json['chain'].toString())
            ? json['template'].toString()
            : cached.templateHex
        ..fromAddress = cached.fromAddress
        ..confirmedAt = NumberUtil.getInt(json['created_at'])
        ..confirmations = cached.confirmations
        ..matchFee = cached.matchFee
        ..networkFee =
            NumberUtil.getDouble(json['miner_fee'], cached.networkFee)
        ..submitAt = cached.submitAt
        ..cancelAt = cached.cancelAt
        ..cancelTxId = cached.cancelTxId
        ..feeSymbol = json['symbol'].toString()
        // TODO: USDT goes online need to check,
        // TODO: API need to return fee symbol,
        ..validHeight = cached.validHeight
        ..currentHeight = cached.currentHeight
        ..price = NumberUtil.getDouble(json['price'], cached.price)
        ..avgPrice = NumberUtil.getDouble(json['avg_price'], cached.avgPrice)
        ..filled = NumberUtil.getDouble(json['already_exchange'], cached.filled)
        ..remaining = NumberUtil.getDouble(
            json['remaining_entire_amount'], cached.remaining)
        ..amount = NumberUtil.getDouble(json['entire_amount'], cached.amount)
        ..total = NumberUtil.getDouble(json['amount'], cached.amount)
        ..dealAmount =
            NumberUtil.getDouble(json['deal_amount'], cached.dealAmount);

  factory TradeOrder.fromDealFailApi(
    Map<String, dynamic> json,
  ) =>
      TradeOrder()
        ..txId = json['template_hex'].toString()
        ..type = 'failOrder'
        ..status = TradeOrderStatus.failed
        ..chain = json['chain'].toString()
        ..symbol = json['symbol'].toString()
        ..tradeSideId =
            json['side'] == 'BUY' ? TradeSide.buy.index : TradeSide.sell.index
        ..tradePairId = json['coin_pair'].toString()
        ..tradeSymbol = json['coin_pair'].toString().split('/').first
        ..priceSymbol = json['coin_pair'].toString().split('/').last
        ..templateAddress = json['template'].toString()
        ..templateHex =
            json['template_hex'].toString() // PrimaryKey or Hex Data
        ..amount = NumberUtil.getDouble(json['match_amount']);

  @HiveField(0)
  late String txId;
  @HiveField(1)
  late String chain;
  @HiveField(2)
  late String symbol;
  @HiveField(3)
  late String priceSymbol;
  @HiveField(4)
  late String tradeSymbol;

  @HiveField(5)
  late int tradeSideId;
  @HiveField(6)
  late String tradePairId;

  @HiveField(7)
  late int confirmations;
  @HiveField(8)
  late int validHeight;
  @HiveField(9)
  late int currentHeight;
  @HiveField(10)
  late int submitAt;
  @HiveField(11)
  late int confirmedAt;
  @HiveField(12)
  late int tradedAt;
  @HiveField(13)
  late int cancelAt;
  @HiveField(14)
  late String cancelTxId;

  @HiveField(15)
  late String templateAddress;

  /// For ETH/TRX templateHex is primaryKey
  @HiveField(16)
  late String templateHex;

  @HiveField(17)
  late String fromAddress;
  @HiveField(18)
  late String matchAddress;
  @HiveField(19)
  late String dealAddress;

  /// 挂单价格
  @HiveField(20)
  late double price;

  /// 成交均价
  @HiveField(21)
  late double avgPrice;

  /// 剩余数量
  @HiveField(22)
  late double remaining;

  /// 数量
  @HiveField(23)
  late double amount;

  /// 已成交数量
  @HiveField(24)
  late double filled;

  @HiveField(25)
  late double total;

  /// 交易额
  @HiveField(26)
  late double dealAmount;

  /// Amount left that can be withdraw
  @HiveField(30)
  late double withdrawAmount;

  /// 矿工费
  @HiveField(27)
  late double networkFee;

  /// 手续费
  @HiveField(28)
  late int matchFee;

  // Fee
  @HiveField(29)
  late String feeSymbol;

  @HiveField(40)
  late TradeOrderStatus status;

  @HiveField(41)
  late String type;

  bool get isBuy => tradeSideId == TradeSide.buy.index;

  double get payAmount => (isBuy ? total : amount);

  /// Order confirmed, pending for trade
  bool get isPending => status == TradeOrderStatus.pending;

  /// Order waiting for network confirmation
  bool get isConfirming => status == TradeOrderStatus.confirming;

  /// Order failed are on app cache only
  /// Usually are ETH or TRX transaction failed
  bool get isFailed => status == TradeOrderStatus.failed;

  /// Order waiting for network confirmation
  bool get isCancelling => status == TradeOrderStatus.cancelling;

  /// Order need to manually cancel
  bool get isDealFail => type == 'failOrder';

  /// If true, this chain used API to create transaction RawTx
  bool get isChainUseApiRawTx => ['ETH', 'TRX'].contains(chain);

  /// For ETH/TRX templateId is primaryKey
  String get templateId => isChainUseApiRawTx ? templateHex : templateAddress;

  bool get needStatusCheck =>
      (isConfirming || isCancelling) && isChainUseApiRawTx;

  /// Transaction is Confirming since 2 minutes
  bool get isTakingLongTime =>
      (isConfirming || isCancelling) &&
      (SystemDate.getTime() - submitAt) > 2 * 60;

  bool get canCancel =>
      status != TradeOrderStatus.cancelled &&
      status != TradeOrderStatus.cancelling &&
      status != TradeOrderStatus.failed &&
      status != TradeOrderStatus.partialCancel &&
      status != TradeOrderStatus.confirming &&
      status != TradeOrderStatus.dusts;

  bool get isHistory =>
      status != TradeOrderStatus.pending &&
      status != TradeOrderStatus.cancelling &&
      status != TradeOrderStatus.confirming;

  String get displayMatchFee => (matchFee / 100).toString();

  /// Use order confirmed time (when the transaction is confirmed),
  /// otherwise use local submitted time
  int get displayTime => confirmedAt * 1000;

  /// Map the api number status to our enum
  /// - If api status is [pending] (10) but our status is [cancelling],
  /// use cancelling and wait for api to return new status
  static TradeOrderStatus? _mapStatusFromInt(
    int apiStatus,
    TradeOrderStatus cachedStatus,
  ) {
    if (cachedStatus == TradeOrderStatus.cancelling && apiStatus == 10) {
      return TradeOrderStatus.cancelling;
    }
    switch (apiStatus) {
      case 10:
        return TradeOrderStatus.pending;
      case 12:
        return TradeOrderStatus.traded;
      case 11:
        return TradeOrderStatus.partialCancel;
      case 13:
        return TradeOrderStatus.cancelled;
      case 14:
        return TradeOrderStatus.dusts;
      case 15:
        return TradeOrderStatus.matchFailed;
      default:
        return null;
    }
  }

  TradeSide? get tradeSide {
    if (tradeSideId == TradeSide.buy.index) {
      return TradeSide.buy;
    }
    if (tradeSideId == TradeSide.sell.index) {
      return TradeSide.sell;
    }
    return null;
  }

  String get statusTransKey {
    switch (status) {
      case TradeOrderStatus.pending:
        return 'trade:order_status_pending';
      case TradeOrderStatus.traded:
        return 'trade:order_status_traded';
      case TradeOrderStatus.partialCancel:
        return 'trade:order_status_partial_cancel';
      case TradeOrderStatus.cancelled:
        return 'trade:order_status_cancelled';
      case TradeOrderStatus.confirming:
        return 'trade:order_status_confirming';
      case TradeOrderStatus.cancelling:
        return 'trade:order_status_cancelling';
      case TradeOrderStatus.dusts:
        return 'trade:order_status_dusts';
      case TradeOrderStatus.failed:
        return 'trade:order_status_failed';
      case TradeOrderStatus.matchFailed:
        return 'trade:order_status_match_failed';
      default:
        return 'trade:order_status_unknown';
    }
  }

  String get statusCancelKey => isDealFail
      ? 'trade:order_btn_retract'
      : isHistory
          ? 'trade:order_btn_withdraw'
          : 'trade:order_btn_cancel';

  String get statusCancelMsg => isDealFail
      ? 'trade:order_confirm_fail_cancel_msg'
      : isHistory
          ? 'trade:order_confirm_history_cancel_msg'
          : 'trade:order_confirm_pending_cancel_msg';
}
