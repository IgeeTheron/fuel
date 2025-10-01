/// The code is defining an enumeration called `PasswordValidationError` in Dart.
/// This enumeration represents different types of password validation errors that
/// can occur. The enum has five possible values: `empty`, `length`, `spaces`,
/// `invalid`, and `doesNotMatch`. These values can be used to identify and handle
/// specific types of password validation errors in the code.
enum PasswordValidationError {
  empty,
  length,
  spaces,
  invalid,
  doesNotMatch,
}

/// The `extension PasswordValidationErrorExtension` is adding a computed property
/// called `message` to the `PasswordValidationError` enumeration. This extension
/// allows you to access the `message` property directly on instances of the
/// `PasswordValidationError` enumeration.
extension PasswordValidationErrorExtension on PasswordValidationError {
  /// The `String get message` is a computed property defined in the
  /// `PasswordValidationErrorExtension` extension. It returns a descriptive message
  /// for each possible value of the `PasswordValidationError` enumeration.
  String get message {
    switch (this) {
      case PasswordValidationError.empty:
        return "Please enter a password.";
      case PasswordValidationError.length:
        return "Password must be at least 8 characters long.";
      case PasswordValidationError.spaces:
        return "Password must not contain any spaces.";
      case PasswordValidationError.invalid:
        return "Password must contain at least one uppercase letter, one lowercase letter, one number and one special character.";
      case PasswordValidationError.doesNotMatch:
        return "New password can not be the same as the old password";
    }
  }
}
