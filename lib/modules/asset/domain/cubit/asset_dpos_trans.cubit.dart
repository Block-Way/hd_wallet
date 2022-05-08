part of asset_domain_module;

class AssetDposTransCubit extends AssetDposCubit {
  AssetDposTransCubit([AssetRepository assetRepository])
      : super(assetRepository) {
    _assetRepository = assetRepository ?? AssetRepository();
  }

  AssetRepository _assetRepository;

  void updateList(List<Transaction> list) {
    emit(list);
  }

  @override
  Future<int> loadAll() async {
    final voteNodes = await AssetRepository().getVoteNode();


  }
}