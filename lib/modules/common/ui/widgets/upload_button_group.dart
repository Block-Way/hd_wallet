part of common_ui_module;

class UploadButtonGroup extends HookWidget {
  const UploadButtonGroup({
    @required this.signature,
    @required this.uploadType,
    this.onUploadChange,
    this.onChanges,
    this.maxImages = 3,
    this.itemSize = 96,
    Key key,
  }) : super(key: key);

  final String signature;
  final String uploadType;
  final Function(bool) onUploadChange;
  final Function(List<String> paths) onChanges;
  final int maxImages;
  final double itemSize;

  @override
  Widget build(BuildContext context) {
    final images = useStreamController<Map<String, File>>();

    return StreamBuilder<Map<String, File>>(
      // ignore: prefer_const_literals_to_create_immutables
      initialData: {},
      stream: images.stream,
      builder: (context, snapshot) => Wrap(
        children: [
          ...snapshot.data.entries.map(
            (entry) => UploadButton(
              key: Key(entry.key),
              size: itemSize,
              margin: context.edgeBottom8.copyWith(right: 8),
              localFileUri: entry.value?.uri,
              signature: signature,
              uploadType: uploadType,
              onUploadSuccess: (path, file) {
                final newImages = snapshot.data;
                newImages.remove(entry.key);
                newImages.putIfAbsent(path, () => file);
                images.add(newImages);
              },
              onUploadChange: onUploadChange,
              onRemove: () {
                final newImages = snapshot.data;
                newImages.remove(entry.key);
                images.add(newImages);
                if (onChanges != null) {
                  onChanges(newImages.keys.toList());
                }
              },
            ),
          ),
          if (snapshot.data.keys.length < maxImages)
            UploadButton(
              key: Key('add_button'),
              size: itemSize,
              margin: context.edgeBottom8.copyWith(right: 8),
              clearAfterUpload: true,
              signature: signature,
              uploadType: uploadType,
              onUploadSuccess: (path, file) {
                final newImages = snapshot.data;
                newImages.putIfAbsent(path, () => file);
                images.sink.add(newImages);
                if (onChanges != null) {
                  onChanges(newImages.keys.toList());
                }
              },
              onUploadChange: onUploadChange,
            ),
        ],
      ),
    );
  }
}
