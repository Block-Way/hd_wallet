part of asset_domain_module;

class AssetActionUpdatePrices extends _BaseAction {
  AssetActionUpdatePrices(this.fiatCurrency);
  final String fiatCurrency;

  @override
  Future<AppState> reduce() async {
    final fiatPriceCubit = GetIt.I<FiatPriceCubit>();
    final coinPriceCubit = GetIt.I<CoinPriceCubit>();

    await fiatPriceCubit.setFiatCurrency(fiatCurrency);
    await fiatPriceCubit.updateAll();
    await coinPriceCubit.updateAll();
    return null;
  }
}
