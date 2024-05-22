import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/photo_group.dart';
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
  List<PhotoGroup> _photoGroups = [];

  ProfileViewModel({required this.apiService, required this.homeViewModel}) {
     _userProfile = homeViewModel.userProfile;
  }

  UserProfileModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isEditing => _isEditing;
  List<PhotoGroup> get photoGroups => _photoGroups;

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

// TODO: Consider refactoring
    final result = await apiService.fetchUserProfile(homeViewModel.userProfile!.login);

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

  
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _addPhoto(image.path);
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      _addPhoto(image.path);
      notifyListeners();
    }
  }

  void _addPhoto(String path) {
    if (_photoGroups.isEmpty) {
      _photoGroups.add(PhotoGroup(
        name: null,
        date: DateTime.now(),
        photos: [path],
      ));
    } else {
      _photoGroups.first.photos.add(path);
    }
  }

  void removePhoto(String photoPath) {
    for (var group in _photoGroups) {
      group.photos.remove(photoPath);
      if (group.photos.isEmpty) {
        _photoGroups.remove(group);
        break;
      }
    }
    notifyListeners();
  }

  void addPhotoGroup(String name, DateTime date) {
    _photoGroups.add(PhotoGroup(name: name, date: date, photos: []));
    notifyListeners();
  }
}