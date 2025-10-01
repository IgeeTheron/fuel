import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel/logic/debug/app_bloc_observer.dart';
import 'package:general_utilities/general_utilities.dart';

/// Defines the possible runtime environments for the application.
///
/// This enum is used to differentiate between builds and alter application
/// behavior accordingly. For example, API endpoints, logging levels, and
/// debugging tools can be configured based on the current environment.
///
/// - `development`: For use on a developer's local machine. Enables detailed
///   logging and debugging tools.
/// - `staging`: Represents a pre-production environment that mirrors production.
///   Used for QA and final testing.
/// - `production`: The live environment for end-users. Debugging tools are
///   disabled, and logging is minimized.
enum AppEnvironment {
  development,
  staging,
  production,
}

/// Provides utility methods and properties for the [AppEnvironment] enum.
///
/// This extension adds convenient functionality, such as boolean getters to
/// easily check the current environment and a method to perform
/// environment-specific initializations.
///
/// ```dart
/// AppEnvironment currentEnv = AppEnvironment.development;
///
/// if (!currentEnv.isProduction) {
///   print('This is a debug or staging build.');
/// }
/// ```
/// See also:
///  * [AppEnvironment], the enum this extension operates on.
extension AppEnvironmentExtension on AppEnvironment {
  /// Returns `true` if the current environment is [AppEnvironment.staging].
  ///
  /// This is a convenience getter to avoid manual comparison.
  ///
  /// `if (env.isStaging) { ... }`
  bool get isStaging => this == AppEnvironment.staging;

  /// Returns `true` if the current environment is [AppEnvironment.production].
  ///
  /// This is a convenience getter to check if the app is running in the live
  /// environment.
  ///
  /// `if (env.isProduction) { ... }`
  bool get isProduction => this == AppEnvironment.production;

  /// Initializes environment-specific debugging and logging configurations.
  ///
  /// This method should be called during application startup to configure
  /// debugging tools based on the runtime environment.
  ///
  /// For [AppEnvironment.development] and [AppEnvironment.staging], it sets
  /// a [Bloc.observer] to an instance of [AppBlocObserver] and sets the
  /// `Purchases` SDK log level to debug.
  ///
  /// For [AppEnvironment.production], it disables colored console output from the
  /// `general_utilities` package to ensure cleaner, production-ready logs.
  ///
  /// {@tool snippet}
  ///
  /// This should be one of the first calls in your `main` function.
  ///
  /// ```dart
  /// Future<void> main() async {
  ///   // Assume 'env' is determined from build configurations.
  ///   const AppEnvironment env = AppEnvironment.development;
  ///
  ///   await env.startDebug();
  ///
  ///   // ... rest of your app initialization.
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///  * [Bloc.observer], which this method configures for debug builds.
  ///  * [AppBlocObserver], the observer used to log BLoC events.
  Future<void> startDebug() async {
    switch (this) {
      case AppEnvironment.development:
      case AppEnvironment.staging:
        {
          Bloc.observer = AppBlocObserver();
          break;
        }
      case AppEnvironment.production:
        {
          PrintColor.inDebugMode = false;
          break;
        }
    }
  }
}
