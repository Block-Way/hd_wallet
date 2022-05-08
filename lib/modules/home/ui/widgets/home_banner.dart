part of home_ui_module;

// enum BannerTypes {
//   NONE,
//   URL,
//   FUND,
//   PRODUCT,
//   ACTIVITY,
//   SYSTEM_NOTICE,
// }

class HomeBanners extends StatelessWidget {
  const HomeBanners(
    this.homeBanners,
    this.onItemPressed,
  ) : assert(homeBanners != null);

  final List<HomeBanner> homeBanners;
  final void Function(HomeBanner item) onItemPressed;

  @override
  Widget build(BuildContext context) {
    final bannerWidth = context.mediaWidth;
    final bannerHeight = context.mediaWidth * 0.4;

    if (homeBanners.isEmpty) {
      return Container(
        width: bannerWidth,
        height: bannerHeight,
        color: context.whiteColor,
        margin: context.edgeHorizontal,
      );
    }

    Widget _swiperBuilder(BuildContext context, int index) {
      return CSImage(
        homeBanners[index].imageUrl,
        width: bannerWidth,
        height: bannerHeight,
        radius: context.edgeSize,
        backgroundColor: context.bgPrimaryColor,
        fallbackUrl: 'assets/images/banner_default.png',
      );
    }

    return SizedBox(
      width: bannerWidth,
      height: bannerHeight,
      child: Swiper(
        itemWidth: bannerWidth,
        itemHeight: bannerHeight,
        autoplay: true,
        viewportFraction: (bannerWidth - context.edgeSizeDouble) / bannerWidth,
        scale: 0.96,
        fade: 0.97,
        autoplayDelay: 5000,
        onTap: (index) {
          onItemPressed(homeBanners[index]);
        },
        itemBuilder: _swiperBuilder,
        itemCount: homeBanners.length,
        // pagination: SwiperCSPagination(
        //   builder: DotBuilder(
        //     color: context.whiteColor,
        //     activeColor: context.primaryColor,
        //   ),
        // ),
      ),
    );
  }
}
