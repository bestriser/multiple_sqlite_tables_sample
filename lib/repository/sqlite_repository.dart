import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

final sqliteRepositoryProvider = Provider((ref) => SQLiteRepository());

class SQLiteRepository {
  static final SQLiteRepository _instance = SQLiteRepository._internal();
  factory SQLiteRepository() => _instance;
  SQLiteRepository._internal();

  Database? db;

  /// 何度もOpenする事を防ぐために[main.dart]のみで呼び出す
  Future<void> openOrCreate() async {
    final dbPath = await getDatabasesPath();
    db = await openDatabase(
      join(dbPath, 'sample.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE folders(id TEXT PRIMARY KEY, title TEXT, created_at TEXT)');
        await db.execute(
            'CREATE TABLE items(id TEXT, title TEXT, FOREIGN KEY(id) REFERENCES folders(id))');
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getFolders() async {
    if (db == null) return [<String, dynamic>{}];
    return db!.query('folders');
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    if (db == null) return [<String, dynamic>{}];
    return db!.query('items');
  }

  Future<Map<String, dynamic>> insertFolderRaw() async {
    final folder = {
      'id': const Uuid().v4(),
      'title': 'テスト',
      'created_at': DateTime.now().toString(),
    };
    await db?.insert('folders', folder);
    return folder;
  }

  Future<Map<String, dynamic>> insertItemRaw() async {
    final item = {'id': const Uuid().v4(), 'title': 'テスト'};
    await db?.insert('items', item);
    return item;
  }
}
