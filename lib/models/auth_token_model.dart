
class AuthTokenModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  AuthTokenModel({required this.accessToken, required this.refreshToken, required this.expiresIn});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
    );
  }
}