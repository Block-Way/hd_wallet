part of explorer_domain_module;

abstract class ExplorerHomeVM
    implements Built<ExplorerHomeVM, ExplorerHomeVMBuilder> {
  factory ExplorerHomeVM([void Function(ExplorerHomeVMBuilder) updates]) =
      _$ExplorerHomeVM;
  ExplorerHomeVM._();

// UI Fields

  List<ExplorerItem> get explorerList;

// UI Actions

// UI Logic
  static ExplorerHomeVM fromStore(Store<AppState> store) {
    final List<ExplorerItem> list = [];

    for (final item in ExplorerUtils.explorerChains) {
      final explorerConfig = ExplorerUtils.explorerConfigs.firstWhere(
        (config) => config.chain == item,
        orElse: () => null,
      );
      final coinInfo = store.state.assetState.coins.firstWhere(
        (coin) => coin.chain == item,
        orElse: () => null,
      );
      if (explorerConfig != null) {
        list.add(ExplorerItem(
          coinInfo: coinInfo,
          config: explorerConfig,
        ));
      }
    }
    return ExplorerHomeVM(
      (viewModel) => viewModel..explorerList = list,
    );
  }
}
