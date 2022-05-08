part of asset_ui_module;

class AssetBalanceListener extends StatelessWidget {
  const AssetBalanceListener({
    @required this.item,
    @required this.builder,
    Key key,
  }) : super(key: key);

  final AssetCoin item;
  final Widget Function(
    BuildContext context, {
    String balance,
    String unconfirmed,
    AssetBalanceInfo data,
  }) builder;

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return builder(
        context,
        balance: '0.0',
        unconfirmed: '0.0',
        data: null,
      );
    }

    final uniqueId = '${item.symbol}:${item.address}';

    final cubit = GetIt.I<AssetBalanceCubit>();

    return StreamBuilder<AssetBalanceState>(
        initialData: cubit.state,
        stream: cubit,
        builder: (context, balanceInfo) {
          final data = balanceInfo.data.getBalanceInfo(uniqueId) ??
              AssetBalanceInfo(
                symbol: item.symbol,
                address: item.address,
              );

          // I unconfirmed is equal to balance,
          // mean I had only one unspent record, my self unspent
          // final unconfirmed =
          //     data.unconfirmed == data.balance ? 0 : data.unconfirmed;

          return builder(
            context,
            balance: item.displayAmountWithPrecision(data.balance),
            unconfirmed: item.displayAmountWithPrecision(data.unconfirmed),
            data: data,
          );
        });
  }
}
