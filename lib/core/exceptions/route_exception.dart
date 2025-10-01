/// The class `RouteException` is an implementation of the `Exception` class in Dart that takes a message as a parameter.
class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}
