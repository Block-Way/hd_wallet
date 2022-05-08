part of asset_domain_module;

abstract class AssetAddressVM
    implements Built<AssetAddressVM, AssetAddressVMBuilder> {
  factory AssetAddressVM([void Function(AssetAddressVMBuilder) updates]) =
      _$AssetAddressVM;
  AssetAddressVM._();

// Fields
  @nullable
  BuiltList<AssetAddress> get addressList;
// Methods

  @BuiltValueField(compare: false)
  Future<int> Function({AssetCoin coin, String requestId, bool isLocal})
      get loadAddressList;

  @BuiltValueField(compare: false)
  void Function() get clearAddressList;

  @BuiltValueField(compare: false)
  Future<void> Function(AssetCoin coin, AssetAddress address)
      get submitAddressAdd;

  @BuiltValueField(compare: false)
  Future<void> Function(AssetCoin coin, AssetAddress address)
      get submitAddressDelete;

  @BuiltValueField(compare: false)
  Future<bool> Function({String chain, String address}) get validateAddress;

  static AssetAddressVM fromStore(Store<AppState> store) {
    return AssetAddressVM((viewModel) => viewModel
      ..loadAddressList = ({coin, requestId, isLocal}) async {
        await store.dispatchFuture(AssetActionAddressList(
          coin,
          requestId,
          isLocal: isLocal,
        ));
        return Future.value(store.state.assetState.addressList?.length ?? 0);
      }
      ..clearAddressList = () {
        store.dispatch(AssetActionAddressListClear());
      }
      ..validateAddress = ({chain, address}) {
        final completer = Completer<bool>();
        store.dispatch(WalletActionValidateAddress(
          chain: chain,
          address: address,
          completer: completer,
        ));
        return completer.future;
      }
      ..submitAddressAdd = (coin, address) {
        return store.dispatchFuture(AssetActionAddressEdit(coin, address));
      }
      ..submitAddressDelete = (coin, address) {
        return store.dispatchFuture(AssetActionAddressEdit(
          coin,
          address,
          isDelete: true,
        ));
      }
      ..addressList = store.state.assetState.addressList.toBuilder());
  }
}
