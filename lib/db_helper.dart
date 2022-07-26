import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> openOrCreate() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'hogehoge.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE folders(id TEXT PRIMARY KEY, title TEXT, created_at TEXT)');
        await db.execute(
            'CREATE TABLE items(id TEXT, title TEXT, FOREIGN KEY(id) REFERENCES folders(id))');
      },
      version: 1,
    );
  }
}
