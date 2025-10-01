import 'package:formz/formz.dart';

class Username extends FormzInput<String, String?> {
  const Username.pure([super.value = '']) : super.pure();

  const Username.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return "Please enter a username";
    }

    return null;
  }
}
