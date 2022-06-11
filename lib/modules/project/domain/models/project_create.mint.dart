part of project_domain_module;

abstract class ProjectCreateMint
    implements Built<ProjectCreateMint, ProjectCreateMintBuilder> {
  // Constructors

  factory ProjectCreateMint({
    required int index,
    required String month,
    required String ratio,
  }) {
    return _$ProjectCreateMint._(
      index: index,
      month: month,
      ratio: ratio,
    );
  }
  ProjectCreateMint._();

  static Serializer<ProjectCreateMint> get serializer =>
      _$projectCreateMintSerializer;

// Fields
  int get index;
  String get month;
  String get ratio;
}
