class UserProfileModel {
  final String login;
  
  String? username;
  int? age;
  double? height;
  double? weight;

  UserProfileModel({required this.login, this.username, this.age, this.height, this.weight});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      login: json['login'],
      username: json['username'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'username': username,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }
}