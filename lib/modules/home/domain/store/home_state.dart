part of home_domain_module;

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
// Constructors

  factory HomeState() {
    return _$HomeState._(
      homeBanners: BuiltList([]),
      homePrices: BuiltList([]),
      isInitialized: false,
    );
  }
  HomeState._();

  factory HomeState.fromCache(
    List<dynamic> data,
  ) {
    try {
      return _$HomeState._(
        homeBanners:
            deserializeListOf<HomeBanner>(data[0]) ?? BuiltList<HomeBanner>([]),
        homePrices:
            deserializeListOf<AssetPrice>(data[1]) ?? BuiltList<AssetPrice>([]),
        isInitialized: false,
      );
    } catch (_) {
      return HomeState();
    }
  }

  static Serializer<HomeState> get serializer => _$homeStateSerializer;

  List<dynamic> toCache() {
    try {
      return [
        serializeListOf<HomeBanner>(homeBanners),
        serializeListOf<AssetPrice>(homePrices),
      ];
    } catch (_) {
      return [];
    }
  }

// Fields
  @nullable
  BuiltList<HomeBanner> get homeBanners;

  @nullable
  BuiltList<AssetPrice> get homePrices;

  bool get isInitialized;
}
