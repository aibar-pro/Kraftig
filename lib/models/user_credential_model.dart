class UserCredentialModel {
  final String login;
  final String password;

  UserCredentialModel({required this.login, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}