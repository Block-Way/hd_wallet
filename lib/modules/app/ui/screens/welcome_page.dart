part of app_module;

class AppWelcomePage extends HookWidget {
  static const routeName = '/app/welcome';

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      AppWelcomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
