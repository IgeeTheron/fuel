import 'package:dio/dio.dart';

class AuthenticationService {
  final Dio _publicDio;
  final Dio _authenticatedDio;

  const AuthenticationService({
    required Dio publicDio,
    required Dio authenticatedDio,
  })  : _publicDio = publicDio,
        _authenticatedDio = authenticatedDio;

  // TODO: Implement register route
  Future<Response> registerUser({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return _publicDio.post(
      "/api/register",
      data: {
        "email": email,
        "password": password,
        "fullname": fullName,
      },
    );
  }

  Future<Response> loginUser({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    return _publicDio.post(
      "/qaapi/token",
      data: {
        "username": username,
        "password": password,
        "rememberMe": rememberMe,
      },
    );
  }

  // TODO: Implement forgot user route route
  Future<Response> forgotUserPassword({required String email}) async {
    return _publicDio.post(
      "/api/password/sendResetLink",
      data: {"email": email},
    );
  }

  // TODO: Implement resend verification email route
  Future<Response> resendVerificationEmail({required String email}) async {
    return _authenticatedDio.post(
      "/api/send-verification-email",
      data: {"email": email},
    );
  }

  // TODO: Implement logout route
  Future<Response> logoutUser() async {
    return _authenticatedDio.post("/api/logout");
  }
}
