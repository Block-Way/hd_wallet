part of trade_ui_module;

class TradeOrderSubmitProcess {
  static void doApproveOrder(
    BuildContext context,
    TradeHomeVM viewModel, {

    /// If True user request a reset
    required bool userReset,
    required AssetCoin coinInfo,
    required Function(String) onSuccessTransaction,
  }) {}

  static void doCreateOrder(
    BuildContext context,
    TradeHomeVM viewModel, {
    required String price,
    required String amount,
    required String total,
    required Function(String) onSuccessTransaction,
  }) {}
}
