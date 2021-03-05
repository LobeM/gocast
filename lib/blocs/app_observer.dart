import 'package:bloc/bloc.dart';
import 'package:gocast/utils/console.dart';
import 'package:sprintf/sprintf.dart';

/// An interface for observing and logging the behavior of [Bloc].
class AppObserver extends BlocObserver {
  /// Called whenever an [event] is `added` to any [bloc] with the given [bloc]
  /// and [event].
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    Console.log('BLOC EVENT', event.toString());
  }

  /// Called whenever a transition occurs in any [bloc] with the given [bloc]
  /// and [transition].
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Console.log(
        'BLOC TRANSITION',
        sprintf('%s => %s', <String>[
          transition.currentState.toString(),
          transition.nextState.toString()
        ]));
  }

  /// Called whenever an [error] is thrown in any [Bloc] or [Cubit].
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    Console.log('BLOC ERROR', error.toString(), error: error);
    if (stackTrace != null) {
      Console.log('STACKTRACE', stackTrace.toString(), error: stackTrace);
    }
  }
}
