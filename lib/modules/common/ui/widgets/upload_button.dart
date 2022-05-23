part of common_ui_module;

class UploadButton extends HookWidget {
  const UploadButton({
    @required this.signature,
    @required this.uploadType,
    Key key,
    this.size = 96,
    this.icon,
    this.iconSize = 24,
    this.child,
    this.color,
    this.onUploadSuccess,
    this.onRemove,
    this.clearAfterUpload = false,
    this.localFileUri,
    this.onUploadChange,
    this.margin,
  }) : super(key: key);

  final double size;
  final IconData icon;
  final double iconSize;
  final Widget child;
  final Color color;
  final bool clearAfterUpload;
  final String signature;
  final String uploadType;
  final Uri localFileUri;
  final Function() onRemove;
  final Function(bool) onUploadChange;
  final Function(String, File) onUploadSuccess;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final uploadProgress = useStreamController<num>();
    final uploadFile = useState<File>();
    final isUploading = useState(false);

    void onSelectedFile(ImageResult selectedFile) {
      uploadFile.value = selectedFile.file;
      isUploading.value = true;
      if (onUploadChange != null) {
        onUploadChange(true);
      }
      UploadUtils.requestUpload(
        uploadType,
        selectedFile.file,
        signature: signature,
        uploadProgress: uploadProgress,
      ).then((result) {
        if (onUploadChange != null) {
          onUploadChange(false);
        }
        if (onUploadSuccess != null) {
          onUploadSuccess(result.path, uploadFile.value);
        }
        if (clearAfterUpload) {
          uploadFile.value = null;
        }
      }).catchError((error) {
        if (onUploadChange != null) {
          onUploadChange(false);
        }
        uploadFile.value = null;
        Toast.show(tr('global:msg_upload_failed'));
      }).whenComplete(() {
        isUploading.value = false;
      });
    }

    useEffect(() {
      if (localFileUri != null) {
        uploadFile.value = File.fromUri(localFileUri);
      }
      return null;
    }, [localFileUri]);

    return CSContainer(
      height: size,
      width: size,
      padding: EdgeInsets.zero,
      decoration: context.boxDecoration(color: Colors.transparent, radius: 30),
      margin: margin ?? context.edgeRight,
      onTap: () {
        DeviceUtils.hideKeyboard(context);

        if (isUploading.value == true) {
          return;
        }
        showSelectCameraImageDialog(
          context,
          onSelectedFile: onSelectedFile,
        );
      },
      child: DottedBorder(
        color: color ?? Color(0xFFC4C4C4),
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.zero,
        dashPattern: const [5, 5],
        child: Stack(
          children: [
            if (uploadFile.value != null)
              Center(
                child: Image.file(
                  uploadFile.value,
                  fit: BoxFit.cover,
                ),
              )
            else
              Center(
                child: Icon(
                  icon ?? CSIcons.Create,
                  size: iconSize,
                  color: color ?? Color(0xFFC4C4C4),
                ),
              ),
            Positioned.fill(
              child: StreamBuilder<num>(
                stream: uploadProgress.stream,
                initialData: 1,
                builder: (context, snapshot) => Opacity(
                  opacity: isUploading.value ? 1 : 0,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Stack(
                      children: [
                        Center(
                          child: CSProgressIndicator(
                            size: size / 2,
                            value: snapshot.data / 100,
                            strokeWidth: 4,
                            color: context.primaryColor,
                          ),
                        ),
                        Center(
                          child: Text(
                            '${snapshot.data}%',
                            style: context.textSecondary(
                              bold: true,
                              color: context.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (uploadFile.value != null)
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    if (isUploading.value == false) {
                      uploadFile.value = null;
                      if (onRemove != null) {
                        onRemove();
                      }
                    }
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    color: context.blackColor.withOpacity(0.5),
                    child: Icon(
                      CSIcons.Delete,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
