import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:fuel/core/api/error_interceptor.dart';
import 'package:fuel/core/api/token_storage_service.dart';
import 'package:fuel/core/cache/cache.dart';
import 'package:fuel/core/constants/enums/app_environment.dart';
import 'package:fuel/core/utils/toast_service.dart';
import 'package:fuel/data/models/user_management/auth_token_model.dart';
import 'package:fuel/data/providers/authentication_service.dart';
import 'package:fuel/data/providers/user_service.dart';
import 'package:fuel/data/repositories/user_management_repository.dart';
import 'package:fuel/data/secure_storage/secure_storage.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies({required AppEnvironment environment}) async {
  await _registerAsyncSingletons(environment: environment);
  _registerNetworkClients();
  _registerApiServices();
  _registerRepositories();
  _registerUtilities();
}

Future<void> _registerAsyncSingletons({required AppEnvironment environment}) async {
  getIt.registerSingletonAsync<SharedPreferences>(() async => SharedPreferences.getInstance());
}

void _registerNetworkClients() {
  // TODO: Oauth2 implementation
  final String baseUrl = dotenv.get('base_url');
  // final String clientId = dotenv.get('client_id');
  // final String clientSecret = dotenv.get('client_secret');

  final BaseOptions baseOptions = BaseOptions(
    baseUrl: "http://$baseUrl",
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 15),
    headers: {'Accept': 'application/json'},
  );

  // region INTERCEPTORS
  getIt.registerLazySingleton<PrettyDioLogger>(
    () => PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ),
  );

  getIt.registerLazySingleton<Fresh<AuthTokenModel>>(
    () {
      return Fresh<AuthTokenModel>(
        tokenStorage: getIt<TokenStorage<AuthTokenModel>>(),
        refreshToken: (token, httpClient) async {
          // TODO: Implement refresh token logic
          // final Response response = await httpClient.post(
          //   "/oauth/token",
          //   data: {
          //     "grant_type": "refresh_token",
          //     "client_id": clientId,
          //     "client_secret": clientSecret,
          //     "refresh_token": token?.refreshToken,
          //   },
          // );
          //
          // return AuthTokenModel.fromJson(response.data, true);
          return AuthTokenModel.empty;
        },
        tokenHeader: (token) {
          return {"Authorization": "${token.tokenType} ${token.token}"};
        },
      );
    },
  );

  getIt.registerFactoryParam<RetryInterceptor, Dio, void>(
    (dioInstance, _) => RetryInterceptor(
      dio: dioInstance,
      logPrint: (kDebugMode) ? PrintColor.red : null,
      retries: 3,
      retryDelays: const [
        Duration(seconds: 2),
        Duration(seconds: 4),
        Duration(seconds: 8),
      ],
      retryEvaluator: (error, attempt) {
        if (error.type == DioExceptionType.connectionError) {
          return false;
        }

        return DefaultRetryEvaluator(defaultRetryableStatuses).evaluate(error, attempt);
      },
    ),
  );

  getIt.registerLazySingleton<ErrorInterceptor>(() => ErrorInterceptor(getIt));
  // endregion

  // region DIO CLIENTS

  // Public Dio Client (for routes like login, register)
  getIt.registerLazySingleton<Dio>(
    () {
      final Dio dio = Dio(baseOptions);

      dio.interceptors.addAll([
        // 1. General Error Handling: Catches errors that bubble up from the retry interceptor.
        getIt<ErrorInterceptor>(),

        // 2. Retrying: Sits closer to the network to handle transient failures first.
        getIt<RetryInterceptor>(param1: dio),

        // 3. Logging: Always last to see the final state of the request and response.
        getIt<PrettyDioLogger>(),
      ]);

      return dio;
    },
    instanceName: 'publicDio',
  );

  // Authenticated Dio Client (for protected routes)
  getIt.registerLazySingleton<Dio>(
    () {
      final Dio dio = Dio(baseOptions);

      dio.interceptors.addAll([
        // 1. Error Handling: A general handler for errors that aren't resolved by Fresh or Retry.
        getIt<ErrorInterceptor>(),

        // 2. Authentication: Adds the token and handles 401 errors for token refresh.
        getIt<Fresh<AuthTokenModel>>(),

        // 3. Retrying: Sits closest to the network to handle transient network failures.
        getIt<RetryInterceptor>(param1: dio),

        // 4. Logging: Should be last to log the final request and the final response/error.
        getIt<PrettyDioLogger>(),
      ]);

      return dio;
    },
    instanceName: 'authenticatedDio',
  );
  //endregion
}

void _registerApiServices() {
  getIt.registerLazySingleton<AuthenticationService>(
    () => AuthenticationService(
      publicDio: getIt<Dio>(instanceName: 'publicDio'),
      authenticatedDio: getIt<Dio>(instanceName: 'authenticatedDio'),
    ),
  );

  getIt.registerLazySingleton<UserService>(
    () => UserService(authenticatedDio: getIt<Dio>(instanceName: 'authenticatedDio')),
  );
}

void _registerRepositories() {
  getIt.registerLazySingleton<UserManagementRepository>(
    () => UserManagementRepository(
      authenticationService: getIt<AuthenticationService>(),
      userService: getIt<UserService>(),
      cacheClient: getIt<CacheClient>(),
      secureStorage: getIt<SecureStorage>(),
    ),
  );
}

void _registerUtilities() {
  getIt.registerLazySingleton<CacheClient>(() => CacheClient());
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage.instance);
  getIt.registerLazySingleton<TokenStorage<AuthTokenModel>>(() => const TokenStorageService());
  getIt.registerLazySingleton<ToastService>(() => ToastService());
}
