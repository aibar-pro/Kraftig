
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SignupViewModel extends ChangeNotifier {
  final ApiService apiService;

  SignupViewModel({required this.apiService});

  String _username = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  String get username => _username;
  String get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<bool> signup() async {
    _isLoading = true;
    notifyListeners();

    final result = await apiService.createUser(_username, _password);

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