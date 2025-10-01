import 'package:flutter/material.dart';
import 'package:fuel/core/theme/colors/dark_theme_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// TODO: Update with baobab inputs
class DarkThemeInputs {
  static InputDecorationTheme primaryInputDecorationTheme() {
    return InputDecorationTheme(
      prefixIconColor: DarkThemeColors.colorScheme.primary,
      suffixIconColor: DarkThemeColors.colorScheme.primary,
      fillColor: Colors.transparent,
      helperMaxLines: 3,
      hintStyle: TextStyle(color: DarkThemeColors.colorScheme.onSurfaceVariant),
      errorStyle: TextStyle(
        fontSize: 14.sp,
        letterSpacing: 0.4,
        color: DarkThemeColors.colorScheme.error,
        fontWeight: FontWeight.w600,
      ),
      errorMaxLines: 3,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: DarkThemeColors.colorScheme.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkThemeColors.colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  static InputDecoration profileInputDecoration() {
    return InputDecoration(
      prefixIconColor: DarkThemeColors.colorScheme.primary,
      suffixIconColor: DarkThemeColors.colorScheme.primary,
      fillColor: Colors.transparent,
      helperMaxLines: 3,
      hintStyle: TextStyle(color: DarkThemeColors.colorScheme.inverseSurface),
      errorStyle: TextStyle(
        fontSize: 14.sp,
        letterSpacing: 0.4,
        color: DarkThemeColors.colorScheme.error,
        fontWeight: FontWeight.w600,
      ),
      errorMaxLines: 3,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: DarkThemeColors.colorScheme.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkThemeColors.colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  static InputDecoration searchInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: DarkThemeColors.colorScheme.surfaceBright,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
