class UserProfileModel {
  final String login;
  
  String? name;
  int? age;

  UserProfileModel({required this.login, this.name, this.age});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      login: json['login'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'name': name,
      'age': age,
    };
  }
}