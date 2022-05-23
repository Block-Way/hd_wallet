part of project_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class ProjectActionGetList extends _BaseAction {
  ProjectActionGetList({
    this.skip,
    this.isRefresh,
  });

  final int skip;
  final bool isRefresh;

  @override
  Future<AppState> reduce() async {
    final projects = await ProjectRepository().getProjectList(
      skip: skip,
      take: 10,
    );

    final projectsWithCoin = projects.map(
      (project) => project.rebuild(
        (a) => a.iconUrl = state.assetState
            .getCoinInfo(chain: 'BBC', symbol: project.symbol)
            ?.iconUrl,
      ),
    );

    return state.rebuild((a) {
      isRefresh
          ? a.projectState.projectList.replace(projectsWithCoin)
          : a.projectState.projectList.addAll(projectsWithCoin);
      return a;
    });
  }
}

class ProjectActionGetInfo extends _BaseAction {
  ProjectActionGetInfo({
    this.id,
    this.completer,
  });

  final int id;
  final Completer<ProjectInfo> completer;

  @override
  Future<AppState> reduce() async {
    final data = await ProjectRepository().getProjectInfo(id: id);
    completer.complete(data);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class ProjectActionSetActivePool extends _BaseAction {
  ProjectActionSetActivePool({
    this.id,
  });

  final int id;

  @override
  Future<AppState> reduce() async {
    // final poolItem = state.poolState.pools.firstWhere(
    //   (item) => item.id == id,
    //   orElse: () => null,
    // );
    // if (poolItem != null) {
    //   // await store.dispatchFuture(PoolActionSwitchPool(poolItem));
    // }
    return null;
  }
}

class ProjectActionGetConfig extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final data = await ProjectRepository().getProjectConfig();

    return state
        .rebuild((a) => a.projectState.projectConfig = data?.toBuilder());
  }
}
