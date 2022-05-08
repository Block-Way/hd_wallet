part of swap_domain_module;

abstract class SwapListVM implements Built<SwapListVM, SwapListVMBuilder> {
  factory SwapListVM([void Function(SwapListVMBuilder) updates]) = _$SwapListVM;
  SwapListVM._();

  @nullable
  BuiltList<Swap> get swapList;

// Withdraw Methods
  @BuiltValueField(compare: false)
  Future<int> Function(
    int skip,
    int page,
  ) get loadData;

  @BuiltValueField(compare: false)
  Future<void> Function(Swap item) get doReSubmit;

  static SwapListVM fromStore(Store<AppState> store) {
    return SwapListVM(
      (viewModel) => viewModel
        ..swapList = store.state.swapState.swaps.toBuilder()
        ..loadData = (page, skip) async {
          final completer = Completer<int>();
          store.dispatchFuture(SwapActionGetSwaps(
            page: page,
            skip: skip,
            completer: completer,
          ));
          return completer.future;
        },
    );
  }
}
