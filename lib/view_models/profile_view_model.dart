import 'package:flutter/material.dart';

import '../models/user_profile_model.dart';
import '../services/api_service.dart';
import 'home_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final ApiService apiService;
  final HomeViewModel homeViewModel;

  UserProfileModel? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileViewModel({required this.apiService, required this.homeViewModel}) {
     _userProfile = homeViewModel.userProfile;
  }

  UserProfileModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setName(String name) {
    if (_userProfile != null) {
      _userProfile!.name = name;
      notifyListeners();
    }
  }

  void setAge(int age) {
    if (_userProfile != null) {
      _userProfile!.age = age;
      notifyListeners();
    }
  }

  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();

    final result = await apiService.fetchUserProfile();

    _isLoading = false;
    if (result != null) {
      _userProfile = result;
      _errorMessage = null;
    } else {
      _errorMessage = "Failed to fetch profile";
    }
    notifyListeners();
  }

  Future<bool> updateProfile() async {
    if (_userProfile == null) return false;

    _isLoading = true;
    notifyListeners();

    final result = await apiService.updateUserProfile(_userProfile!);

    _isLoading = false;
    if (result) {
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Failed to update profile";
      notifyListeners();
      return false;
    }
  }
}