import 'package:flutter/foundation.dart';

import '../models/user_profile_model.dart';
import '../persistence/secure_storage_helper.dart';
import '../services/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService apiService;
  
  UserProfileModel? _userProfile;
  bool _isLoggedIn = false;

  HomeViewModel({required this.apiService}) {
    _initialize();
  }

  bool get isLoggedIn => _isLoggedIn;
  UserProfileModel? get userProfile => _userProfile;

  Future<void> _initialize() async {
    final refreshToken = await SecureStorageHelper.getRefreshToken();
    final userlogin = await SecureStorageHelper.getUserLogin();

    if (userlogin != null && refreshToken != null) {
      bool success = await _refreshAccessToken(refreshToken);
      if (!success) {
        logout();
      } else {
        await _fetchUserProfile(userlogin);
      }
    }
  }

  Future<bool> _refreshAccessToken(String refreshToken) async {
    final response = await apiService.fetchRefreshToken(refreshToken);
    if (response != null) {
      await SecureStorageHelper.saveRefreshToken(response.refreshToken);
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> _fetchUserProfile(String userLogin) async {
    final profile = await apiService.fetchUserProfile(userLogin);
    if (profile != null) {
      _userProfile = profile;
      notifyListeners();
    } else {
      logout();
    }
  }

  void setUserProfile(UserProfileModel userProfile) {
      _userProfile = userProfile;
      notifyListeners();
  }

  Future<void> login(UserProfileModel userProfile) async {
    _userProfile = userProfile;
    _isLoggedIn = true;
    await SecureStorageHelper.saveUserLogin(userProfile.login);
    notifyListeners();
    if (kDebugMode) {
      print('Login success $_isLoggedIn');
    }
  }

  Future<void> logout() async {
    apiService.logout();
    _userProfile = null;
    _isLoggedIn = false;
    await SecureStorageHelper.deleteUserLogin();
    notifyListeners();
    if (kDebugMode) {
      print('Logout success $_isLoggedIn');
    }
  }
}