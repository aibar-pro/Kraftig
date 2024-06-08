import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../view_models/profile_view_model.dart';
import '../models/photo_group.dart';
import '../persistence/database_helper.dart';
import '../persistence/file_system_helper.dart';

class PhotoGalleryViewModel extends ChangeNotifier {
  final ProfileViewModel profileViewModel;
  List<PhotoGroup> _photoGroups = [];
  bool _isEditing = false;

  PhotoGalleryViewModel({required this.profileViewModel}) {
    profileViewModel.addListener(_onProfileViewModelChanged);
     if (profileViewModel.userProfile != null) {
      loadPhotoGroups(profileViewModel.userProfile!.login);
    }
  }

  @override
  void dispose() {
    profileViewModel.removeListener(_onProfileViewModelChanged);
    super.dispose();
  }

  void _onProfileViewModelChanged() {
    final login = profileViewModel.userProfile?.login;
    if (login != null) {
      loadPhotoGroups(userLogin);
    } else {
      _photoGroups = [];
      notifyListeners();
    }
  }

  List<PhotoGroup> get photoGroups => _photoGroups;
  bool get isEditing => _isEditing;

  String get userLogin => profileViewModel.userProfile?.login ?? '';

  void toggleEditMode() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> loadPhotoGroups(String userLogin) async {
    final db = DatabaseHelper();
    final groups = await db.queryAllPhotoGroups(userLogin);
    _photoGroups = groups.map((g) => PhotoGroup(
      id: g['id'],
      name: g['name'],
      date: DateTime.parse(g['date']),
      photos: [],
    )).toList();
    for (var group in _photoGroups) {
      final photos = await db.queryPhotosByGroupId(group.id);
      group.photos = photos.map((p) => p['path'].toString()).toList();
    }
    notifyListeners();
  }

  Future<void> pickImage(String? groupId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (_photoGroups.isEmpty) {
        await createGroup(null, DateTime.now(), userLogin);
      }
      final filename = image.name;
      final bytes = await image.readAsBytes();
      if (groupId != null ) {
        addPhoto(groupId, filename, bytes);
      } else {
        addPhoto(_photoGroups.first.id.toString(), filename, bytes);
      }
      notifyListeners();
    }
  }

  Future<void> takePhoto(String? groupId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      if (_photoGroups.isEmpty) {
        await createGroup(null, DateTime.now(), userLogin);
      }
      final filename = image.name;
      final bytes = await image.readAsBytes();
      if (groupId != null ) {
        addPhoto(groupId, filename, bytes);
      } else {
        addPhoto(_photoGroups.first.id.toString(), filename, bytes);
      }
      notifyListeners();
    }
  }

  void addPhoto(String groupId, String filename, Uint8List bytes) async {
    final fs = FileSystemHelper();
    await fs.savePhoto(filename, bytes);
    final db = DatabaseHelper();
    await db.insertPhoto({
      'path': filename,
      'group_id': int.parse(groupId),
    });
    final group = _photoGroups.firstWhere((g) => g.id.toString() == groupId);
    group.photos.add(filename);
    notifyListeners();
  }

  void movePhoto(String photoPath, String fromGroupId, String toGroupId) {
    final fromGroup = _photoGroups.firstWhere((group) => group.date.toString() == fromGroupId);
    final toGroup = _photoGroups.firstWhere((group) => group.date.toString() == toGroupId);
    fromGroup.photos.remove(photoPath);
    toGroup.photos.add(photoPath);
    notifyListeners();
  }

  Future<void> createGroup(String? name, DateTime date, String userLogin) async {
    final db = DatabaseHelper();
    final groupId = await db.insertPhotoGroup({
      'name': name,
      'date': date.toIso8601String(),
      'login': userLogin,
    });
    _photoGroups.add(PhotoGroup(
      id: groupId,
      name: name,
      date: date,
      photos: [],
    ));
    notifyListeners();
  }

  void renameGroup(String groupId, String newName) async {
    final db = DatabaseHelper();
    await db.updatePhotoGroup(groupId, newName);
    final group = _photoGroups.firstWhere((g) => g.id.toString() == groupId);
    group.name = newName;
    notifyListeners();
  }

  void deleteGroup(String groupId) async {
    final db = DatabaseHelper();
    await db.deletePhotoGroup(groupId);
    _photoGroups.removeWhere((g) => g.id.toString() == groupId);
    if (_photoGroups.isEmpty) toggleEditMode();
    notifyListeners();
  }

  void deletePhoto(String photoPath, String groupId) async {
    final fs = FileSystemHelper();
    await fs.deletePhoto(photoPath);
    final db = DatabaseHelper();
    await db.deletePhoto(photoPath);
    final group = _photoGroups.firstWhere((g) => g.id.toString() == groupId);
    group.photos.remove(photoPath);
    notifyListeners();
  }

  Future<Uint8List> getDecryptedPhoto(String filename) async {
    final fs = FileSystemHelper();
    return await fs.readPhoto(filename);
  }
}
