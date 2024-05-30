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
  bool _isEditing = false;

  ProfileViewModel({required this.apiService, required this.homeViewModel}) {
    _userProfile = homeViewModel.userProfile;
    homeViewModel.addListener(_onHomeViewModelChanged);
    if (_userProfile != null) {
      fetchProfile();
    }
  }

  @override
  void dispose() {
    homeViewModel.removeListener(_onHomeViewModelChanged);
    super.dispose();
  }

  void _onHomeViewModelChanged() {
    _userProfile = homeViewModel.userProfile;
    if (_userProfile != null) {
      fetchProfile();
    }
    notifyListeners();
  }

  UserProfileModel? get userProfile => homeViewModel.userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isEditing => _isEditing;

  void setName(String name) {
    if (_userProfile != null) {
      _userProfile!.username = name;
      notifyListeners();
    }
  }

  void setAge(int age) {
    if (_userProfile != null) {
      _userProfile!.age = age;
      notifyListeners();
    }
  }

  void setHeight(double height) {
    if (_userProfile != null) {
      _userProfile!.height = height;
      notifyListeners();
    }
  }

  void setWeight(double weight) {
    if (_userProfile != null) {
      _userProfile!.weight = weight;
      notifyListeners();
    }
  }

  void toggleEditMode() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();

    final result = await apiService.fetchUserProfile(userProfile!.login);

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
      homeViewModel.setUserProfile(_userProfile!); 
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Failed to update profile";
      notifyListeners();
      return false;
    }
  }
}