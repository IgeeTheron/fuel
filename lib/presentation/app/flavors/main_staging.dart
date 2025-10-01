import 'package:fuel/core/constants/enums/app_environment.dart';
import 'package:fuel/presentation/app/app_config.dart';

/// The main entry point for the staging version of the application.
///
/// This function is executed when the app is launched in its "staging"
/// environment. It initializes the application by creating a [FlutterAppConfig]
/// specifically configured for [AppEnvironment.staging] and points it to the
/// corresponding environment variable file (`.env-staging`).
///
/// Finally, it calls the [FlutterAppConfig.run] method, which orchestrates
/// the entire application startup process, including service initialization,
/// error handling setup, and the launching of the UI.
void main() async {
  await const FlutterAppConfig(
    environment: AppEnvironment.staging,
    envFilePath: 'keys/env/.env-staging',
  ).run();
}
