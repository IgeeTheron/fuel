import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_utilities/general_utilities.dart';

/// The `AppBlocObserver` class is a custom implementation of the `BlocObserver`
/// class in Dart, which provides callbacks for various lifecycle events of a `Bloc`
/// and allows for custom logging and error handling.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    PrintColor.magenta("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    PrintColor.cyan("$bloc\n$change");
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    PrintColor.yellow("Closed: $bloc");
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    PrintColor.red("$bloc\n$error\n$stackTrace");
    super.onError(bloc, error, stackTrace);
  }
}
