part of widgets;

/// QQ ios refresh  header effect
class ListViewFooter extends HookWidget {
  const ListViewFooter({
    Key? key,
    this.itemCount,
    this.data,
  }) : super(
          key: key,
        );

  final CSListViewParams? data;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: 80,
      loadStyle: data!.isError // If Error add 80 pixel to bottom of the list
          ? LoadStyle.ShowAlways
          : LoadStyle.ShowWhenLoading,
      builder: (context, mode) {
        Widget? body;
        if (mode == LoadStatus.idle) {
          body = Text(
            tr('global:list_load_pull_up'),
            style: context.textSmall(fontWeight: FontWeight.w300, bold: true),
          );
        } else if (mode == LoadStatus.loading) {
          body = CSProgressIndicator(size: 18);
        } else if (mode == LoadStatus.failed) {
          body = Text(
            tr('global:list_load_failed'),
            style: context.textSmall(fontWeight: FontWeight.w300, bold: true),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            tr('global:list_load_pull_release'),
            style: context.textSmall(fontWeight: FontWeight.w300, bold: true),
          );
        } else if (itemCount != 0) {
          body = Text(
            tr('global:list_load_no_more'),
            style: context.textSmall(fontWeight: FontWeight.w300, bold: true),
          );
        }
        return SizedBox(
          height: 55.0,
          child: itemCount == 0
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      margin: context.edgeRight8,
                      height: 0.5,
                      color: Color(0xFFeeeeee),
                    ),
                    if (body != null) body,
                    Container(
                      width: 60,
                      margin: context.edgeLeft8,
                      height: 0.5,
                      color: Color(0xFFeeeeee),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
