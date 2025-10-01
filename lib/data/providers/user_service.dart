import 'dart:io';

import 'package:dio/dio.dart';

// TODO: Implement user specific API
class UserService {
  final Dio _authenticatedDio;

  const UserService({
    required Dio authenticatedDio,
  }) : _authenticatedDio = authenticatedDio;

  Future<Response> getUser() async {
    return _authenticatedDio.get("/api/user");
  }

  Future<Response> updateUser({
    String? email,
    String? fullName,
  }) async {
    return _authenticatedDio.post(
      "/api/user/update",
      data: {
        "email": email,
        "fullname": fullName,
      }..removeWhere((key, value) => value == null),
    );
  }

  Future<Response> updateNotificationSettings({
    required bool isNotificationsEnabled,
  }) async {
    return _authenticatedDio.post(
      "/api/user/notifications/settings",
      data: {"notifications_enabled": isNotificationsEnabled},
    );
  }

  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return _authenticatedDio.post(
      "/api/user/changePassword",
      data: {
        "current_password": currentPassword,
        "new_password": newPassword,
      },
    );
  }

  Future<Response> uploadProfileImage({required File profileImage}) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(profileImage.path),
    });

    return _authenticatedDio.post(
      "/api/profile-picture/upload",
      data: formData,
    );
  }

  Future<Response> removeProfileImage() async {
    return _authenticatedDio.delete("/api/profile-picture/delete");
  }

  Future<Response> deleteUser({required String password}) async {
    return _authenticatedDio.post(
      "/api/user/delete",
      data: {"password": password},
    );
  }

  Future<Response> getPaginatedTransactionHistory() async {
    return _authenticatedDio.get("/api/transaction-history");
  }
}
