import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:fuel/core/cache/cache.dart';
import 'package:fuel/core/di/injection.dart';
import 'package:fuel/core/exceptions/exceptions.dart';
import 'package:fuel/data/models/user_management/auth_token_model.dart';
import 'package:fuel/data/models/user_management/user_model.dart';
import 'package:fuel/data/providers/authentication_service.dart';
import 'package:fuel/data/providers/user_service.dart';
import 'package:fuel/data/secure_storage/secure_storage.dart';
import 'package:fuel/presentation/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagementRepository {
  final SecureStorage _secureStorage;
  final AuthenticationService _authenticationService;
  final UserService _userService;
  final CacheClient _cacheClient;

  UserManagementRepository({
    required SecureStorage secureStorage,
    required AuthenticationService authenticationService,
    required UserService userService,
    required CacheClient cacheClient,
  })  : _secureStorage = secureStorage,
        _authenticationService = authenticationService,
        _userService = userService,
        _cacheClient = cacheClient;

  static final String userCacheKey = dotenv.get('user_cache_key');
  final StreamController<UserModel> _userController = StreamController<UserModel>();

  Stream<UserModel> get user async* {
    try {
      // TODO: Implement initial API call to determine if user should be taken to auth or home
      // final Response response = await _userService.getUser();
      // UserModel user = UserModel.fromJson(response.data);
      // _cacheClient.write(key: userCacheKey, value: user);
      // yield user;

      _cacheClient.write(key: userCacheKey, value: UserModel.empty);
      yield UserModel.empty;
    } catch (_) {
      _cacheClient.write(key: userCacheKey, value: UserModel.empty);
      yield UserModel.empty;
    }
    yield* _userController.stream;
  }

  UserModel get currentUser {
    return _cacheClient.read<UserModel>(key: userCacheKey) ?? UserModel.empty;
  }

  void _updateUser(UserModel user) {
    _cacheClient.write(key: userCacheKey, value: user);
    _userController.add(user);
  }

  Future<void> getUser() async {
    try {
      // TODO Implement get user API
      // final Response response = await _userService.getUser();
      // UserModel user = UserModel.fromJson(response.data);
      // _updateUser(user);

      _updateUser(
        const UserModel(
          id: 1,
          fullName: "MobileTC",
          email: "igee@test.com",
        ),
      );
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      throw const ServerException(message: "We're having trouble loading your information right now. Please try again later.");
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // TODO: Implement register API
      // final Response response = await _authenticationService.registerUser(
      //   email: email,
      //   password: password,
      //   fullName: fullName,
      // );
      // AuthResponseModel authResponseModel = AuthResponseModel.fromJson(response.data);
      //
      // await getIt<TokenStorage<AuthTokenModel>>().delete();
      // await getIt<Fresh<AuthTokenModel>>().setToken((authResponseModel.token));
      //
      // _updateUser(authResponseModel.user);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      await getIt<TokenStorage<AuthTokenModel>>().delete();
      throw const ServerException(message: "We're having trouble registering you right now. Please try again later.");
    }
  }

  Future<void> loginUser({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final Response response = await _authenticationService.loginUser(
        username: username,
        password: password,
        rememberMe: rememberMe,
      );

      AuthTokenModel authTokenModel = AuthTokenModel.fromJson(response.data, true);

      final prefs = getIt<SharedPreferences>();

      await prefs.setBool('rememberMe', rememberMe);

      if (!rememberMe) {
        await getIt<TokenStorage<AuthTokenModel>>().delete();
      }

      await getIt<Fresh<AuthTokenModel>>().setToken(authTokenModel);

      _updateUser(
        const UserModel(
          id: 1,
          fullName: "MobileTC",
          email: "igee@test.com",
        ),
      );
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      await getIt<TokenStorage<AuthTokenModel>>().delete();
      throw const ServerException(message: "We're having trouble logging you in right now. Please try again later.");
    }
  }

  Future<void> forgotUserPassword({required String email}) async {
    try {
      // TODO: Implement forgot user APIAPI
      // await _authenticationService.forgotUserPassword(email: email);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      throw const ServerException(message: "We're having trouble sending the email to reset your password. Please try again later.");
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      // TODO: Implement resend email verification API
      // await _authenticationService.resendVerificationEmail(email: currentUser.email);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      throw const ServerException(message: "We're having resending the verification e-mail. Please try again later.");
    }
  }

  Future<void> updateUserDetails({
    String? email,
    String? fullName,
  }) async {
    try {
      // TODO: Implement update user API
      // final Response response = await _userService.updateUser(
      //   email: email,
      //   fullName: fullName,
      // );
      // UserModel userModel = UserModel.fromJson(response.data);
      //
      // _updateUser(userModel);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      throw const ServerException(message: "We're having trouble updating your information right now. Please try again later.");
    }
  }

  Future<void> changeUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // TODO: Implement Change user password API
      // await _userService.changePassword(
      //   currentPassword: currentPassword,
      //   newPassword: newPassword,
      // );
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      throw const ServerException(message: "We're having trouble changing your password right now. Please try again later.");
    }
  }

  Future<void> _logout() async {
    final NavigatorState? navigator = navigatorKey.currentState;

    await getIt<Fresh<AuthTokenModel>>().clearToken();
    await _secureStorage.deleteSecureStorageData();
    await getIt<SharedPreferences>().remove('rememberMe');

    if (navigator?.mounted ?? false) {
      navigator!.popUntil((route) => route.isFirst);
    }

    _updateUser(UserModel.empty);
  }

  Future<void> logOutUser({bool userLogout = false}) async {
    try {
      if (userLogout) {
        unawaited(_logout());
        // TODO: Implement server logout
        // await _authenticationService.logoutUser().whenComplete(() async {
        //   unawaited(_logout());
        // });
      } else {
        unawaited(_logout());
      }
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      throw const ServerException(message: "Failed to log out user.");
    }
  }

  Future<void> deleteUser({required String password}) async {
    // TODO: Implement delete user API
    // final NavigatorState? navigator = navigatorKey.currentState;

    try {
      // await _userService.deleteUser(password: password);
      // await getIt<Fresh<AuthTokenModel>>().clearToken();
      // await _secureStorage.deleteSecureStorageData();
      // await getIt<SharedPreferences>().remove('rememberMe');
      //
      // if (navigator?.mounted ?? false) {
      //   navigator!.popUntil((route) => route.isFirst);
      // }
      //
      // _updateUser(UserModel.empty);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw ServerException(originalException: e);
    } catch (e, st) {
      // TODO: Implement Crash reports
      // await FirebaseCrashlytics.instance.recordError(e, st);
      throw const ServerException(message: "messages.userManagementRepository.deleteUserError");
    }
  }

  /// Closes the user stream controller to prevent memory leaks.
  void dispose() => _userController.close();
}
