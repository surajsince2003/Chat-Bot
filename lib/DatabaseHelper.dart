import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'login_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, gender TEXT, dob TEXT, avatar TEXT)",
        );
      },
      version: 2,
    );
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final Database db = await database;
    await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final Database db = await database;
    return db.query('users');
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    await db.delete('users'); // assuming your table is named 'users'
  }

  Future<void> updateUser(Map<String, dynamic> newUser) async {
    final Database db = await database;
    await db.update(
      'users',
      newUser,
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
