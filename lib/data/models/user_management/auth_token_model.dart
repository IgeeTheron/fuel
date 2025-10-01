import 'package:equatable/equatable.dart';
import 'package:fuel/core/utils/json_utlis.dart';

// TODO: Implement full Oauth2 token system
class AuthTokenModel extends Equatable {
  final String accessToken;

  // final String refreshToken;
  final String tokenType;

  // final int expiresIn;

  const AuthTokenModel({
    required this.accessToken,
    // required this.refreshToken,
    required this.tokenType,
    // required this.expiresIn,
  });

  static const AuthTokenModel empty = AuthTokenModel(
    tokenType: '',
    // expiresIn: 0,
    accessToken: '',
    // refreshToken: '',
  );

  bool get isEmpty => this == AuthTokenModel.empty;

  bool get isNotEmpty => this != AuthTokenModel.empty;

  // bool get isTokenExpired {
  //   final expirationDateTime = DateTime.fromMillisecondsSinceEpoch(expiresIn);
  //
  //   // Add a small buffer (e.g., 5 minutes) to account for clock skew
  //   final Duration bufferDuration = const Duration(minutes: 5);
  //   final DateTime expirationWithBuffer = expirationDateTime.subtract(bufferDuration);
  //
  //   return DateTime.now().isAfter(expirationWithBuffer);
  // }

  factory AuthTokenModel.fromJson(Map<String, dynamic> json, bool convert) {
    final Map<String, List<Type?>?> expectedTypes = {
      "token": [String],
      // "access_token": [String],
      // "refresh_token": [String],
      // "token_type": [String],
      // "expires_in": [int],
    };

    JsonUtils.assertJsonKeys(json: json, expectedTypes: expectedTypes);

    return AuthTokenModel(
      accessToken: json["token"],
      // accessToken: json["access_token"],
      // refreshToken: json["refresh_token"],
      tokenType: json["token_type"],
      // expiresIn: (convert) ? DateTime.now().millisecondsSinceEpoch + ((json["expires_in"] as int) * 1000) : json["expires_in"],
    );
  }

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        // "expires_in": expiresIn,
        "access_token": accessToken,
        // "refresh_token": refreshToken,
      };

  AuthTokenModel copyWith({
    String? accessToken,
    String? tokenType,
  }) {
    return AuthTokenModel(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  @override
  List<Object> get props => [accessToken, tokenType];

  @override
  String toString() {
    return 'AuthTokenModel{accessToken: $accessToken, tokenType: $tokenType}';
  }
}
