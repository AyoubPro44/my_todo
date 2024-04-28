// ignore_for_file: unused_field, prefer_const_declarations, avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_todo/models/todo_model.dart';

class SqlDb {
  static Database? _db;

  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();

    final dbname = 'todo.db';

    final path = join(dbpath, dbname);

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);

    return _database!;
  }

  // Future<Database?> get database async {
  //   if (_db == null) {
  //     _db = await initialDb();
  //     return _db;
  //   } else {
  //     return _db;
  //   }
  // }

  // initialDb() async {
  //   String databasePath = await getDatabasesPath();
  //   String path = join(databasePath, 'todo.db');
  //   Database myDb = await openDatabase(path, version: 1, onCreate: _onCreate);
  //   return myDb;
  // }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      createdTime TEXT,
      isChecked INTEGER
    )
    ''');

    print("onCreate ======================================");
  }

  Future<List<Todo>> getData() async {
    final db = await database;

    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );

    return List.generate(
      items.length,
      (i) => Todo(
        id: items[i]['id'],
        description: items[i]['description'],
        title: items[i]['title'],
        createdTime: DateTime.parse(items[i]['createdTime']),
        isChecked: items[i]['isChecked'] == 1 ? true : false,
      ),
    );
  }

  Future<void> insertData(Todo todo) async {
    final db = await database;
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteData(Todo todo) async {
    final db = await database;
    await db.delete(
      'todo',
      where: 'id == ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> updateData(Todo todo) async {
    final db = await database;
    await db.update(
      'todo',
      todo.toMap(),
      where: 'id == ?',
      whereArgs: [todo.id],
    );
  }

  // updateData(String sql) async {
  //   Database? db = await database;
  //   int response = await db.rawUpdate(sql);
  //   return response;
  // }

  myDeleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    await deleteDatabase(path);

    print("delete Database ====================================");
  }
}
