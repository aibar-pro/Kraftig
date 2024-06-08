import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static const _refreshTokenKey = 'refreshToken';
  static const _userLogin = 'login';

  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  static Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  static Future<void> saveUserLogin(String login) async {
    await _storage.write(key: _userLogin, value: login);
  }

  static Future<String?> getUserLogin() async {
    return await _storage.read(key: _userLogin);
  }

  static Future<void> deleteUserLogin() async {
    await _storage.delete(key: _userLogin);
  }
}