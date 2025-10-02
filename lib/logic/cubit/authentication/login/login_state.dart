part of 'login_cubit.dart';

final class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final Username username;
  final PasswordLogin password;
  final bool rememberMe;
  final String? userMessage;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.dirty(),
    this.password = const PasswordLogin.dirty(),
    this.rememberMe = true,
    this.userMessage,
  });

  factory LoginState.initial() {
    return LoginState(rememberMe: getIt<SharedPreferences>().getBool('rememberMe') ?? false);
  }

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    PasswordLogin? password,
    bool? rememberMe,
    String? userMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      userMessage: userMessage ?? this.userMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        username,
        password,
        rememberMe,
        userMessage,
      ];

  @override
  String toString() {
    return 'LoginState{status: $status, username: $username, password: $password, rememberMe: $rememberMe, userMessage: $userMessage}';
  }
}
