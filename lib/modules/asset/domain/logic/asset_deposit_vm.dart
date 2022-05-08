part of asset_domain_module;

abstract class AssetDepositVM
    implements Built<AssetDepositVM, AssetDepositVMBuilder> {
  factory AssetDepositVM([void Function(AssetDepositVMBuilder) updates]) =
      _$AssetDepositVM;
  AssetDepositVM._();

// Fields

// Methods

  static AssetDepositVM fromStore(Store<AppState> store) {
    return AssetDepositVM((viewModel) => viewModel);
  }
}
