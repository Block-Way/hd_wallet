part of app_module;

class AppDrawerMenuTap extends StatelessWidget {
  const AppDrawerMenuTap({
    @required this.label,
    @required this.onPress,
    Key key,
  }) : super(key: key);

  final String label;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      radius: 16,
      margin: context.edgeAll.copyWith(bottom: 2),
      padding: EdgeInsets.all(15),
      onTap: () {
        Navigator.pop(context);
        onPress();
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              style: context.textBody(bold: true),
            ),
          ),
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
