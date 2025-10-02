import 'package:dio/dio.dart';

/// A base class for all custom application-specific exceptions.
///
/// This abstract class ensures that all custom exceptions in the application
/// include a user-friendly [message] and the optional [originalException]
/// that caused it, providing a consistent way to handle and debug errors.
abstract class AppException implements Exception {
  final String message;
  final DioException? originalException;

  const AppException({
    required this.message,
    this.originalException,
  });

  @override
  String toString() {
    return '$runtimeType: $message${originalException != null ? '\nOriginal Exception: $originalException' : ''}';
  }
}

/// An exception thrown for general server-side errors (e.g., 500 Internal Server Error).
///
/// This indicates that the request was valid, but the server failed to process it
/// due to an internal issue.
class ServerException extends AppException {
  const ServerException({String? message, super.originalException})
      : super(
          message: message ?? "A server error occurred. Please try again later.",
        );
}

/// An exception thrown when there is a network connectivity issue.
///
/// This can occur due to a variety of reasons, such as a dropped internet
/// connection, DNS resolution failure, or a request timeout.
class NetworkException extends AppException {
  const NetworkException({String? message, super.originalException})
      : super(
          message: message ?? "Please check your network connection and try again.",
        );
}

/// An exception thrown when SSL certificate pinning fails.
///
/// This is a critical security exception indicating that the server's certificate
/// does not match any of the expected SHA-256 fingerprints. This could signify a
/// man-in-the-middle (MITM) attack or a misconfiguration of the trusted
/// certificates.
class CertificatePinningException extends AppException {
  const CertificatePinningException({String? message, super.originalException})
      : super(
          message: message ?? "A secure connection could not be established. To protect your data, this request has been blocked. Please check your network or try again later.",
        );
}

/// An exception thrown for 404 Not Found errors.
///
/// This indicates that the requested resource or endpoint could not be found
/// on the server.
class NotFoundException extends AppException {
  const NotFoundException({String? message, super.originalException})
      : super(
          message: message ?? "The requested item could not be found.",
        );
}

/// An exception thrown for 401 Unauthorized errors.
///
/// This typically means the user's session token is invalid, has expired, or is
/// missing. It often triggers a forced logout and redirection to the login screen.
class UnauthorizedException extends AppException {
  const UnauthorizedException({String? message, super.originalException})
      : super(
          message: message ?? "Your session has expired. Please log in again.",
        );
}

/// An exception thrown for 403 Forbidden errors.
///
/// This indicates that the server understood the request but refuses to authorize it.
/// It differs from a 401 in that the user is authenticated, but lacks the
/// necessary permissions for the specific resource.
class ForbiddenException extends AppException {
  const ForbiddenException({String? message, super.originalException})
      : super(
          message: message ?? "You do not have permission to perform this action.",
        );
}

/// An exception thrown for 409 Conflict errors.
///
/// This indicates that the request could not be completed due to a conflict with
/// the current state of the resource. A common example is attempting to create a
/// resource that already exists (e.g., registering with an email that is
/// already in use).
class ConflictException extends AppException {
  const ConflictException({String? message, super.originalException})
      : super(
          message: message ?? "There was a conflict with the current data. Please refresh and try again.",
        );
}

/// An exception thrown for 422 Unprocessable Entity errors, typically for form validation.
///
/// This exception includes a map of [errors] that provides detailed, field-specific
/// feedback from the server about what data was invalid.
class ValidationException extends AppException {
  /// A map containing field-specific validation errors from the server.
  ///
  /// The keys of the map typically correspond to the input field names
  /// (e.g., 'email', 'password'), and the values are a list of error strings
  /// for that field.
  final Map<String, dynamic> errors;

  const ValidationException({String? message, this.errors = const {}, super.originalException})
      : super(
          message: message ?? "The information provided was invalid.",
        );
}

/// An exception thrown when a network request is cancelled by the client.
///
/// This typically occurs when a user navigates away from a screen
/// or a component is disposed of before a pending Dio request can complete.
/// It's often safe to ignore this error and not display a message to the user,
/// as it represents an intentional cancellation rather than a failure.
class RequestCancelledException extends AppException {
  const RequestCancelledException({String? message, super.originalException})
      : super(
          message: message ?? "The request was cancelled.",
        );
}
