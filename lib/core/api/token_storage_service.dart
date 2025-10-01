import 'package:fresh_dio/fresh_dio.dart';
import 'package:fuel/core/di/injection.dart';
import 'package:fuel/data/models/user_management/auth_token_model.dart';
import 'package:fuel/data/secure_storage/secure_storage.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that securely stores and retrieves authentication tokens.
///
/// This class implements the `TokenStorage` interface from the `fresh_dio`
/// package, providing a concrete implementation that uses `SecureStorage`
/// for persistent, secure storage of `AuthTokenModel` objects.
class TokenStorageService implements TokenStorage<AuthTokenModel> {
  const TokenStorageService();

  /// Reads the stored `AuthTokenModel` from secure storage.
  ///
  /// Returns the `AuthTokenModel` if it exists, otherwise returns `null`.
  @override
  Future<AuthTokenModel?> read() async {
    return SecureStorage.instance.getAuthTokenModel();
  }

  /// Writes the provided `AuthTokenModel` to secure storage, but only if the
  /// 'rememberMe' preference is set to `true`.
  ///
  /// This method first checks [SharedPreferences] for the 'rememberMe' flag.
  /// If the flag is true, the [token] is serialized and persisted using
  /// [SecureStorage]. If the flag is false or not set, the token is not
  /// stored, effectively creating a session that lasts only until the app
  /// is terminated.
  ///
  /// [token]: The authentication token to be conditionally stored.
  @override
  Future<void> write(AuthTokenModel token) async {
    final prefs = getIt<SharedPreferences>();
    final bool shouldRemember = prefs.getBool('rememberMe') ?? false;

    if (shouldRemember) {
      PrintColor.green("TokenStorageService: Writing token because 'rememberMe' is true.");
      await SecureStorage.instance.setAuthTokenModel(token);
    } else {
      PrintColor.yellow("TokenStorageService: Skipping token write because 'rememberMe' is false.");
    }
  }

  /// Deletes the stored `AuthTokenModel` from secure storage.
  @override
  Future<void> delete() async {
    await SecureStorage.instance.deleteAuthTokenModelData();
  }
}
