part of app_module;

class AppDrawerMenuVersion extends StatelessWidget {
  const AppDrawerMenuVersion({
    @required this.label,
    @required this.version,
    @required this.hasNew,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final String label;
  final String version;
  final bool hasNew;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      radius: 16,
      margin: context.edgeAll.copyWith(bottom: 2),
      padding: EdgeInsets.all(15),
      onTap: () {
        onPressed();
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: context.textBody(bold: true),
            ),
          ),
          Padding(
            padding: context.edgeRight8,
            child: Text(
              version,
              style: context.textSecondary(),
            ),
          ),
          if (hasNew) CSBadge(size: 6),
          Icon(
            CSIcons.More,
            size: 8,
            color: context.blackColor,
          ),
        ],
      ),
    );
  }
}
