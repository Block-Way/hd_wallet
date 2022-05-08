part of app_module;

class AppStatePersistor extends Persistor<AppState> {
  AppStatePersistor(String dbName) {
    persist = LocalPersist(dbName);
  }
  LocalPersist persist;

  @override
  Future<AppState> readState() async {
    // final dbFile = await persist.file();
    final state = await persist.load();
    if (state == null || state.isEmpty) {
      return null;
    }
    try {
      final initialState = AppState.fromCache(
        homeState: HomeState.fromCache(
          state[0] as List<dynamic>,
        ),
        assetState: AssetState.fromCache(
          state[1] as List<dynamic>,
        ),
        noticeState: NoticeState.fromCache(
          state[2] as List<dynamic>,
        ),
        tradeState: TradeState.fromCache(
          state[3] as List<dynamic>,
        ),
        communityState: CommunityState.fromCache(
          state[4] as List<dynamic>,
        ),
      );
      return initialState;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> deleteState() async {
    return persist.delete();
  }

  @override
  Future<void> persistDifference({
    AppState lastPersistedState,
    AppState newState,
  }) async {
    if (lastPersistedState == null || newState == null) {
      return;
    }
    try {
      return saveInitialState(newState);
    } catch (error) {
      return;
    }
  }

  @override
  Future<void> saveInitialState(AppState state) async {
    return persist.save([
      state.homeState.toCache(),
      state.assetState.toCache(),
      state.noticeState.toCache(),
      state.tradeState.toCache(),
      state.communityState.toCache(),
    ]);
  }

  @override
  Duration get throttle => Duration(seconds: 3);
}

final appPersistor = AppStatePersistor('app_state_v2');
