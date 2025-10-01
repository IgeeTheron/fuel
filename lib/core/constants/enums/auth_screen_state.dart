enum AuthScreenState {
  login,
  register,
  forgotPassword,
}

extension AuthScreenStateExtension on AuthScreenState {
  bool get isLogin => this == AuthScreenState.login;

  bool get isRegister => this == AuthScreenState.register;

  bool get isForgotPassword => this == AuthScreenState.forgotPassword;
}
