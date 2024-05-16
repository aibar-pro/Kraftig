import 'package:flutter/material.dart';

import '../services/api_service.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService apiService;
  LoginViewModel({required this.apiService});


  String _username = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  void setUsermame(String email) {
    _username = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();

    final result = await apiService.login(_username, _password);

    _isLoading = false;
    if (result != null) {
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Invalid credentials";
      notifyListeners();
      return false;
    }
  }
}