part of home_domain_module;

abstract class HomeBanner implements Built<HomeBanner, HomeBannerBuilder> {
  // Constructors

  factory HomeBanner([Function(HomeBannerBuilder) b]) = _$HomeBanner;
  HomeBanner._();

  static Serializer<HomeBanner> get serializer => _$homeBannerSerializer;

  static HomeBanner? fromJson(Map<String, dynamic> json) {
    return deserialize<HomeBanner>(json);
  }

  //@nullable
  int? get id;

  //@nullable
  String? get type;

  //@nullable
  String? get title;

  //@nullable
  String? get content;

  //@nullable
  String? get img;

  //@nullable
  @BuiltValueField(wireName: 'bg_img')
  String? get bgImg;

  @memoized
  String get imageUrl => AppConfig().getImageUrlFor(img ?? '');
}
