part of common_ui_module;

class PhotoItem {
  PhotoItem(
    this.path, {
    this.name = '',
    this.minScale,
    this.maxScale,
  });

  final String path; // net or local
  final String name;
  final dynamic minScale;
  final dynamic maxScale;
}

void showPhotoViewDialog(
  BuildContext context, {
  List<PhotoItem> photos,
  bool save = false, // show save image button,only net image show save button
  int initialPage = 0,
}) {
  showDialog(
    barrierDismissible: false,
    barrierColor: context.backdropColor,
    context: context,
    builder: (_) => PhotoViewDialog(
      photos,
      initialPage,
      save: save,
    ),
  );
}

class PhotoViewDialog extends HookWidget {
  PhotoViewDialog(
    this.photos,
    this.initialPage, {
    @required this.save,
  }) : controller = PageController(initialPage: initialPage);

  final List<PhotoItem> photos;
  final bool save;
  final int initialPage;
  final PageController controller;

  ImageProvider _getImageProvider(String path) {
    if (path.toLowerCase().startsWith('http')) {
      return NetworkImage(path);
    }
    return AssetImage(path);
  }

  final defaultMinScale = PhotoViewComputedScale.contained * 0.5;
  final defaultMaxScale = PhotoViewComputedScale.covered * 5;

  Future<void> _saveImage(String path) async {
    try {
      final res = await Dio().get<List<int>>(
        path,
        options: Options(responseType: ResponseType.bytes),
      );
      final _data = Uint8List.fromList(res.data);
      await FileUtils.saveImage(_data);
      Toast.show(tr('global:msg_picture_saved_successfully'));
    } catch (e) {
      if (e is FileUtilsPermissionError) {
        Toast.show(tr('global:msg_permission_denied_storage'));
      } else {
        Toast.show(tr('global:msg_picture_saved_failed'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = useState(0);

    final photoList = photos
        .map(
          (item) => PhotoViewGalleryPageOptions(
            imageProvider: _getImageProvider(item.path),
            heroAttributes: PhotoViewHeroAttributes(tag: item.name),
            minScale: item.minScale ?? defaultMinScale,
            maxScale: item.maxScale ?? defaultMaxScale,
          ),
        )
        .toList();

    Widget _photoView() {
      return PhotoViewGallery.builder(
        scrollPhysics: BouncingScrollPhysics(),
        builder: (context, index) {
          return photoList[index];
        },
        itemCount: photoList.length,
        loadingBuilder: (context, event) => Center(
          child: CSProgressIndicator(
              size: 20,
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes),
        ),
        // backgroundDecoration: widget.backgroundDecoration,
        pageController: controller,
        onPageChanged: (index) {
          pageIndex.value = index;
        },
      );
    }

    return Stack(
      children: [
        _photoView(),
        Positioned(
          right: context.edgeSize,
          top: context.edgeSize,
          child: CSButton(
            flat: true,
            padding: context.edgeAll,
            onPressed: AppNavigator.goBack,
            child: Icon(
              Icons.close,
              color: context.whiteColor,
            ),
          ),
        ),
        if (save &&
            photos[pageIndex.value].path.toLowerCase().startsWith('http'))
          Positioned(
            bottom: 25,
            child: Container(
              alignment: Alignment.center,
              width: context.mediaWidth,
              height: 80,
              child: CSButton(
                mainAxisSize: MainAxisSize.min,
                onPressed: () {
                  _saveImage(photos[pageIndex.value].path);
                },
                flat: true,
                child: Container(
                  padding: context.edgeAll.copyWith(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: context.bgSecondaryColor),
                      borderRadius: context.radiusAll10,
                      color: context.bgPrimaryColor),
                  child: Text(
                    tr('global:btn_save_image'),
                    style: context.textBody(bold: true),
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          top: 0,
          child: Container(
            alignment: Alignment.center,
            width: context.mediaWidth,
            height: 80,
            child: Text(
              photos[pageIndex.value].name != ''
                  ? photos[pageIndex.value].name
                  : '${pageIndex.value + 1}/ ${photos.length}',
              style: context.textSecondary(
                color: context.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
