part of app_module;

class AppDrawerMenuSocial extends StatelessWidget {
  const AppDrawerMenuSocial({
    required this.url,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String url;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        doOpenUrl(url);
      },
      child: Padding(
        padding: context.edgeAll,
        // child: Icon(
        //   icon,
        //   size: 28,
        //   color: context.blackColor,
        // ),
        child: CSImage(
          icon,
          width: 30,
          height: 30,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
