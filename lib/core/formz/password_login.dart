import 'package:formz/formz.dart';
import 'package:fuel/core/constants/enums/validations/password_validation_error.dart';

/// The `PasswordLogin` class is a form input field for password login that
/// validates if the value is empty.
class PasswordLogin extends FormzInput<String, PasswordValidationError> {
  const PasswordLogin.pure([super.value = '']) : super.pure();

  const PasswordLogin.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }

    return null;
  }
}
