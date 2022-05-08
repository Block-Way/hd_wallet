part of community_domain_module;

class TeamCreateParams {
  TeamCreateParams();

  factory TeamCreateParams.toApiParams({
    CommunityInfo type,
    String name,
    String desc,
    String fork,
    String telegram,
    String logo,
    List<String> images,
  }) {
    return TeamCreateParams()
      ..type = type
      ..name = name
      ..desc = desc
      ..fork = fork
      ..telegram = telegram
      ..logo = logo
      ..images = images;
  }

  CommunityInfo type;
  String name;
  String desc;
  String fork;
  String telegram;
  String logo;
  List<String> images;

  /// 只有判断 详情图片
  static List<String> getVisible(CommunityTypes type) {
    final List<String> baseItem = ['name', 'desc', 'telegram', 'logo', 'coin'];

    if (type != CommunityTypes.market) {
      baseItem.add('images');
    }

    return baseItem;
  }

  String isValid() {
    if (logo == null || logo.isEmpty) {
      return 'upload_logo';
    }

    if (type.teamType != CommunityTypes.market) {
      if (images == null || images.isEmpty) {
        return 'upload_info_img';
      }
    }

    return null;
  }
}
