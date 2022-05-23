part of trade_domain_module;

abstract class TradeOrderDetailVM
    implements Built<TradeOrderDetailVM, TradeOrderDetailVMBuilder> {
  factory TradeOrderDetailVM([void Function(TradeOrderDetailVMBuilder) b]) =
      _$TradeOrderDetailVM;
  TradeOrderDetailVM._();

// Fields

  @nullable
  TradeOrderDetail get currentOrderDetail;

// Methods

  @nullable
  @BuiltValueField(compare: false)
  Future<TradeOrderDetail> Function(String txId) get getOrderDetail;

  @BuiltValueField(compare: false)
  Future<double> Function(TradeOrder order) get getOrderBalance;

  @BuiltValueField(compare: false)
  Future<TradeOrder> Function(TradeOrder order) get doOrderCheckStatus;

  static TradeOrderDetailVM fromStore(Store<AppState> store) {
    return TradeOrderDetailVM(
      (viewModel) => viewModel
        ..getOrderDetail = (txId) {
          final completer = Completer<TradeOrderDetail>();
          store.dispatch(TradeActionOrderDetail(txId, completer));
          return completer.future;
        }
        ..getOrderBalance = (order) {
          final completer = Completer<double>();
          store.dispatch(TradeActionGetOrderBalance(
            order: order,
            completer: completer,
          ));
          return completer.future;
        }
        ..doOrderCheckStatus = (order) {
          final completer = Completer<TradeOrder>();
          store.dispatch(TradeActionOrderCheckStatus(
            order: order,
            completer: completer,
          ));
          return completer.future;
        },
    );
  }
}
