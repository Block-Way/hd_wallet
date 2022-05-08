part of project_domain_module;

abstract class ProjectDetailVM
    implements Built<ProjectDetailVM, ProjectDetailVMBuilder> {
  factory ProjectDetailVM([void Function(ProjectDetailVMBuilder) updates]) =
      _$ProjectDetailVM;
  ProjectDetailVM._();

  // Methods
  @BuiltValueField(compare: false)
  Future<ProjectInfo> Function(int projectId) get getProjectDetail;

  @BuiltValueField(compare: false)
  Future<void> Function(int id) get setActivePool;

  static ProjectDetailVM fromStore(Store<AppState> store) {
    return ProjectDetailVM((viewModel) => viewModel
      ..getProjectDetail = (projectId) {
        final completer = Completer<ProjectInfo>();
        store.dispatch(ProjectActionGetInfo(
          id: projectId,
          completer: completer,
        ));
        return completer.future;
      }
      ..setActivePool = (id) async {
        return store.dispatchFuture(ProjectActionSetActivePool(
          id: id,
        ));
      });
  }
}
