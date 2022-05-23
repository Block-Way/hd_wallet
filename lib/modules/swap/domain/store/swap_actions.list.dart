part of swap_domain_module;

class SwapActionReviseSwap extends _BaseAction {
  SwapActionReviseSwap({
    this.swap,
    this.isAdd,
  });
  final Swap swap;
  final bool isAdd;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;
    final allSwaps = await SwapRepository().getSwapsFromCache(walletId);
    if (isAdd) {
      allSwaps.add(swap);
    } else {
      for (final item in allSwaps) {
        if (item.txId == swap.txId) {
          item.status = SwapStatus.pending;
        }
      }
    }

    await SwapRepository().saveSwapsToCache(
      walletId,
      allSwaps.toList(),
    );

    return store.state.rebuild(
      (a) => a.swapState..swaps.replace(allSwaps),
    );
  }
}

class _SwapActionLoadSwaps extends _BaseAction {
  _SwapActionLoadSwaps(this.page);

  final int page;

  @override
  Future<AppState> reduce() async {
    final walletId = state.walletState.activeWalletId;
    final swaps = await SwapRepository().getSwapsFromCache(walletId);

    swaps.sort((a, b) => b.createdAt == a.createdAt
        ? b.txId.compareTo(b.txId)
        : (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));

    final skip = (page + 1) * 10;
    final allLength = swaps.length;
    final displayData = swaps.sublist(0, skip <= allLength ? skip : allLength);

    return store.state.rebuild(
      (a) => a.swapState..swaps.replace(displayData),
    );
  }
}

class SwapActionGetSwaps extends _BaseAction {
  SwapActionGetSwaps({
    @required this.page,
    @required this.skip,
    @required this.completer,
  });

  final int page;
  final int skip;
  final Completer<int> completer;

  @override
  Future<void> before() {
    return dispatchFuture(_SwapActionLoadSwaps(page));
  }

  @override
  Future<AppState> reduce() async {
    final allSwaps = await SwapRepository().getSwapsFromCache(walletId);

    final apiResult = await SwapRepository().getSwapsFromApi(
      page: page,
      skip: skip,
      walletId: walletId,
    );

    final rawData = apiResult.value;

    final newSwaps = rawData.map((item) => Swap.fromApi(
          cached: allSwaps.firstWhere(
            (element) => element.txId == item['user_out_txid'],
            orElse: () => null,
          ),
          json: item,
        ));

    final ids = newSwaps.map((e) => e.txId).toSet();

    // cache
    allSwaps.retainWhere((x) => !ids.contains(x.txId ?? ''));

    allSwaps.addAll(newSwaps);

    allSwaps.sort(
      (a, b) => b.createdAt == a.createdAt
          ? b.txId.compareTo(b.txId)
          : (b.createdAt ?? 0).compareTo(a.createdAt ?? 0),
    );

    await SwapRepository().saveSwapsToCache(
      walletId,
      allSwaps.toList(),
    );

    final allLength = allSwaps.length;
    final displayData = allSwaps.sublist(0, allLength);

    completer.complete(displayData.length);

    return store.state.rebuild(
      (a) => a.swapState..swaps.replace(displayData),
    );
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}
