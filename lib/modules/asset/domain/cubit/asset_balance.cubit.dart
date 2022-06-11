part of asset_domain_module;

class AssetBalanceState {
  AssetBalanceState(this.balances);

  factory AssetBalanceState.fromState(AssetBalanceState old) {
    return AssetBalanceState({...old.balances});
  }

  final Map<String, AssetBalanceInfo> balances;

  AssetBalanceInfo? getBalanceInfo(String uniqueId) {
    return balances.containsKey(uniqueId) ? balances[uniqueId] : null;
  }

  void updateBalance({
    required String symbol,
    required String address,
    required double balance,
    required double unconfirmed,
  }) {
    final uniqueId = '$symbol:$address';
    final item = AssetBalanceInfo(
      symbol: symbol,
      address: address,
      balance: balance,
      unconfirmed: unconfirmed,
    );
    balances[uniqueId] = item;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is AssetBalanceState && mapEquals(o.balances, balances);
  }

  @override
  int get hashCode => balances.hashCode;
}

class AssetBalanceCubit extends Cubit<AssetBalanceState> {
  AssetBalanceCubit() : super(AssetBalanceState({}));

  Future<void> updateBalance({
    required String symbol,
    required String address,
    required double balance,
    required double unconfirmed,
  }) async {
    final newState = AssetBalanceState.fromState(state);
    newState.updateBalance(
      symbol: symbol,
      address: address,
      balance: balance,
      unconfirmed: unconfirmed,
    );
    emit(newState);
  }
}
