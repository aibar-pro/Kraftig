
import 'package:flutter/material.dart';

import '../models/user_credential_model.dart';
import '../services/api_service.dart';

class SignupViewModel extends ChangeNotifier {
  final ApiService apiService;

  SignupViewModel({required this.apiService});

  String _login = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  String get login => _login;
  String get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setUsername(String username) {
    _login = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<bool> signup() async {
    _isLoading = true;
    notifyListeners();

    final newUser = UserCredentialModel(login: _login, password: _password);
    final result = await apiService.createUser(newUser);

    _isLoading = false;
    if (result) {
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Username already exists or other error";
      notifyListeners();
      return false;
    }
  }
}