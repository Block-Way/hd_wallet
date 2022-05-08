part of utils;

class LogBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object event) {
    super.onEvent(bloc, event);
    // ignore: avoid_print
    print('BLOC[${bloc.runtimeType}]: Event ${event.runtimeType} dispatched');
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    print(
      'BLOC[${bloc.runtimeType}]: '
      'Transition from ${transition.currentState.runtimeType} '
      'to ${transition.nextState.runtimeType} '
      'caused by ${transition.event.runtimeType}',
    );
  }

  @override
  void onError(Cubit<dynamic> bloc, dynamic error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    // ignore: avoid_print
    // print('BLOC[${bloc.runtimeType}]: ERROR, $error, $stacktrace');
  }
}
