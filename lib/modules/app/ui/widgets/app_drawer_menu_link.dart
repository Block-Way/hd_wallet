part of app_module;

class AppDrawerMenuLink extends StatelessWidget {
  const AppDrawerMenuLink({
    @required this.label,
    @required this.url,
    Key key,
  }) : super(key: key);

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      radius: 16,
      margin: context.edgeAll.copyWith(bottom: 2),
      padding: EdgeInsets.all(15),
      onTap: () {
        Navigator.pop(context);
        WebViewPage.open(url);
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
