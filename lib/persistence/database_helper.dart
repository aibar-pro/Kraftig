import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE PhotoGroup (
        id INTEGER PRIMARY KEY,
        name TEXT,
        date TEXT,
        login TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE Photo (
        id INTEGER PRIMARY KEY,
        path TEXT,
        group_id INTEGER,
        FOREIGN KEY(group_id) REFERENCES PhotoGroup(id)
      )
    ''');
  }

  Future<int> insertPhotoGroup(Map<String, dynamic> row) async {
    Database db = await _instance.database;
    return await db.insert('PhotoGroup', row);
  }

  Future<int> updatePhotoGroup(String groupId, String newName) async {
    Database db = await _instance.database;
    return await db.rawUpdate(
      '''
      UPDATE PhotoGroup 
      SET name = ? 
      WHERE id = ?
      ''', 
      [newName, groupId]
    );
  }

  Future<int> deletePhotoGroup(String groupId) async {
    Database db = await _instance.database;
    return await db.delete('PhotoGroup', where: 'id = ?', whereArgs: [groupId]);
  }

  Future<List<Map<String, dynamic>>> queryAllPhotoGroups(String userLogin) async {
    Database db = await _instance.database;
    return await db.query('PhotoGroup', where: 'login = ?', whereArgs: [userLogin]);
  }

  Future<int> insertPhoto(Map<String, dynamic> row) async {
    Database db = await _instance.database;
    return await db.insert('Photo', row);
  }

  Future<List<Map<String, dynamic>>> queryPhotosByGroupId(int groupId) async {
    Database db = await _instance.database;
    return await db.query('Photo', where: 'group_id = ?', whereArgs: [groupId]);
  }

  Future<int> deletePhoto(String photoPath) async {
    Database db = await _instance.database;
    return await db.delete('Photo', where: 'path = ?', whereArgs: [photoPath]);
  }
}