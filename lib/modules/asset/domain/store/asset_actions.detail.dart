part of asset_domain_module;

class AssetActionLoadDetail extends _BaseAction {
  AssetActionLoadDetail(this.coin);
  final AssetCoin coin;

  @override
  AppState? reduce() {
    return null;
  }
}
