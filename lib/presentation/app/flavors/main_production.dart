import 'package:fuel/core/constants/enums/app_environment.dart';
import 'package:fuel/presentation/app/app_config.dart';

/// The main entry point for the production version of the application.
///
/// This function is executed when the app is launched in its live "production"
/// environment. It initializes the application by creating a [FlutterAppConfig]
/// instance configured for [AppEnvironment.production] and provides the path
/// to the `.env-production` file, which contains the live API keys and
/// endpoints.
///
/// It then calls the [FlutterAppConfig.run] method to orchestrate the entire
/// application startup process, including all service initializations and
/// the launch of the root widget.
void main() async {
  await const FlutterAppConfig(
    environment: AppEnvironment.production,
    envFilePath: 'keys/env/.env-production',
  ).run();
}
