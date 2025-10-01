import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_state.dart';

/// The LoadingCubit class is a state management class that allows for starting and stopping a loading state.
class LoadingCubit extends Cubit<LoadingState> {
  /// This is the constructor for the `LoadingCubit` class. It calls the constructor
  /// of the parent class `Cubit` with an initial state of `LoadingState(isLoading:
  /// false)`. This means that when a new instance of `LoadingCubit` is created, its
  /// initial state will be `LoadingState(isLoading: false)`.
  LoadingCubit() : super(LoadingState.initial());

  /// This function emits a LoadingState object with a loadingState value of true.
  void start() => emit(const LoadingState(isLoading: true));

  /// The function `stop()` emits a `LoadingState` object with a `loadingState` value of `false`.
  void stop() => emit(const LoadingState(isLoading: false));
}
