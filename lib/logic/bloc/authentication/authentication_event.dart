part of 'authentication_bloc.dart';

/// The `sealed class AuthenticationEvent` is defining a sealed class in Dart. A
/// sealed class is a class that restricts its subclasses to be defined within the
/// same file. This means that any subclasses of `AuthenticationEvent` must be
/// defined within the same file as the `AuthenticationEvent` class.
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

/// The code `final class _AppUserChanged extends AuthenticationEvent` is defining a
/// new class called `_AppUserChanged` that extends the `AuthenticationEvent` sealed
/// class.
final class _AppUserChanged extends AuthenticationEvent {
  final UserModel user;

  const _AppUserChanged(this.user);
}

/// The code `final class AppLogoutRequested extends AuthenticationEvent { const
/// AppLogoutRequested(); }` is defining a new class called `AppLogoutRequested`
/// that extends the `AuthenticationEvent` sealed class. This class represents an
/// event where the user requests to logout from the app. The `const
/// AppLogoutRequested()` constructor is used to create an instance of this event.
final class AppLogoutRequested extends AuthenticationEvent {
  const AppLogoutRequested();
}
