part of wallet_domain_module;

class WalletMnemonicError extends Error {}

class WalletPasswordError extends Error {}

class WalletAddressError extends Error {}

class WalletTransTxRejected extends Error {
  WalletTransTxRejected(this.message);
  String message;
}

class WalletBBCFromPrivateKeyError extends Error {}

class WalletAddressBBCToPublicKeyError extends Error {}

class WalletExportPrivateKeyError extends Error {}

class WalletSignMsgError extends Error {}

class WalletFeeBalanceLowError extends Error {}

/// Error when trying to create an order with amount bigger then approve balance
class WalletApproveBalanceLowError extends Error {}

Object parseWalletError(dynamic error, [Completer completer]) {
  final responseError = Request().getResponseError(error);
  final textError = error?.toString() ?? '';
  var resultError = error;

  if ([
    'get gas limit failed, gas required exceeds allowance',
    'get gas limit failed, insufficient funds for transfer'
  ].any((msg) => responseError.message.contains(msg))) {
    // Not enough ETH balance to pay for Miner Fee
    resultError = WalletFeeBalanceLowError();
  } else if (['get gas limit failed, execution reverted']
      .any((msg) => responseError.message.contains(msg))) {
    // Trying to create order with amount bigger then Approve balance
    resultError = WalletApproveBalanceLowError();
  } else if (textError.contains('CreateBBCFromPrivateKeyError')) {
    resultError = WalletBBCFromPrivateKeyError();
  } else if (textError.contains('AddressBBCToPublicKeyError')) {
    resultError = WalletAddressBBCToPublicKeyError();
  } else if (textError.contains('ExportPrivateKeyError')) {
    resultError = WalletExportPrivateKeyError();
  } else if (textError.contains('SignMsgError')) {
    resultError = WalletSignMsgError();
  }
  completer?.completeError(resultError);
  return resultError;
}
