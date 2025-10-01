import 'package:flutter/services.dart';
import 'package:fuel/core/input_formaters/formatters.dart';

class PreventSpacesFormatter {
  static List<TextInputFormatter> format() {
    return [Formatters.preventSpaces];
  }
}
