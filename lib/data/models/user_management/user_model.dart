import 'package:equatable/equatable.dart';
import 'package:fuel/core/utils/json_utlis.dart';

// TODO: Implement user data
class UserModel extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String? profileImageUrl;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.profileImageUrl,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  static const UserModel empty = UserModel(
    id: -1,
    fullName: "unknown",
    email: "unknown",
  );

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<Type?>?> expectedTypes = {
      "id": [int],
      "fullname": [String],
      "email": [String],
      "profile_image_url": [null, String],
      "email_verified_at": [null, String],
      "created_at": [null, String],
      "updated_at": [null, String],
    };

    JsonUtils.assertJsonKeys(json: json, expectedTypes: expectedTypes);

    return UserModel(
      id: json["id"],
      fullName: json["fullname"],
      email: json["email"],
      profileImageUrl: json["profile_image_url"],
      emailVerifiedAt: (json["email_verified_at"] == null) ? null : DateTime.parse(json["email_verified_at"]),
      createdAt: (json["created_at"] == null) ? null : DateTime.parse(json["created_at"]),
      updatedAt: (json["updated_at"] == null) ? null : DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullName,
        "email": email,
        "profile_image_url": profileImageUrl,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  UserModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? profileImageUrl,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        profileImageUrl,
        emailVerifiedAt,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'UserModel{id: $id, fullName: $fullName, email: $email, profileImageUrl: $profileImageUrl, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
