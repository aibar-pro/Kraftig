import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kraftig/models/auth_token_model.dart';
import 'package:kraftig/models/user_credential_model.dart';
import 'package:kraftig/models/user_profile_model.dart';

class ApiService {
  final String baseUrl;
  String? accessToken;
  int? expiresIn;

  ApiService({required this.baseUrl});

  void setAccessToken(String accessToken) {
    accessToken = accessToken;
  }

  void setExpiresIn(int expiresIn) {
    expiresIn = expiresIn;
  }

  Future<AuthTokenModel?> login(UserCredentialModel userCredentials) async {
    final url = Uri.parse('$baseUrl/auth/login');
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userCredentials.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final token = AuthTokenModel.fromJson(data);
      accessToken = token.accessToken;
      expiresIn = token.expiresIn;
      return token;
    } else {
      return null;
    }
  }

  Future<UserProfileModel?> fetchUserProfile(String login) async {
    if (accessToken == null) return null;

    final url = Uri.parse('$baseUrl/user/profile/$login');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return UserProfileModel.fromJson(data);
    } else {
      return null;
    }
  }

  Future<UserProfileModel?> createUserProfile(UserProfileModel profile) async {
    if (accessToken == null) return null;

    final url = Uri.parse('$baseUrl/user/profile');
    if (kDebugMode) {
      print(jsonEncode(profile.toJson()).toString());
    }
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(profile.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return UserProfileModel.fromJson(data);
    } else {
      return null;
    }
  }

  Future<bool> updateUserProfile(UserProfileModel profile) async {
    if (accessToken == null) return false;

    final url = Uri.parse('$baseUrl/user/profile/${profile.login}');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(profile.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> createUser(UserCredentialModel newUser) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newUser.toJson()),
    );

    return response.statusCode == 201;
  }
}