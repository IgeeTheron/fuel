import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// TODO: Update with die biblioteek text
class ThemedText {
  static TextTheme themedText = TextTheme(
    displayLarge: TextStyle(fontSize: 57.sp),
    displayMedium: TextStyle(fontSize: 45.sp),
    displaySmall: TextStyle(fontSize: 36.sp),
    headlineLarge: TextStyle(fontSize: 32.sp),
    headlineMedium: TextStyle(fontSize: 28.sp),
    headlineSmall: TextStyle(fontSize: 25.sp),
    titleLarge: TextStyle(fontSize: 22.sp),
    titleMedium: TextStyle(fontSize: 16.sp),
    titleSmall: TextStyle(fontSize: 14.sp),
    labelLarge: TextStyle(fontSize: 14.sp),
    labelMedium: TextStyle(fontSize: 12.sp),
    labelSmall: TextStyle(fontSize: 11.sp),
    bodyLarge: TextStyle(fontSize: 16.sp),
    bodyMedium: TextStyle(fontSize: 14.sp),
    bodySmall: TextStyle(fontSize: 12.sp),
  );
}

extension TextThemeExtras on TextTheme {
  TextStyle? dbLabelLarge() => labelLarge?.copyWith(fontSize: 16.sp, height: 1.5, letterSpacing: 0.2);
}
