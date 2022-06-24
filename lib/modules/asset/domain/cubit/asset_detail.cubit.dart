part of asset_domain_module;

abstract class AssetDetailCubit extends Cubit<List<Transaction>> {
  AssetDetailCubit([AssetRepository? repository]) : super([]) {
    assetRepository = repository ?? AssetRepository();
  }
  late AssetRepository assetRepository;

  Future<int> loadAll({
    required AssetCoin coin,
    required bool isRefresh,
    required int page,
    required int skip,
    required bool onlyCache,
  });
}
