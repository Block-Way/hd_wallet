part of wallet_domain_module;

abstract class WalletState implements Built<WalletState, WalletStateBuilder> {
// Constructors
  factory WalletState() {
    return _$WalletState._(
      wallets: [],
    );
  }

  WalletState._();

  factory WalletState.fromCache(List<dynamic> _) {
    return _$WalletState._();
  }

  static Serializer<WalletState> get serializer => _$walletStateSerializer;

  List<dynamic> toCache() {
    return [];
  }

// Fields
  @nullable
  List<Wallet> get wallets;

  @nullable
  Wallet get activeWallet;
  @nullable
  String get activeWalletId;
  @nullable
  WalletStatus get activeWalletStatus;

  bool get hasWallet => activeWallet != null && activeWalletId != null;
}
