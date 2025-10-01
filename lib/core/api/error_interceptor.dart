import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fuel/core/exceptions/exceptions.dart';
import 'package:get_it/get_it.dart';

/// A Dio interceptor that transforms generic `DioException`s into specific,
/// application-level `AppException`s.
///
/// This class centralizes HTTP error handling by catching raw network errors
/// and mapping them to a set of custom, meaningful exceptions. It inspects the
/// [DioExceptionType] and the HTTP status code to determine the appropriate
/// [AppException] subclass to use.
///
/// This allows the repository and BLoC layers to catch concrete error types like
/// [NetworkException] or [ValidationException] instead of parsing generic
/// [DioException]s, leading to cleaner and more predictable error handling logic.
///
/// See also:
///
///  * [Interceptor], the base class for this interceptor.
///  * [DioException], the exception type that this interceptor handles.
///  * [AppException], the base class for custom application exceptions created here.
class ErrorInterceptor extends Interceptor {
  /// An instance of [GetIt] used for service location and dependency injection.
  ///
  /// This is used to resolve dependencies, such as the [UserManagementRepository],
  /// which is required for handling session-related errors like 401 Unauthorized.
  final GetIt getIt;

  /// Creates an instance of the error interceptor.
  ///
  /// Requires a [GetIt] instance to resolve dependencies, such as the
  /// [UserManagementRepository] needed for handling session expiration.
  ErrorInterceptor(this.getIt);

  static bool _isLoggingOut = false;

  /// Intercepts a network error and transforms it into a custom [AppException].
  ///
  /// This method is automatically called by Dio when a request fails. It
  /// categorizes errors based on their type and status code:
  ///
  /// - **Connection Errors**: Timeouts and connectivity issues are mapped to
  ///   [NetworkException].
  /// - **Response Errors**:
  ///   - `401`: Mapped to [UnauthorizedException]. This indicates an expired or
  ///     invalid session, typically after `fresh_dio` fails a token refresh,
  ///     and triggers a global user logout.
  ///   - `403`: Mapped to [ForbiddenException] for permission errors.
  ///   - `404`: Mapped to [NotFoundException] for missing resources.
  ///   - `409`: Mapped to [ConflictException] for duplicate data errors.
  ///   - `422`: Mapped to [ValidationException], including detailed field errors.
  ///   - `5xx`: Mapped to a general [ServerException].
  /// - **Cancelled Requests**: Mapped to [RequestCancelledException].
  /// - **Unknown Errors**: Mapped to a general [ServerException].
  ///
  /// The original [DioException] is logged to Firebase Crashlytics for debugging,
  /// then replaced with a new one that wraps the custom [AppException] in its
  /// `error` field before being passed to the next [handler] in the chain.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 1. Map the raw DioException to a custom, more specific AppException.
    final AppException customException = _mapDioExceptionToAppException(err);

    // 2. Log the original, detailed error to Crashlytics for debugging.
    // We log the original `err` because it contains the full request/response context.
    // TODO: Add error logging
    // FirebaseCrashlytics.instance.recordError(
    //   err,
    //   err.stackTrace,
    //   reason: 'A DioException occurred in ErrorInterceptor',
    //   fatal: false, // Mark as non-fatal as we are handling it.
    // );

    // 3. Create a new DioException that wraps our custom exception.
    // This allows the repository/bloc layers to catch specific AppExceptions.
    final newDioException = DioException(
      requestOptions: err.requestOptions,
      error: customException,
      // The important part: embedding our custom error.
      response: err.response,
      type: err.type,
      message: err.message,
    );

    return handler.next(newDioException);
  }

  /// A helper function to map a [DioException] to a corresponding [AppException].
  ///
  /// This centralizes the error mapping logic, keeping the `onError` method clean.
  /// It also enriches the custom exception with the original [DioException] for
  /// more detailed debugging context.
  @protected
  AppException _mapDioExceptionToAppException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(originalException: err);

      case DioExceptionType.badCertificate:
        return CertificatePinningException(originalException: err);

      case DioExceptionType.badResponse:
        final responseData = err.response?.data;
        String? errorMessage;

        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['error_description'] ?? responseData['message'];
        }

        switch (err.response?.statusCode) {
          case 400:
            return ServerException(message: errorMessage, originalException: err);
          case 401:
            if (!_isLoggingOut) {
              _isLoggingOut = true;

              // TODO: Implement message when token expires and logs user out
              // if (getIt<UserManagementRepository>().currentUser.isNotEmpty) {
              //   getIt<ToastService>().showErrorToast("Your session has expired; please log back in.");
              // }
              //
              // getIt<UserManagementRepository>().logOutUser().then((_) {
              //   _isLoggingOut = false;
              // });
            }
            return UnauthorizedException(message: errorMessage, originalException: err);
          case 403:
            return ForbiddenException(message: errorMessage, originalException: err);
          case 404:
            return NotFoundException(message: errorMessage, originalException: err);
          case 409:
            return ConflictException(message: errorMessage, originalException: err);
          case 422:
            final errors = responseData?['errors'] as Map<String, dynamic>? ?? {};
            return ValidationException(message: errorMessage, errors: errors, originalException: err);
          case 500:
          case 502:
          case 503:
            return ServerException(message: errorMessage, originalException: err);
          default:
            return ServerException(message: errorMessage, originalException: err);
        }

      case DioExceptionType.cancel:
        return RequestCancelledException(originalException: err);

      case DioExceptionType.unknown:
        // The 'unknown' type can wrap various errors. We inspect the underlying
        // error to provide a more specific exception type.
        // TODO: Implement certificate pinning
        // final innerError = err.error;
        // if (innerError is HandshakeException || innerError is CertificateNotVerifiedException || innerError is CertificateCouldNotBeVerifiedException) {
        //   // These specific errors are related to SSL/TLS and certificate
        //   // validation, so we map them to our custom pinning exception.
        //   return CertificatePinningException(originalException: err);
        // }

        // For any other unknown error, we fall back to a generic ServerException.
        return ServerException(originalException: err);
    }
  }
}
