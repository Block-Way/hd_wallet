part of asset_domain_module;

abstract class AssetState implements Built<AssetState, AssetStateBuilder> {
// Constructors
  factory AssetState() {
    return _$AssetState._(
      coins: BuiltList<AssetCoin>(),
      addressList: BuiltList<AssetAddress>(),
      coinsSearchTerm: '',
      hideSmallAssets: false,
      hideInvitationNotice: false,
      hideInvitationShowcase: false,
      hideDepositShowcase: false,
      hideWithdrawShowcase: false,
      isBalanceUpdating: false,
    );
  }
  AssetState._();

  factory AssetState.fromCache(
    List<dynamic> data,
  ) {
    try {
      return _$AssetState._(
        coins: BuiltList<AssetCoin>(),
        coinsSearchTerm: '',
        hideSmallAssets: false,
        hideInvitationNotice: data[0] == true,
        hideInvitationShowcase: data[1] == true,
        hideDepositShowcase: data[2] == true,
        hideWithdrawShowcase: data[3] == true,
        isBalanceUpdating: false,
      );
    } catch (error) {
      return AssetState();
    }
  }

  static Serializer<AssetState> get serializer => _$assetStateSerializer;

  List<dynamic> toCache() {
    return [
      hideInvitationNotice,
      hideInvitationShowcase,
      hideDepositShowcase,
      hideWithdrawShowcase,
    ];
  }

// Fields

  // Common
  BuiltList<AssetCoin> get coins;

  // Asset List Page
  bool get hideInvitationShowcase;
  bool get hideInvitationNotice;
  bool get hideSmallAssets;
  bool get isBalanceUpdating;
  bool get hideDepositShowcase;
  bool get hideWithdrawShowcase;

  // Asset Management Page
  String get coinsSearchTerm;

  // asset address
  BuiltList<AssetAddress> get addressList;

  @nullable
  String get addressRequestId;

// Methods
  AssetCoin getCoinInfo({
    @required String chain,
    @required String symbol,
  }) {
    if (chain == null || chain.isEmpty) {
      return coins.firstWhere(
        (e) => e.symbol == symbol,
        orElse: () => null,
      );
    }

    return coins.firstWhere(
      (e) => e.symbol == symbol && e.chain == chain,
      orElse: () => null,
    );
  }

  AssetCoin getCoinInfoByContract({
    @required String contract,
  }) {
    return coins.firstWhere(
      (e) => e.contract == contract,
      orElse: () => null,
    );
  }
}
