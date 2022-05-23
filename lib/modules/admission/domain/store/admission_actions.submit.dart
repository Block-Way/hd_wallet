part of admission_domain_module;

class AdmissionActionCreateSubmit extends _BaseAction {
  AdmissionActionCreateSubmit({
    @required this.coinInfo,
    @required this.toAddress,
    @required this.txData,
    @required this.amount,
    @required this.onUnlockWallet,
    @required this.onSuccessTransaction,
    @required this.onConfirmParams,
    @required this.onConfirmSubmit,
  });

  final AssetCoin coinInfo;
  final String toAddress;
  final String txData;
  final String amount;
  final Future<WalletPrivateData> Function() onUnlockWallet;
  final void Function(String txId) onSuccessTransaction;
  final Future<bool> Function(WalletWithdrawData withdrawData) onConfirmParams;
  final Future<bool> Function() onConfirmSubmit;

  @override
  Future<AppState> reduce() async {
    final walletData = await onUnlockWallet();
    if (walletData == null) {
      return null;
    }

    final withdrawDataRequest = Completer<WalletWithdrawData>();
    dispatch(WalletActionWithdrawBefore(
      params: WithdrawBeforeParams(
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
        fromAddress: coinInfo.address,
        amount: NumberUtil.getDouble(amount),
        chainPrecision: coinInfo.chainPrecision,
        contractOrForkId: coinInfo.contract,
        toAddress: toAddress,
        txData: AppConstants.admissionUUID +
            ByteUtils.strToHex('1608191160$txData'),
      ),
      completer: withdrawDataRequest,
    ));
    final withdrawData = await withdrawDataRequest.future;

    final canContinue = await onConfirmParams(withdrawData);
    if (canContinue != true) {
      return null;
    }

    final submitTransaction = Completer<String>();
    dispatch(WalletActionWithdrawSubmit(
      params: WithdrawSubmitParams(
        withdrawData: withdrawData,
        amount: NumberUtil.getDouble(amount),
        chainPrecision: coinInfo.chainPrecision,
        toAddress: toAddress,
        txData: txData,
        txDataUUID: AppConstants.admissionUUID,
        dataType: BbcDataType.withData,
      ),
      walletData: walletData,
      completer: submitTransaction,
    ));
    final txId = await submitTransaction.future;

    onSuccessTransaction(txId);

    return null;
  }

  @override
  Object wrapError(dynamic error) {
    final newError = parseWalletError(error);
    return newError;
  }
}
