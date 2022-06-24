part of common_ui_module;

class ImagePreview extends StatelessWidget {
  const ImagePreview(
    this.images, {
    this.width,
    this.height,
    this.alignment = MainAxisAlignment.start,
    this.onIconPressed,
    this.icon,
  });

  final List<String> images;
  final double? width;
  final double? height;
  final MainAxisAlignment alignment;
  final VoidCallback? onIconPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: images
          .map(
            (img) => Container(
              margin: context.edgeLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: context.bgSecondaryColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        final imgList =
                            images.map((k) => PhotoItem(k)).toList();
                        final index = images.indexWhere((a) => a == img);
                        showPhotoViewDialog(
                          context,
                          photos: imgList,
                          save: true,
                          initialPage: index,
                        );
                      },
                      child: CSImage(
                        img,
                        width: width,
                        height: height,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: onIconPressed,
                        child: Container(
                          width: 25, // Same as UploadButton
                          height: 25,
                          color: context.blackColor.withOpacity(0.5),
                          child: Icon(
                            icon ?? CSIcons.Search,
                            size: 12,
                            color: context.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
