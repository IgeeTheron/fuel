import 'package:flutter/material.dart';
import 'package:fuel/core/theme/colors/dark_theme_colors.dart';
import 'package:fuel/core/theme/text/text_theme.dart';

// TODO: Update with baobab buttons
class DarkThemeButtons {
  static ElevatedButtonThemeData primaryElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: DarkThemeColors.colorScheme.onPrimary,
        backgroundColor: DarkThemeColors.colorScheme.primary,
        disabledForegroundColor: DarkThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: DarkThemeColors.colorScheme.surfaceDim,
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
        foregroundColor: DarkThemeColors.colorScheme.secondary,
        backgroundColor: DarkThemeColors.colorScheme.surfaceContainerLowest,
        disabledForegroundColor: DarkThemeColors.colorScheme.onSurface,
        disabledBackgroundColor: DarkThemeColors.colorScheme.surfaceContainerLow,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: DarkThemeColors.colorScheme.secondary),
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
        foregroundColor: DarkThemeColors.colorScheme.onPrimary,
        backgroundColor: DarkThemeColors.colorScheme.tertiary,
        disabledForegroundColor: DarkThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: DarkThemeColors.colorScheme.secondaryContainer,
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
        foregroundColor: DarkThemeColors.colorScheme.error,
        backgroundColor: DarkThemeColors.colorScheme.onError,
        disabledForegroundColor: DarkThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: DarkThemeColors.colorScheme.secondaryContainer,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: DarkThemeColors.colorScheme.error),
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
        foregroundColor: DarkThemeColors.colorScheme.onSurface,
        textStyle: ThemedText.themedText.dbLabelLarge(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  // TODO: Style or remove if not in use
  static TextButtonThemeData secondaryTextButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DarkThemeColors.colorScheme.error,
        textStyle: ThemedText.themedText.dbLabelLarge()?.copyWith(
              color: DarkThemeColors.colorScheme.error,
              decoration: TextDecoration.underline,
              decorationColor: DarkThemeColors.colorScheme.error,
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
        foregroundColor: DarkThemeColors.colorScheme.onPrimaryContainer,
        textStyle: ThemedText.themedText.dbLabelLarge()?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: DarkThemeColors.colorScheme.onPrimaryContainer,
            ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  static IconButtonThemeData primaryIconButtonThemeData() {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: DarkThemeColors.colorScheme.onPrimaryContainer,
        backgroundColor: Colors.transparent,
        disabledForegroundColor: DarkThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: DarkThemeColors.colorScheme.surfaceDim,
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
        foregroundColor: DarkThemeColors.colorScheme.error,
        backgroundColor: Colors.transparent,
        disabledForegroundColor: DarkThemeColors.colorScheme.onSurfaceVariant,
        disabledBackgroundColor: DarkThemeColors.colorScheme.surfaceDim,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        highlightColor: WidgetStateColor.resolveWith((states) {
          return DarkThemeColors.colorScheme.errorContainer;
        }),
      ),
    );
  }
}
