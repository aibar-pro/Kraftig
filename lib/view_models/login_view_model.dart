
import 'package:flutter/material.dart';
import 'package:kraftig/models/user_credential_model.dart';
import 'package:kraftig/models/user_profile_model.dart';

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
      // final profile = await apiService.fetchUserProfile();
      // homeViewModel.login(result['accessToken']!, UserProfileModel(username: _username));
      homeViewModel.login(UserProfileModel(login: _login, name:'Boba', age: 42));
      notifyListeners();
      return true;
      // if (profile != null) {
      //   homeViewModel.login(result['accessToken']!, profile);
      //   notifyListeners();
      //   return true;
      // } else {
      //   _errorMessage = "Failed to fetch profile after login";
      // }
    } else {
      _errorMessage = "Invalid credentials";
    }
    notifyListeners();
    return false;
  }
}