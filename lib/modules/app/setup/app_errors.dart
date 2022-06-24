part of app_module;

class AppErrors {
  static String parseErrorMessages(dynamic error) {
    // Common - Request
    if (error is SocketException) {
      return tr('global:msg_network_error');
    }
    if (error is TimeoutException) {
      return tr('global:msg_network_timeout');
    }
    // Common - Permission
    if (error is ImagePermissionCameraError) {
      return tr('global:msg_permission_denied_camera');
    }
    if (error is ImagePermissionGalleryError) {
      return tr('global:msg_permission_denied_gallery');
    }

    // Wallet
    if (error is WalletPasswordError) {
      return tr('wallet:wallet_error_password');
    }
    if (error is WalletMnemonicError) {
      return tr('wallet:wallet_error_mnemonic');
    }
    if (error is WalletAddressError) {
      return tr('wallet:wallet_error_address');
    }
    if (error is WalletTransTxRejected) {
      return tr(
        'wallet:wallet_error_tx_reject',
        namedArgs: {'error': error.message},
      );
    }
    if (error is WalletExportPrivateKeyError) {
      return tr('wallet:wallet_error_generate_private_key');
    }
    if (error is WalletSignMsgError) {
      return tr('wallet:wallet_error_sign_msg');
    }
    if (error is WalletFeeBalanceLowError) {
      return tr('wallet:wallet_error_fee_balance_low');
    }
    if (error is WalletApproveBalanceLowError) {
      return tr('wallet:wallet_error_approve_balance_low');
    }

    // Invitation
    if (error is InvitationCoinNotFoundError) {
      return tr('invitation:code_coin_not_found');
    }
    if (error is InvitationCodeDecodeError) {
      return tr('invitation:defi_create_qrcode_error');
    }
    if (error is InvitationCodeDecodeSymbolError) {
      return tr(
        'invitation:defi_create_qrcode_chain_error',
        namedArgs: {'symbol': error.symbol},
      );
    }

    // Trade
    if (error is TradeLowBalanceForCancelError) {
      return tr('trade:order_msg_error_cancel_balance');
    }
    if (error is TradeAddressEmptyError) {
      return tr('trade:order_msg_error_address_empty', namedArgs: {
        'symbol': error.symbol,
      });
    }
    if (error is TradeFeeBalanceLowError) {
      return tr('trade:order_msg_error_fee_balance');
    }
    if (error is TradeApproveBalanceLowError) {
      return tr('trade:order_msg_error_approve_balance_low');
    }
    if (error is TradeParamsMissingError) {
      return tr('trade:order_msg_order_missing_params');
    }

    // Swap
    if (error is SwapApproveBalanceLowError) {
      return tr('swap:create_msg_error_approve_balance_low');
    }
    if (error is SwapPoolBalanceLowError) {
      return tr('swap:create_msg_error_pool_balance_low');
    }

    // Default message for unhandled errors
    if (kDebugMode || AppConstants.isBeta) {
      return error.toString();
    } else {
      return tr('global:msg_app_code_error');
    }
  }
}
