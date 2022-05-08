part of asset_domain_module;

abstract class AssetManagementVM
    implements Built<AssetManagementVM, AssetManagementVMBuilder> {
  factory AssetManagementVM([void Function(AssetManagementVMBuilder) updates]) =
      _$AssetManagementVM;
  AssetManagementVM._();

// Fields
  List<AssetCoin> get coinsEnabled;
  List<AssetCoin> get coinsDisabled;

// Methods
  @BuiltValueField(compare: false)
  void Function(AssetCoin coin, bool isEnabled) get doToggleCoin;
  @BuiltValueField(compare: false)
  void Function(String term) get doSearchCoin;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  @BuiltValueField(compare: false)
  Future<bool> Function(WalletPrivateData data, String chain)
      get updateCoinAddress;

  static AssetManagementVM fromStore(Store<AppState> store) {
    final coins = store.state.assetState.coins.toList();
    if (store.state.assetState.coinsSearchTerm.isNotEmpty) {
      coins.retainWhere(
        (element) => element.name.toLowerCase().contains(
              store.state.assetState.coinsSearchTerm.toLowerCase(),
            ),
      );
    }

    final coinsEnabled = coins.where((e) => e.isEnabled).toList();
    final coinsDisabled = coins.where((e) => !e.isEnabled).toList();

    return AssetManagementVM(
      (viewModel) => viewModel
        ..coinsEnabled = sortCoins(coinsEnabled)
        ..coinsDisabled = sortCoins(coinsDisabled)
        ..doSearchCoin = (term) {
          store.dispatch(AssetActionSearchCoin(term));
        }
        ..updateCoinAddress = (data, chain) {
          final completer = Completer<bool>();
          store.dispatch(WalletActionUpdateAddress(
            mnemonic: data.mnemonic,
            completer: completer,
            chain: chain,
          ));
          return completer.future;
        }
        ..doUnlockWallet = (password) {
          final completer = Completer<WalletPrivateData>();
          store.dispatch(WalletActionWalletUnlock(password, completer));
          return completer.future;
        }
        ..doToggleCoin = (coin, isEnabled) {
          //
        },
    );
  }
}
