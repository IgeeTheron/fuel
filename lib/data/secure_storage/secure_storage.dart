import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fuel/data/models/user_management/auth_token_model.dart';
import 'package:general_utilities/general_utilities.dart';

/// A singleton class for securely storing and retrieving sensitive application data,
/// particularly authentication tokens, using `flutter_secure_storage`.
///
/// This class ensures that authentication tokens are stored persistently and
/// securely on the device, inaccessible to other applications. It provides
/// methods to save, retrieve, and delete [AuthTokenModel] instances.
///
/// It uses a private constructor and a static `instance` getter to implement
/// the singleton pattern, ensuring only one instance of `SecureStorage` exists
/// throughout the application.
///
/// Related: [AuthTokenModel], [FlutterSecureStorage]
@immutable
class SecureStorage {
  /// Private constructor to enforce the singleton pattern.
  ///
  /// {@template secure_storage_private_constructor}
  /// This constructor is private, meaning that `SecureStorage` cannot be
  /// instantiated directly from outside the class. Instead, the single
  /// instance is accessed via the [SecureStorage.instance] getter.
  /// {@endtemplate}
  const SecureStorage._privateConstructor();

  /// The private, static, final instance of the [SecureStorage] singleton.
  ///
  /// This is initialized once and is exposed via the public [instance] getter.
  static final SecureStorage _instance = const SecureStorage._privateConstructor();

  /// The singleton instance of [SecureStorage].
  ///
  /// {@macro secure_storage_private_constructor}
  ///
  /// Usage example:
  /// ```dart
  /// final secureStorage = SecureStorage.instance;
  /// ```
  static SecureStorage get instance => _instance;

  /// The underlying `FlutterSecureStorage` instance used for secure data operations.
  ///
  /// This is the direct interface to the platform-specific secure storage mechanisms.
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// The key used to store and retrieve the authentication token model in secure storage.
  ///
  /// This key is retrieved from environment variables using `dotenv.get('key_tokens')`.
  ///
  /// Throws a [MissingRequiredKeyException] if 'key_tokens' is not found
  /// in the loaded environment variables.
  static final String _keyTokens = dotenv.get('key_tokens');

  /// Saves an [AuthTokenModel] instance to secure storage.
  ///
  /// The [AuthTokenModel] is first converted to a JSON string before being
  /// written to storage under the key defined by [_keyTokens].
  ///
  /// Parameters:
  /// - `authTokenModel`: The [AuthTokenModel] instance to be securely stored.
  ///
  /// Returns:
  /// A `Future<void>` that completes when the data has been written.
  ///
  /// Throws:
  /// - [PlatformException] if there is an error interacting with the
  ///   underlying platform's secure storage.
  ///
  /// Usage example:
  /// ```dart
  /// final authToken = AuthTokenModel(accessToken: '...', refreshToken: '...', ...);
  /// await SecureStorage.instance.setAuthTokenModel(authToken);
  /// ```
  /// See also: [authTokenModelToJson]
  Future<void> setAuthTokenModel(AuthTokenModel authTokenModel) async {
    await storage.write(
      key: _keyTokens,
      value: json.encode(authTokenModel.toJson()),
    );
  }

  /// Retrieves and decodes the [AuthTokenModel] from secure storage.
  ///
  /// This method reads the JSON string stored under [_keyTokens], if it exists,
  /// and then converts it back into an [AuthTokenModel] instance.
  ///
  /// Returns:
  /// A `Future` that resolves to the [AuthTokenModel] if found and successfully
  /// decoded, otherwise `null`.
  ///
  /// Throws:
  /// - [PlatformException] if there is an error interacting with the
  ///   underlying platform's secure storage.
  /// - [FormatException] if the stored JSON string is malformed and cannot
  ///   be parsed into an [AuthTokenModel].
  ///
  /// Usage example:
  /// ```dart
  /// final authToken = await SecureStorage.instance.getAuthTokenModel();
  /// if (authToken != null) {
  ///   print('Access Token: ${authToken.accessToken}');
  /// } else {
  ///   print('No auth token found.');
  /// }
  /// ```
  /// See also: [authTokenModelFromJson]
  Future<AuthTokenModel?> getAuthTokenModel() async {
    try {
      final String? jsonAuthTokenModel = await storage.read(key: _keyTokens);

      if (jsonAuthTokenModel != null) {
        return AuthTokenModel.fromJson(json.decode(jsonAuthTokenModel), false);
      }

      return null;
    } on PlatformException catch (e) {
      if (e.message?.contains('javax.crypto.BadPaddingException') ?? false) {
        PrintColor.red('Failed to decrypt data, clearing all secure storage. This is expected after an app reinstall or data clear.');
        await deleteSecureStorageData();
        return null;
      } else {
        rethrow;
      }
    } catch (e) {
      PrintColor.red('An unexpected error occurred while reading the auth token: $e. Clearing storage.');
      await deleteSecureStorageData();
      return null;
    }
  }

  /// Deletes only the authentication token model from secure storage.
  ///
  /// This provides a targeted way to remove user session credentials without
  /// affecting other data stored securely. It's particularly useful when a
  /// token refresh fails and the invalid token must be cleared.
  ///
  /// {@tool snippet}
  /// A typical use case is during a manual logout process where you want
  /// to clear the user's session without affecting other secure data.
  ///
  /// ```dart
  /// Future<void> logout() async {
  ///   // Perform other logout logic...
  ///   await SecureStorage.instance.deleteAuthTokenModelData();
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// Throws a [PlatformException] if there is an error interacting with the
  /// underlying platform's secure storage.
  ///
  /// See also:
  ///  * [deleteSecureStorageData], for clearing all data.
  Future<void> deleteAuthTokenModelData() async {
    await storage.delete(key: _keyTokens);
  }

  /// Deletes all key-value pairs stored by the application in secure storage.
  ///
  /// This method is typically used during logout or account deletion to ensure
  /// all sensitive data, including authentication tokens, is removed from the device.
  ///
  /// Returns:
  /// A `Future<void>` that completes when all data has been deleted.
  ///
  /// Throws:
  /// - [PlatformException] if there is an error interacting with the
  ///   underlying platform's secure storage.
  ///
  /// Usage example:
  /// ```dart
  /// await SecureStorage.instance.deleteSecureStorageData();
  /// print('All secure storage data cleared.');
  /// ```
  Future<void> deleteSecureStorageData() async {
    await storage.deleteAll();
  }
}
