part of project_domain_module;

abstract class ProjectConfig
    implements Built<ProjectConfig, ProjectConfigBuilder> {
  // Constructors
  factory ProjectConfig([Function(ProjectConfigBuilder) b]) = _$ProjectConfig;
  ProjectConfig._();

  static Serializer<ProjectConfig> get serializer => _$projectConfigSerializer;

  static ProjectConfig fromJson(Map<String, dynamic> json) {
    return deserialize<ProjectConfig>(json);
  }

  @nullable
  String get instructions;

  @nullable
  double get id;
}
