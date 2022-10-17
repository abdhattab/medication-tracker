import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  late Database _database;
  static DbController? _instance;

  DbController._();

  Database get database => _database;

  factory DbController() {
    return _instance ??= DbController._();
  }

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db_app.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE medication('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'description TEXT NOT NULL,'
            'year INTEGER,'
            'month INTEGER,'
            'day INTEGER,'
            'hour INTEGER,'
            'minute INTEGER'
            ')');
      },
      onOpen: (Database db) {},
      onUpgrade: (Database db, int oldversion, int newversion) {},
      onDowngrade: (Database db, int oldversion, int newversion) {},
    );
  }
}
