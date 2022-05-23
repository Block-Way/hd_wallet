part of trade_domain_module;

class TradeLowBalanceForCancelError extends Error {}

class TradeAddressEmptyError extends Error {
  TradeAddressEmptyError(this.symbol);
  final String symbol;
}

class TradeFeeBalanceLowError extends Error {}

/// Error when trying to create an order with amount bigger then approve balance
class TradeApproveBalanceLowError extends Error {}

class TradeParamsMissingError extends Error {}
