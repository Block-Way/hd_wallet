part of notice_ui_module;

class NoticeListItem extends StatelessWidget {
  const NoticeListItem({
    @required this.item,
    Key key,
  }) : super(key: key);
  final NoticeInfo item;

  @override
  Widget build(BuildContext context) {
    final width = context.mediaWidth - context.edgeSizeDouble;
    final height = width * 0.5;

    return CSContainer(
      onTap: () {
        NoticeDetailPage.open(item);
      },
      child: Column(
        children: [
          CSImage(
            item.image,
            width: width,
            height: height,
            radius: context.edgeSize,
          ),
          Padding(
            padding: context.edgeAll,
            child: Text(
              item.displayCreatedAt ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textSecondary(),
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
