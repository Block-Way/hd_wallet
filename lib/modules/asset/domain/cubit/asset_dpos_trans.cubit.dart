part of asset_domain_module;

class AssetDposTransCubit extends AssetDposCubit {
  AssetDposTransCubit([AssetRepository? assetRepository])
      : super(assetRepository) {
    _assetRepository = assetRepository ?? AssetRepository();
  }

  late AssetRepository _assetRepository;

  void updateList(List<Transaction> list) {
    emit(list);
  }

  @override
  Future<int> loadAll() async {
    final voteNodes = await AssetRepository().getVoteNode();
    return voteNodes.length;
  }
}
