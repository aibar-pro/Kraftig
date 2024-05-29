import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'encryption_helper.dart';

class FileSystemHelper {
  static final FileSystemHelper _instance = FileSystemHelper._internal();
  factory FileSystemHelper() => _instance;

  FileSystemHelper._internal();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    final file = File('$path/photos/$filename');
    await _ensureDirectoryExists(file.parent);
    return file;
  }

  Future<void> _ensureDirectoryExists(Directory directory) async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }

  Future<File> savePhoto(String filename, Uint8List bytes) async {
    final encryptedData = EncryptionHelper.encryptFile(bytes);
    final file = await _localFile(filename);
    return file.writeAsString(encryptedData);
  }

  Future<Uint8List> readPhoto(String filename) async {
    final file = await _localFile(filename);
    final encryptedData = await file.readAsString();
    return EncryptionHelper.decryptFile(encryptedData);
  }

  Future<void> deletePhoto(String filename) async {
    final file = await _localFile(filename);
    if (await file.exists()) {
      await file.delete();
    }
  }
}