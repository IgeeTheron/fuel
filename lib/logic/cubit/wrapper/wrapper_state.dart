part of 'wrapper_cubit.dart';

/// The WrapperState class is an Equatable class that holds a WrapperScreenState
/// object and overrides the props and toString methods.
class WrapperState extends Equatable {
  final WrapperScreenState wrapperScreenState;

  /// `const WrapperState({required this.wrapperScreenState});` is a constructor for
  /// the `WrapperState` class that takes a required parameter `wrapperScreenState`
  /// of type `WrapperScreenState`. The `const` keyword is used to indicate that
  /// this constructor creates an immutable object. When an instance of
  /// `WrapperState` is created using this constructor, the `wrapperScreenState`
  /// property is initialized with the value passed in as an argument.
  const WrapperState({required this.wrapperScreenState});

  /// This code is overriding the `props` getter method from the `Equatable` class.
  /// The `pops` getter is used to determine if two instances of the same class are
  /// equal. In this case, the `props` getter is returning a list containing only
  /// the `wrapperScreenState` property, indicating that the equality of two
  /// `WrapperState` objects should be based solely on the equality of their
  /// `wrapperScreenState` properties. The `Object?` type is used to allow for null
  /// values in the list.
  @override
  List<Object?> get props => [wrapperScreenState];

  /// This function returns a string representation of the current state of a
  /// wrapper screen.
  ///
  /// Returns:
  ///   A string representation of the current state of the `WrapperState` object,
  /// which includes the value of the `wrapperScreenState` property.
  @override
  String toString() {
    return 'WrapperState{wrapperScreenState: $wrapperScreenState}';
  }
}
