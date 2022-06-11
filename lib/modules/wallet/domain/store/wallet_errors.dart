part of wallet_domain_module;

class WalletMnemonicError extends Error {}

class WalletPasswordError extends Error {}

class WalletAddressError extends Error {}

class WalletTransTxRejected extends Error {
  WalletTransTxRejected(this.message);
  String message;
}

class WalletExportPrivateKeyError extends Error {}

class WalletSignMsgError extends Error {}

class WalletFeeBalanceLowError extends Error {}

/// Error when trying to create an order with amount bigger then approve balance
class WalletApproveBalanceLowError extends Error {}

Object? parseWalletError(dynamic error, [Completer? completer]) {
  return 'err';
}
