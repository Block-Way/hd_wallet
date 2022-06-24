part of project_domain_module;

abstract class ProjectListVM
    implements Built<ProjectListVM, ProjectListVMBuilder> {
  factory ProjectListVM([void Function(ProjectListVMBuilder) updates]) =
      _$ProjectListVM;
  ProjectListVM._();

// Fields
  BuiltList<ProjectInfo> get projectsList;

  int get listCount => projectsList.length;

  // Methods
  @BuiltValueField(compare: false)
  Future<int> Function({
    required bool isRefresh,
    required int skip,
  }) get loadData;

  static ProjectListVM fromStore(Store<AppState> store) {
    return ProjectListVM(
      (viewModel) => viewModel
        ..projectsList = ListBuilder(store.state.projectState.projectList)
        ..loadData = ({
          required isRefresh,
          required skip,
        }) async {
          await store.dispatch(
            ProjectActionGetList(
              isRefresh: isRefresh,
              skip: skip,
            ),
          );
          return Future.value(store.state.projectState.projectList.length);
        },
    );
  }
}
