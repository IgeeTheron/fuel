part of 'authentication_bloc.dart';

/// The code you provided is defining a class called `AuthenticationState` that
/// extends the `Equatable` class.
final class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel user;

  const AuthenticationState._({
    required this.status,
    this.user = UserModel.empty,
  });

  const AuthenticationState.authenticated(UserModel user)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthenticationStatus.unauthenticated,
        );

  @override
  List<Object> get props => [status, user];

  @override
  String toString() {
    return 'AuthenticationState{status: $status, userModel: $user}';
  }
}
