import 'package:flutter/material.dart';
import 'package:fuel/core/theme/colors/light_theme_colors.dart';
import 'package:fuel/core/theme/text/text_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LightThemeInputs {
  static InputDecorationTheme primaryInputDecorationTheme() {
    return InputDecorationTheme(
      prefixIconColor: LightThemeColors.colorScheme.primary,
      suffixIconColor: LightThemeColors.colorScheme.primary,
      fillColor: Colors.transparent,
      helperMaxLines: 3,
      hintStyle: ThemedText.themedText.bodyLarge?.copyWith(color: LightThemeColors.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
      errorStyle: TextStyle(
        fontSize: 14.sp,
        letterSpacing: 0.4,
        color: LightThemeColors.colorScheme.error,
        fontWeight: FontWeight.w600,
      ),
      errorMaxLines: 3,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColors.colorScheme.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightThemeColors.colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static InputDecoration profileInputDecoration() {
    return InputDecoration(
      prefixIconColor: LightThemeColors.colorScheme.primary,
      suffixIconColor: LightThemeColors.colorScheme.primary,
      fillColor: Colors.transparent,
      helperMaxLines: 3,
      hintStyle: TextStyle(color: LightThemeColors.colorScheme.inverseSurface),
      errorStyle: TextStyle(
        fontSize: 14.sp,
        letterSpacing: 0.4,
        color: LightThemeColors.colorScheme.error,
        fontWeight: FontWeight.w600,
      ),
      errorMaxLines: 3,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: LightThemeColors.colorScheme.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightThemeColors.colorScheme.primary, width: 2),
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
      fillColor: LightThemeColors.colorScheme.surfaceBright,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
