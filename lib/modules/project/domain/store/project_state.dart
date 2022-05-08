part of project_domain_module;

abstract class ProjectState
    implements Built<ProjectState, ProjectStateBuilder> {
// Constructors

  factory ProjectState() {
    return _$ProjectState._(
      projectList: BuiltList([]),
    );
  }
  ProjectState._();

  factory ProjectState.fromCache(
    List<dynamic> data,
  ) {
    return _$ProjectState._(
      lastProjectCreateParams:
          data.isNotEmpty ? ProjectCreateParams.fromJson(data[0]) : null,
      projectList: BuiltList([]),
    );
  }

  static Serializer<ProjectState> get serializer => _$projectStateSerializer;

  List<dynamic> toCache() {
    return [
      lastProjectCreateParams?.toJson(),
    ];
  }

  @nullable
  ProjectCreateParams get lastProjectCreateParams;

  BuiltList<ProjectInfo> get projectList;

  @nullable
  ProjectConfig get projectConfig;
}
