// ignore_for_file: unintended_html_in_doc_comment

part of 'internet_cubit.dart';

/// The above class is an abstract class representing the state of an internet
/// connection in a Dart application.
@immutable
abstract class InternetState extends Equatable {
  /// The `@override List<Object?> get props => [];` is an override of the `props`
  /// getter method from the `Equatable` class.
  @override
  List<Object?> get props => [];
}

/// The class InternetLoading is a subclass of InternetState.
class InternetLoading extends InternetState {}

/// The `InternetConnected` class represents the state of an internet connection
/// with its connection type and connection status.
class InternetConnected extends InternetState {
  final ConnectionType? connectionType;
  final InternetStatus? internetStatus;

  /// The `InternetConnected` class has a constructor that takes two parameters:
  /// `connectionType` and `internetConnectionStatus`.
  InternetConnected({
    required this.connectionType,
    this.internetStatus = InternetStatus.disconnected,
  });

  /// The `copyWith` function returns a new `InternetConnected` object with updated
  /// values for `connectionType` and `internetConnectionStatus`.
  ///
  /// Args:
  ///   connectionType (ConnectionType): The connectionType parameter is an optional
  /// parameter that represents the type of internet connection. It can have values
  /// like "wifi", "ethernet", "mobile", etc.
  ///   internetConnectionStatus (InternetConnectionStatus): The
  /// internetConnectionStatus parameter is an optional parameter that represents
  /// the status of the internet connection. It can have values like "connected",
  /// "disconnected", "limited", etc.
  ///
  /// Returns:
  ///   The method is returning an instance of the class "InternetConnected" with
  /// the updated values for "connectionType" and "internetConnectionStatus".
  InternetConnected copyWith({
    ConnectionType? connectionType,
    InternetStatus? internetStatus,
  }) {
    return InternetConnected(
      connectionType: connectionType ?? this.connectionType,
      internetStatus: internetStatus ?? this.internetStatus,
    );
  }

  /// The `@override List<Object?> get props => [connectionType,
  /// internetConnectionStatus];` is overriding the `props` getter method from the
  /// `Equatable` class.
  @override
  List<Object?> get props => [connectionType, internetStatus];

  /// The function returns a string representation of an InternetConnected object.
  ///
  /// Returns:
  ///   The method is returning a string representation of an object of type
  /// InternetConnected. The string includes the values of the connectionType and
  /// internetConnectionStatus properties.
  @override
  String toString() {
    return 'InternetConnected{connectionType: $connectionType, internetStatus: $internetStatus}';
  }
}

/// The class InternetDisconnected is a subclass of InternetState.
class InternetDisconnected extends InternetState {}
