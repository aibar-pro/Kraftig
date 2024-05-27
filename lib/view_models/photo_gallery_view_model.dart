
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/photo_group.dart';

class PhotoGalleryViewModel extends ChangeNotifier {
  List<PhotoGroup> _photoGroups = [];
  bool _isEditing = false;

  List<PhotoGroup> get photoGroups => _photoGroups;
  bool get isEditing => _isEditing;

  void toggleEditMode() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> pickImage(String? groupId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (_photoGroups.isEmpty) {
        createGroup(null, DateTime.now());
      }
      if (groupId != null ) {
        addPhoto(image.path, groupId);
      } else {
        addPhoto(image.path, _photoGroups.first.date.toString());
      }
      notifyListeners();
    }
  }

  Future<void> takePhoto(String? groupId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      if (_photoGroups.isEmpty) {
        createGroup(null, DateTime.now());
      }
      if (groupId != null ) {
        addPhoto(image.path, groupId);
      } else {
        addPhoto(image.path, _photoGroups.first.date.toString());
      }
      notifyListeners();
    }
  }

  void addPhoto(String path, String groupId) {
    final group = _photoGroups.firstWhere((group) => group.date.toString() == groupId);
    group.photos.add(path);
    notifyListeners();
  }

  void movePhoto(String photoPath, String fromGroupId, String toGroupId) {
    final fromGroup = _photoGroups.firstWhere((group) => group.date.toString() == fromGroupId);
    final toGroup = _photoGroups.firstWhere((group) => group.date.toString() == toGroupId);
    fromGroup.photos.remove(photoPath);
    toGroup.photos.add(photoPath);
    notifyListeners();
  }

  void createGroup(String? name, DateTime date) {
    _photoGroups.add(PhotoGroup(name: name, date: date, photos: []));
    notifyListeners();
  }

  void renameGroup(String groupId, String newName) {
    final group = _photoGroups.firstWhere((group) => group.date.toString() == groupId);
    group.name = newName;
    notifyListeners();
  }

  void deleteGroup(String groupId) {
    _photoGroups.removeWhere((group) => group.date.toString() == groupId);
    if (_photoGroups.isEmpty) toggleEditMode();
    notifyListeners();
  }

  void deletePhoto(String photoPath, String groupId) {
    final group = _photoGroups.firstWhere((group) => group.date.toString() == groupId);
    group.photos.remove(photoPath);
    notifyListeners();
  }
}
