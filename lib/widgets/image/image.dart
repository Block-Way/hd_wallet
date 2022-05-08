part of widgets;

class CSImage extends StatelessWidget {
  const CSImage(
    this.imageUrl, {
    Key key,
    this.height,
    this.width,
    this.radius = 0,
    this.showLoading = false,
    this.fallbackUrl,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.borderColor,
    this.bordered,
    this.placeholderUseLoading = true,
  }) : super(key: key);

  final bool showLoading;
  final String imageUrl;
  final String fallbackUrl;
  final double height;
  final double width;
  final double radius;
  final BoxFit fit;
  final Color backgroundColor;
  final Color borderColor;
  final bool bordered;
  final bool placeholderUseLoading;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.bgPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: bordered == true
              ? Border.all(
                  width: 0.6,
                  color: borderColor ?? context.greyColor,
                )
              : null,
        ),
        child: Stack(
          children: [
            if (showLoading)
              Center(
                child: CSProgressIndicator(
                  size: height / 3,
                  strokeWidth: 1.5,
                  color: context.primaryColor,
                ),
              ),
            Center(
              child: imageUrl != null && imageUrl.startsWith('http')
                  ? CachedNetworkImage(
                      width: width,
                      height: height,
                      fit: fit,
                      placeholder: (context, _) =>
                          fallbackUrl != null && placeholderUseLoading == true
                              ? Image.asset(
                                  fallbackUrl,
                                  fit: fit,
                                  height: height,
                                  width: width,
                                )
                              : Center(
                                  child: CSProgressIndicator(
                                    size: height / 3,
                                    color: context.primaryColor,
                                  ),
                                ),
                      imageUrl: imageUrl,
                      errorWidget: (context, _, __) => CSImage(
                        fallbackUrl ?? 'assets/images/app_default_logo.png',
                        width: width,
                        height: height,
                        radius: radius,
                        fit: fit,
                        backgroundColor: backgroundColor,
                      ),
                    )
                  : Image.asset(
                      imageUrl ?? fallbackUrl,
                      fit: fit,
                      height: height,
                      width: width,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
