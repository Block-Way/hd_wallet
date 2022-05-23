part of invitation_domain_module;

class InvitationCoinNotFoundError extends Error {}

class InvitationCodeDecodeError extends Error {}

class InvitationCodeDecodeSymbolError extends Error {
  InvitationCodeDecodeSymbolError(this.symbol) : super();
  final String symbol;
}
