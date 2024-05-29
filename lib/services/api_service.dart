import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/auth_token_model.dart';
import '../models/user_credential_model.dart';
import '../models/user_profile_model.dart';
import '../persistence/secure_storage_helper.dart';

class ApiService {
  final String baseUrl;
  String? accessToken;
  int? expiresIn;

  ApiService({required this.baseUrl});

  void setAccessToken(String token, int expiresIn) {
    accessToken = token;
    this.expiresIn = expiresIn;
  }

  void logout() async {
    accessToken = null;
    expiresIn = null;
    await SecureStorageHelper.deleteRefreshToken();
  }

  Future<void> saveToken(AuthTokenModel token) async {
    setAccessToken(token.accessToken, token.expiresIn);
    if (kDebugMode) {
      print("Access token expires in: ${DateTime.fromMillisecondsSinceEpoch(expiresIn!)}");
    }
    await SecureStorageHelper.saveRefreshToken(token.refreshToken);
  }

  bool validateAccessToken () {
    if (accessToken == null || expiresIn == null) return false;
    return DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(expiresIn!));
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
      await saveToken(token);
      return token;
    } else {
      return null;
    }
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = await SecureStorageHelper.getRefreshToken();
    if (refreshToken != null) {
      final newToken = await fetchRefreshToken(refreshToken);
      if (newToken != null) {
        await saveToken(newToken);
      } else {
        logout();
      }
    }
  }

  Future<AuthTokenModel?> fetchRefreshToken(String refreshToken) async {
    final url = Uri.parse('$baseUrl/auth/refresh-token');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final token = AuthTokenModel.fromJson(data);
      await saveToken(token);
      return token;
    } else {
      return null;
    }
  }

    Future<T?> _performRequest<T>(Future<http.Response> Function() requestFunction, T Function(Map<String, dynamic>) fromJson) async {
    if (!validateAccessToken()) {
      await refreshAccessToken();
    }
    
    final response = await requestFunction();
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<UserProfileModel?> fetchUserProfile(String login) async {
    return _performRequest(
      () => http.get(
        Uri.parse('$baseUrl/user/profile/$login'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      (data) => UserProfileModel.fromJson(data),
    );
  }

  Future<UserProfileModel?> createUserProfile(UserProfileModel profile) async {
    return _performRequest(
      () => http.post(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(profile.toJson()),
      ),
      (data) => UserProfileModel.fromJson(data),
    );
  }

  Future<bool> updateUserProfile(UserProfileModel profile) async {
    final response = await _performRequest(
      () => http.put(
        Uri.parse('$baseUrl/user/profile/${profile.login}'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      ),
      (data) => true,
    );
    return response ?? false;
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