part of invitation_domain_module;

class InvitationActionCreateSubmit extends _BaseAction {
  InvitationActionCreateSubmit({
    @required this.coinInfo,
    @required this.toAddress,
    @required this.signCode,
    @required this.sharePrvKey,
    @required this.amount,
    @required this.onUnlockWallet,
    @required this.onSuccessTransaction,
    @required this.onConfirmParams,
    @required this.onConfirmSubmit,
  });

  final AssetCoin coinInfo;
  final String toAddress;
  final String signCode;
  final String sharePrvKey;
  final String amount;
  final Future<WalletPrivateData> Function() onUnlockWallet;
  final void Function(String txId) onSuccessTransaction;
  final Future<bool> Function(WalletWithdrawData withdrawData) onConfirmParams;
  final Future<bool> Function() onConfirmSubmit;

  @override
  Future<AppState> reduce() async {
    final canContinue = await onConfirmSubmit();
    if (canContinue == false) {
      return null;
    }

    final walletData = await onUnlockWallet();
    if (walletData == null) {
      return null;
    }

    final parentPubKey =
        await WalletBBC.addressBBCToPublicKey(address: coinInfo.address);

    final sharedKeyInfo =
        await WalletBBC.createBBCFromPrivateKey(privateKey: sharePrvKey);

    final parentCode = await InvitationRepository().createInvitationCodeData(
      signPrivateKey: sharePrvKey,
      codePrivateKey: sharePrvKey,
      codePublicKey: parentPubKey,
      codeForkId: '', // No need
    );

    final subSigByte = ByteUtils.hexToBytes(signCode);
    final parentSigByte = ByteUtils.hexToBytes(parentCode.subSign);
    final sharedPubKeyByte =
        ByteUtils.hexToBytes(sharedKeyInfo.publicKey).reversed.toList();

    final vchData = sharedPubKeyByte + subSigByte + parentSigByte;

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
        txData: ByteUtils.bytesToHex(vchData),
      ),
      completer: withdrawDataRequest,
    ));
    final withdrawData = await withdrawDataRequest.future;

    final canContinue2 = await onConfirmParams(withdrawData);
    if (canContinue2 != true) {
      return null;
    }

    final submitTransaction = Completer<String>();
    dispatch(WalletActionWithdrawSubmit(
      params: WithdrawSubmitParams(
        withdrawData: withdrawData,
        amount: NumberUtil.getDouble(amount),
        chainPrecision: coinInfo.chainPrecision,
        toAddress: toAddress,
        type: 2, // Invitation Type
        txData: ByteUtils.bytesToHex(vchData),
        dataType: BbcDataType.hexData,
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
    return parseWalletError(error);
  }
}
