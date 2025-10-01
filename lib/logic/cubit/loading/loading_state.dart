part of 'loading_cubit.dart';

/// The `LoadingState` class represents the state of loading with a boolean value and provides a string representation of the object.
class LoadingState extends Equatable {
  final bool isLoading;

  /// `const LoadingState({required this.isLoading});` is defining a constructor for
  /// the `LoadingState` class that takes a required boolean parameter `isLoading`.
  /// The `const` keyword is used to indicate that this constructor can be used to
  /// create a compile-time constant object of the `LoadingState` class. This
  /// constructor can be used to create a new `LoadingState` object with the
  /// specified `isLoading` value.
  const LoadingState({required this.isLoading});

  factory LoadingState.initial() {
    return const LoadingState(isLoading: false);
  }

  /// `@override List<Object?> get props => [isLoading];` is implementing the
  /// `Equatable` package in Dart. It is overriding the `props` getter method to
  /// return a list of properties that should be used to determine if two instances
  /// of the `LoadingState` class are equal. In this case, the only property being
  /// used is the `isLoading` boolean value. This allows for easy comparison of
  /// `LoadingState` objects in the `Bloc` or `Cubit` classes that use them.
  @override
  List<Object?> get props => [isLoading];

  /// The function returns a string representation of the LoadingState object.
  ///
  /// Returns:
  ///   A string representation of the `LoadingState` object, which includes the
  /// value of the `isLoading` property.
  @override
  String toString() {
    return 'LoadingState{isLoading: $isLoading}';
  }
}
