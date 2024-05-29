
import 'package:flutter/material.dart';

import '../models/user_credential_model.dart';
import '../models/user_profile_model.dart';
import '../services/api_service.dart';
import 'home_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService apiService;
  final HomeViewModel homeViewModel;

  String _login = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;
  
  LoginViewModel({required this.apiService, required this.homeViewModel});

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLogin(String login) {
    _login = login;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();
    final userCredentials = UserCredentialModel(login: _login, password: _password);
    final result = await apiService.login(userCredentials);

    _isLoading = false;
    if (result != null) {
      _errorMessage = null;
      final profile = await apiService.fetchUserProfile(_login);
      if (profile != null) {
        homeViewModel.login(profile);
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Failed to fetch profile after login";
        // Temporary implementation: Create blank user profile
        final newProfile = await apiService.createUserProfile(UserProfileModel(login: userCredentials.login));
        if (newProfile != null) {
          homeViewModel.login(newProfile);
          notifyListeners();
          return true;
        } else {
          _errorMessage = "Failed to create default profile after login";
        }
      }
    } else {
      _errorMessage = "Invalid credentials";
    }
    notifyListeners();
    return false;
  }
}