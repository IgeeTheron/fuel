import 'package:equatable/equatable.dart';
import 'package:fuel/core/utils/json_utlis.dart';

// TODO: Implement full Oauth2 token system
class AuthTokenModel extends Equatable {
  // final String accessToken;
  final String token;

  // final String refreshToken;
  final String tokenType;

  // final int expiresIn;

  const AuthTokenModel({
    required this.token,
    // required this.refreshToken,
    required this.tokenType,
    // required this.expiresIn,
  });

  static const AuthTokenModel empty = AuthTokenModel(
    tokenType: '',
    // expiresIn: 0,
    token: '',
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
      token: json["token"],
      // accessToken: json["access_token"],
      // refreshToken: json["refresh_token"],
      tokenType: /*json["token_type"]*/ "Bearer",
      // expiresIn: (convert) ? DateTime.now().millisecondsSinceEpoch + ((json["expires_in"] as int) * 1000) : json["expires_in"],
    );
  }

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        // "expires_in": expiresIn,
        "token": token,
        // "refresh_token": refreshToken,
      };

  AuthTokenModel copyWith({
    String? token,
    String? tokenType,
  }) {
    return AuthTokenModel(
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  @override
  List<Object> get props => [token, tokenType];

  @override
  String toString() {
    return 'AuthTokenModel{token: $token, tokenType: $tokenType}';
  }
}
