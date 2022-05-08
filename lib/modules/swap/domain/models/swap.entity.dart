part of swap_domain_module;

@HiveType(typeId: kHiveTypeSwapStatus)
enum SwapStatus {
  /// 10-待处理
  @HiveField(0)
  pending,

  /// 11-链上已确认，
  @HiveField(1)
  confirming,

  /// 12-已完成，
  @HiveField(2)
  success,

  /// 20-数据异常
  @HiveField(3)
  abnormalData,

  /// 30 转账失败
  @HiveField(4)
  failed,

  /// 0 没有提交txid
  @HiveField(5)
  noTxid,
}

@HiveType(typeId: kHiveTypeSwap)
class Swap extends HiveObject {
  Swap() {
    //
  }

  factory Swap.fromApi({
    @required Swap cached,
    @required Map<String, dynamic> json,
  }) {
    return Swap()
      ..txId = json['user_out_txid']?.toString()
      ..status = _mapStatusFromInt(NumberUtil.getInt(json['status']))
      ..outSymbol = json['user_out_currency']?.toString()
      ..outChain = json['user_out_chain']?.toString()
      ..outAmount = json['user_out_amount']?.toString()
      ..inSymbol = json['user_in_currency']?.toString()
      ..inChain = json['user_in_chain']?.toString()
      ..inAmount = json['user_in_amount']?.toString()
      ..toAddress = cached?.toAddress
      ..fromAddress = cached?.fromAddress
      ..transferFee = NumberUtil.getDouble(json['transfer_fee'])
      ..createdAt = NumberUtil.getInt(json['created_at'])
      ..updatedAt = NumberUtil.getInt(json['updated_at']);
  }

  factory Swap.fromSubmit({
    @required SwapCreateParams params,
    @required String txId,
  }) =>
      Swap()
        ..txId = txId
        ..status = SwapStatus.noTxid
        ..outSymbol = params.outCoinConfig.symbol
        ..outChain = params.outCoinConfig.chain
        ..outAmount = params.amount.toString()
        ..inSymbol = params.inCoinConfig.symbol
        ..inChain = params.inCoinConfig.chain
        ..inAmount = params.amount.toString()
        ..toAddress = ' params.toAddress'
        ..fromAddress = params.outCoinInfo.address
        ..transferFee = params.outCoinConfig.transferFee
        ..createdAt = SystemDate.getTime()
        ..updatedAt = SystemDate.getTime();

  @HiveField(0)
  String txId;
  @HiveField(1)
  String toAddress;
  @HiveField(2)
  String fromAddress;

  @HiveField(4)
  String outSymbol;
  @HiveField(5)
  String outChain;
  @HiveField(6)
  String outAmount;

  @HiveField(7)
  String inSymbol;
  @HiveField(8)
  String inChain;
  @HiveField(9)
  String inAmount;

  @HiveField(10)
  double transferFee;

  @HiveField(11)
  int createdAt;
  @HiveField(12)
  int updatedAt;
  @HiveField(20)
  SwapStatus status;

  static SwapStatus _mapStatusFromInt(
    int apiStatus,
  ) {
    /// 10-待处理，11-链上已确认，12-已完成，20-数据异常 30 转账失败 0 没有提交txid
    switch (apiStatus) {
      case 10:
        return SwapStatus.pending;
      case 11:
        return SwapStatus.confirming;
      case 12:
        return SwapStatus.success;
      case 20:
        return SwapStatus.abnormalData;
      case 30:
        return SwapStatus.failed;
      case 0:
        return SwapStatus.noTxid;
      default:
        return SwapStatus.noTxid;
    }
  }

  String get displayOutAmount => NumberUtil.truncateDecimal<String>(outAmount);

  String get displayInAmount => NumberUtil.truncateDecimal<String>(inAmount);

  String get displayTime => formatDate(
        DateTime.fromMillisecondsSinceEpoch((createdAt ?? 0) * 1000),
      );

  String get displayActualAmount => NumberUtil.truncateDecimal<String>(
      NumberUtil.minus<String>(inAmount, transferFee));

  bool get isFailed =>
      status != SwapStatus.pending &&
      status != SwapStatus.success &&
      status != SwapStatus.confirming;

  bool get isUnSubmitted => status == SwapStatus.noTxid;

  String get statusTransKey {
    switch (status) {
      case SwapStatus.pending:
        return 'swap:swap_status_pending';
      case SwapStatus.confirming:
        return 'swap:swap_status_confirming';
      case SwapStatus.success:
        return 'swap:swap_status_success';
      case SwapStatus.abnormalData:
        return 'swap:swap_status_abnormal_data';
      case SwapStatus.noTxid:
        return 'swap:swap_status_unsubmitted';
      case SwapStatus.failed:
        return 'swap:swap_status_failed';
      default:
        return 'swap:swap_status_failed';
    }
  }
}
