part of dialogs;

Future<void> showSelectCameraImageDialog(
  BuildContext context, {
  void Function(ImageResult) onSelectedFile,
}) async {
  final options = [
    CSOptionsItem(
      label: tr('global:photo_btn_camera'),
      value: 'camera',
    ),
    CSOptionsItem(
      label: tr('global:photo_btn_select_image'),
      value: 'gallery',
    ),
  ];
  showOptionsDialog(
    context,
    options: options,
    onSelected: (type) {
      if (type == 'camera') {
        CameraUtils.openCamera().then((value) {
          if (value != null) {
            onSelectedFile(value);
          }
        }).catchError((error) {
          if (error is ImagePermissionCameraError) {
            showConfirmDialog(
              context,
              title: tr('global:dialog_permission_title'),
              content: tr('global:dialog_permission_camera'),
              cancelBtnText: tr('global:btn_deny'),
              confirmBtnText: tr('global:btn_open_settings'),
              onConfirm: () {
                openAppSettings();
              },
              onCancel: () {
                Toast.showError(error);
              },
            );
          } else {
            Toast.showError(error);
          }
        });
      } else if (type == 'gallery') {
        CameraUtils.openGallery().then((value) {
          if (value != null) {
            onSelectedFile(value);
          }
        }).catchError((error) {
          if (error is ImagePermissionGalleryError) {
            showConfirmDialog(
              context,
              title: tr('global:dialog_permission_title'),
              content: tr('global:dialog_permission_gallery'),
              cancelBtnText: tr('global:btn_deny'),
              confirmBtnText: tr('global:btn_open_settings'),
              onConfirm: () {
                openAppSettings();
              },
              onCancel: () {
                Toast.showError(error);
              },
            );
          } else {
            Toast.showError(error);
          }
        });
      }
    },
  );
}
