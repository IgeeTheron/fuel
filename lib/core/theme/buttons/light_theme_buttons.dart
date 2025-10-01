import 'package:flutter/material.dart';
import 'package:fuel/core/theme/colors/light_theme_colors.dart';
import 'package:fuel/core/theme/text/text_theme.dart';

class LightThemeButtons {
  static ElevatedButtonThemeData primaryElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.onPrimary,
        backgroundColor: LightThemeColors.colorScheme.primary,
        disabledForegroundColor: LightThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: LightThemeColors.colorScheme.surfaceDim,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
        elevation: 0,
      ),
    );
  }

  // TODO: Style or remove if not in use
  static ElevatedButtonThemeData secondaryElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.onSecondaryContainer,
        backgroundColor: LightThemeColors.colorScheme.surfaceContainerLowest,
        disabledForegroundColor: LightThemeColors.colorScheme.onSurface,
        disabledBackgroundColor: LightThemeColors.colorScheme.surfaceContainerLow,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: LightThemeColors.colorScheme.secondary),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        elevation: 0,
      ),
    );
  }

  static ElevatedButtonThemeData tertiaryElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.onPrimary,
        backgroundColor: LightThemeColors.colorScheme.tertiary,
        disabledForegroundColor: LightThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: LightThemeColors.colorScheme.secondaryContainer,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
        elevation: 0,
      ),
    );
  }

  static ElevatedButtonThemeData errorElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.error,
        backgroundColor: LightThemeColors.colorScheme.onError,
        disabledForegroundColor: LightThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: LightThemeColors.colorScheme.secondaryContainer,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: LightThemeColors.colorScheme.error),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        elevation: 0,
      ),
    );
  }

  static TextButtonThemeData primaryTextButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.onSurface,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  static TextButtonThemeData secondaryTextButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.error,
        textStyle: ThemedText.themedText.dbLabelLarge()?.copyWith(
              color: LightThemeColors.colorScheme.error,
              decoration: TextDecoration.underline,
              decorationColor: LightThemeColors.colorScheme.error,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  static TextButtonThemeData tertiaryTextButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.onPrimaryContainer,
        textStyle: ThemedText.themedText.dbLabelLarge()?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: LightThemeColors.colorScheme.onPrimaryContainer,
            ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  static IconButtonThemeData primaryIconButtonThemeData() {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.onPrimaryContainer,
        backgroundColor: LightThemeColors.colorScheme.surfaceBright,
        disabledForegroundColor: LightThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: LightThemeColors.colorScheme.surfaceDim,
        elevation: 0,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static IconButtonThemeData errorIconButtonThemeData() {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: LightThemeColors.colorScheme.error,
        backgroundColor: Colors.transparent,
        disabledForegroundColor: LightThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: LightThemeColors.colorScheme.surfaceDim,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        highlightColor: WidgetStateColor.resolveWith((states) {
          return LightThemeColors.colorScheme.errorContainer;
        }),
      ),
    );
  }
}
