import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel/core/theme/buttons/dark_theme_buttons.dart';
import 'package:fuel/core/theme/buttons/light_theme_buttons.dart';
import 'package:fuel/core/theme/colors/dark_theme_colors.dart';
import 'package:fuel/core/theme/colors/light_theme_colors.dart';
import 'package:fuel/core/theme/inputs/dark_theme_inputs.dart';
import 'package:fuel/core/theme/inputs/light_theme_inputs.dart';
import 'package:fuel/core/theme/text/text_theme.dart';
import 'package:fuel/presentation/app/app.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme() {
    return ThemeData(
      textTheme: ThemedText.themedText,
      colorScheme: LightThemeColors.colorScheme,
      elevatedButtonTheme: LightThemeButtons.primaryElevatedButtonThemeData(),
      textButtonTheme: LightThemeButtons.primaryTextButtonThemeData(),
      iconButtonTheme: LightThemeButtons.primaryIconButtonThemeData(),
      inputDecorationTheme: LightThemeInputs.primaryInputDecorationTheme(),
      bottomSheetTheme: BottomSheetThemeData(
        modalBarrierColor: Colors.black.withValues(alpha: 0.8),
      ),
    );
  }

  /// Provides the `ThemeData` for the application's dark mode.
  ///
  /// This theme is configured with colors from [DarkThemeColors], component
  /// styles from [DarkThemeButtons] and [DarkThemeInputs], and custom
  /// design system values via the [Spacing] and [CornerRadius] theme extensions.
  static ThemeData darkTheme() {
    return ThemeData(
      textTheme: ThemedText.themedText,
      colorScheme: DarkThemeColors.colorScheme,
      elevatedButtonTheme: DarkThemeButtons.primaryElevatedButtonThemeData(),
      textButtonTheme: DarkThemeButtons.primaryTextButtonThemeData(),
      iconButtonTheme: DarkThemeButtons.primaryIconButtonThemeData(),
      inputDecorationTheme: DarkThemeInputs.primaryInputDecorationTheme(),
      bottomSheetTheme: BottomSheetThemeData(
        modalBarrierColor: DarkThemeColors.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
    );
  }

  /// Configures the appearance of the native system UI overlays.
  ///
  /// This method sets the status bar and navigation bar colors and icon brightness
  /// to match the selected [themeMode], ensuring a cohesive visual experience
  /// between the app and the underlying operating system UI.
  ///
  /// [themeMode] determines whether to apply light or dark styles.
  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: (themeMode == ThemeMode.light) ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: (themeMode == ThemeMode.light) ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness: (themeMode == ThemeMode.light) ? Brightness.dark : Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: (themeMode == ThemeMode.light) ? LightThemeColors.colorScheme.surfaceBright : DarkThemeColors.colorScheme.surfaceBright,
      ),
    );
  }
}

/// An extension on [ThemeData] to provide convenient access to custom design system values.
///
/// This extension simplifies accessing custom spacing, corner radii, colors,
/// shadows, and alternate component styles directly from a `ThemeData` instance
/// (e.g., `Theme.of(context)`). It promotes code consistency and reduces
/// boilerplate when applying the app's design system.
///
/// {@tool snippet}
/// Instead of manually defining values, you can use the extension like this:
///
/// ```dart
/// Container(
///   padding: EdgeInsets.all(Theme.of(context).spacing_8),
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(Theme.of(context).radius_5),
///     boxShadow: [Theme.of(context).customBoxShadowBottom],
///   ),
/// )
/// ```
/// {@end-tool}
extension ThemeExtras on ThemeData {
  // region Other
  double get pixelRatio => MediaQuery.of(navigatorKey.currentState!.context).devicePixelRatio;

  Color get shimmerBaseColor => LightThemeColors.colorScheme.surfaceContainerHighest;
  Color get shimmerHighlightColor => LightThemeColors.colorScheme.surfaceContainer;

  BoxShadow get customBoxShadowTop {
    return BoxShadow(
      color: colorScheme.shadow.withValues(alpha: 0.04),
      offset: const Offset(0, -3),
      blurRadius: 6,
      spreadRadius: 1,
    );
  }

  BoxShadow get customBoxShadowBottom {
    return BoxShadow(
      color: colorScheme.shadow.withValues(alpha: 0.05),
      offset: const Offset(0, 3),
      blurRadius: 6,
      spreadRadius: 1,
    );
  }

  ButtonStyle secondaryElevatedButtonStyle() => (brightness == Brightness.light) ? LightThemeButtons.secondaryElevatedButtonThemeData().style! : DarkThemeButtons.secondaryElevatedButtonThemeData().style!;

  ButtonStyle tertiaryElevatedButtonStyle() => (brightness == Brightness.light) ? LightThemeButtons.tertiaryElevatedButtonThemeData().style! : DarkThemeButtons.tertiaryElevatedButtonThemeData().style!;

  ButtonStyle errorElevatedButtonStyle() => (brightness == Brightness.light) ? LightThemeButtons.errorElevatedButtonThemeData().style! : DarkThemeButtons.errorElevatedButtonThemeData().style!;

  ButtonStyle secondaryTextButtonStyle() => (brightness == Brightness.light) ? LightThemeButtons.secondaryTextButtonThemeData().style! : DarkThemeButtons.secondaryTextButtonThemeData().style!;

  ButtonStyle tertiaryTextButtonStyle() => (brightness == Brightness.light) ? LightThemeButtons.tertiaryTextButtonThemeData().style! : DarkThemeButtons.tertiaryTextButtonThemeData().style!;

  ButtonStyle errorIconButtonStyle() => (brightness == Brightness.light) ? LightThemeButtons.errorIconButtonThemeData().style! : DarkThemeButtons.errorIconButtonThemeData().style!;

  InputDecoration get profileInputDecoration => (brightness == Brightness.light) ? LightThemeInputs.profileInputDecoration() : DarkThemeInputs.profileInputDecoration();

  InputDecoration get searchInputDecoration => (brightness == Brightness.light) ? LightThemeInputs.searchInputDecoration() : DarkThemeInputs.searchInputDecoration();
//endregion
}
