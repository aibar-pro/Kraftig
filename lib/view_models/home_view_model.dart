import 'package:flutter/foundation.dart';

import '../models/user_profile_model.dart';
import '../services/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService apiService;
  
  UserProfileModel? _userProfile;
  bool _isLoggedIn = false;

  HomeViewModel({required this.apiService});

  bool get isLoggedIn => _isLoggedIn;
  UserProfileModel? get userProfile => _userProfile;

  void login(UserProfileModel userProfile) {
    _userProfile = userProfile;
    _isLoggedIn = true;
    notifyListeners();
    if (kDebugMode) {
      print('Login successful $_isLoggedIn');
    }
  }

  void logout() {
    apiService.setAccessToken('');
    _userProfile = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}