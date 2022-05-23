part of project_ui_module;

class ProjectItem extends HookWidget {
  const ProjectItem({
    @required this.onPress,
    @required this.item,
  });

  final Function onPress;
  final ProjectInfo item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(item.id.toString()),
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.edgeSize,
          vertical: 20,
        ),
        decoration: ThemeBorders.borderBottom,
        child: Column(
          children: [
            Row(
              children: [
                CSImage(
                  item.iconUrl ?? 'assets/images/image_error.png',
                  width: 20,
                  height: 20,
                  radius: 20,
                  backgroundColor: Colors.transparent,
                ),
                Container(
                  width: context.mediaWidth * 0.8,
                  padding: context.edgeLeft10,
                  child: Text(
                    item.projectName,
                    style: context.textBody(bold: true),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            projectLabel(
              context,
              name: tr('project:list_lbl_price'),
              label: '${item.displayPrice} USDT',
            ),
            projectLabel(
              context,
              name: tr('project:list_lbl_amount_total'),
              label: '${item.displayInviteNumber} ${item.symbol}',
            ),
            projectLabel(
              context,
              name: tr('project:list_lbl_progress'),
              label: item.displayProgressPair,
              child: projectProgress(
                context,
                item.displayProgress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget projectProgress(BuildContext context, double width) {
  return Padding(
    padding: context.edgeHorizontal10,
    child: Stack(
      children: [
        Container(
          width: 120,
          height: 6,
          decoration: BoxDecoration(
            color: context.bgSecondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(14.5)),
          ),
        ),
        Container(
          width: width,
          height: 6,
          decoration: BoxDecoration(
            color: context.orangeColor,
            borderRadius: BorderRadius.all(Radius.circular(14.5)),
          ),
        ),
      ],
    ),
  );
}

Widget projectLabel(
  BuildContext context, {
  String name,
  String label,
  Widget child,
}) {
  return Padding(
    padding: context.edgeTop10,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: context.textSecondary(),
        ),
        Row(
          children: [
            child ?? Container(),
            if (child == null)
              Container(
                width: context.mediaWidth * 0.7,
                alignment: Alignment.centerRight,
                child: Text(
                  label,
                  softWrap: true,
                  textAlign: TextAlign.end,
                  style: context.textSecondary(
                    bold: true,
                    color: context.bodyColor,
                  ),
                ),
              )
            else
              Text(
                label,
                style: context.textSecondary(
                  bold: true,
                  color: context.bodyColor,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
