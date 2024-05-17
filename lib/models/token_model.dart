
class TokenModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  TokenModel({required this.accessToken, required this.refreshToken, required this.expiresIn});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
    );
  }
}