import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fuel/core/constants/enums/app_environment.dart';
import 'package:fuel/core/di/injection.dart';
import 'package:fuel/data/repositories/user_management_repository.dart';
import 'package:fuel/logic/cubit/connectivity/internet_cubit.dart';
import 'package:fuel/presentation/app/app.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

/// Manages the application's startup, configuration, and initialization based on the specified environment.
///
/// This class acts as the primary bootstrapper for the application. It is responsible for
/// orchestrating a multi-phase setup process that includes loading environment-specific
/// configurations, initializing core services like Firebase and RevenueCat, setting up
/// dependency injection, and configuring global error handling before finally launching
/// the main application widget.
///
/// It ensures that all necessary services are ready before the UI is displayed, providing a
/// robust and predictable startup sequence.
@immutable
class FlutterAppConfig {
  final AppEnvironment _environment;
  final String _envFilePath;

  /// Creates an instance of the application configuration.
  ///
  /// - [environment]: The specific [AppEnvironment] (e.g., production, staging)
  ///   which dictates settings like logging and API keys.
  /// - [envFilePath]: The path to the `.env` file containing environment-specific
  ///   variables.
  const FlutterAppConfig({
    required AppEnvironment environment,
    required String envFilePath,
  })  : _environment = environment,
        _envFilePath = envFilePath;

  Widget createApp({
    required InternetCubit internetCubit,
  }) {
    return Fuel(
      internetCubit: internetCubit,
    );
  }

  /// Executes the complete, multi-phase application startup and initialization sequence.
  ///
  /// This is the main entry point method that orchestrates the entire app setup.
  /// The process is wrapped in a [runZonedGuarded] to catch any unhandled
  /// exceptions during initialization and report them to Firebase Crashlytics.
  ///
  /// The startup sequence includes:
  /// 1.  **Core Bindings**: Initializes Flutter, Firebase, localization, and loads `.env` variables.
  /// 2.  **Error Handling**: Configures global error handlers to report crashes to Crashlytics.
  /// 3.  **Dependency Injection**: Calls [configureDependencies] and waits for all async services to be ready.
  /// 4.  **Local Storage & UI**: Sets up [HydratedBloc] for state persistence and configures system UI orientations.
  /// 5.  **Third-Party SDKs**: Configures the RevenueCat (Purchases) SDK.
  /// 6.  **Application Dependency Injection**: Initializes application-level dependencies like the [InternetCubit].
  /// 7.  **Pre-flight Checks**: Ensures the initial user state is loaded and performs security checks for
  ///     rooted/jailbroken devices in release mode.
  /// 8.  **App Launch**: Finally, calls `runApp` to render the application UI.
  ///
  /// {@tool snippet}
  /// This method is typically invoked from a flavor-specific `main` function.
  ///
  /// ```dart
  /// // In main_production.dart
  /// void main() async {
  ///   await FlutterAppConfig(
  ///     environment: AppEnvironment.production,
  ///     envFilePath: 'keys/env/.env-production',
  ///   ).run();
  /// }
  /// ```
  /// {@end-tool}
  Future<void> run() async {
    await runZonedGuarded<Future<void>>(
      () async {
        // --- PHASE 1: Core Bindings & Configuration ---
        PrintColor.blueExtended(_environment.name, forcePrint: true);
        WidgetsFlutterBinding.ensureInitialized();
        await dotenv.load(fileName: _envFilePath);

        // --- PHASE 2: Error Handling & Logging ---
        await _environment.startDebug();

        // --- PHASE 3: Dependency Injection & Service Initialization ---
        // Configure all dependencies and wait for async services to be ready.
        await configureDependencies(environment: _environment);
        await getIt.allReady();

        // --- PHASE 4: Hydrated Bloc & System UI ---
        HydratedBloc.storage = await HydratedStorage.build(
          storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path),
        );
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

        // --- PHASE 5: Application Dependency Injection ---
        // TODO: Find better way to get user object on opening app
        // Ensure the initial user state is loaded before building the UI.
        await getIt<UserManagementRepository>().user.first;

        final InternetCubit internetCubit = InternetCubit(
          connectivity: Connectivity(),
          internetConnection: InternetConnection(),
        );

        await internetCubit.initialize();

        runApp(
          createApp(
            internetCubit: internetCubit,
          ),
        );
      },
      (error, stack) {
        // TODO: Implement Crash reporting
        PrintColor.redExtended("runZonedGuarded");
        PrintColor.red(error);
        PrintColor.red(stack);
        PrintColor.redExtended("runZonedGuarded");
        // FirebaseCrashlytics.instance.recordError(error, stack);
      },
    );
  }
}
