import 'package:flutter/services.dart';

/// The `Formatters` class in Dart provides a static method `preventSpaces` that
/// returns a `TextInputFormatter` to prevent spaces in text input.
class Formatters {
  /// The line `static TextInputFormatter get preventSpaces =>
  /// FilteringTextInputFormatter.deny(RegExp(r"\s"));` is defining a static getter
  /// method called `preventSpaces` in the `Formatters` class.
  static TextInputFormatter get preventSpaces => FilteringTextInputFormatter.deny(RegExp(r"\s"));

  static TextInputFormatter get trim => FilteringTextInputFormatter.deny(RegExp(r'^\s|\s$'));
}
