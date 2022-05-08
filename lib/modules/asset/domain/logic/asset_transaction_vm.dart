part of asset_domain_module;

abstract class AssetTransactionVM
    implements Built<AssetTransactionVM, AssetTransactionVMBuilder> {
  factory AssetTransactionVM(
          [void Function(AssetTransactionVMBuilder) updates]) =
      _$AssetTransactionVM;
  AssetTransactionVM._();

// Fields

// Methods

  @BuiltValueField(compare: false)
  String Function(
    String chain,
    String symbol,
  ) get getCoinName;

  @BuiltValueField(compare: false)
  Future<Transaction> Function(
    Transaction transaction,
  ) get getSingleTransaction;

  static AssetTransactionVM fromStore(Store<AppState> store) {
    return AssetTransactionVM((viewModel) => viewModel
      ..getCoinName = (chain, symbol) {
        return VMWithWalletGetCoinInfoImplement.getCoinInfo(
              store,
              chain: chain,
              symbol: symbol,
            )?.name ??
            symbol;
      }
      ..getSingleTransaction = (transaction) {
        final completer = Completer<Transaction>();

        final coinInfo = VMWithWalletGetCoinInfoImplement.getCoinInfo(
          store,
          chain: transaction.chain,
          symbol: transaction.symbol,
        );

        store.dispatchFuture(
          AssetActionGetSingleTransaction(
            txId: transaction.txId,
            chain: transaction.chain,
            symbol: transaction.symbol,
            fromAddress: transaction.fromAddress,
            chainPrecision: coinInfo.chainPrecision,
            completer: completer,
          ),
        );
        return completer.future;
      });
  }
}
