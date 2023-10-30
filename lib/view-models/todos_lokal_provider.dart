import 'package:flutter/material.dart';
import 'package:mini_project/models/todo-models/todo_lokal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoLokalProvider with ChangeNotifier {
  static TodoLokalProvider? _todoLokalProvider;
  static Database? _database;

  TodoLokalProvider._internal() {
    _todoLokalProvider = this;
  }

  factory TodoLokalProvider() =>
      _todoLokalProvider ?? TodoLokalProvider._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database!;
  }

  String tableName = 'todos';

  Future<Database> _initializeDb() async {
    var db = await openDatabase(
      join(
        await getDatabasesPath(),
        'todos_db.db',
      ),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        deadline TEXT
      )''');
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertTodo(TodoLokal todoLokal) async {
    Database db = await database;
    await db.insert(
      tableName,
      todoLokal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<TodoLokal?> getTodoByTitle(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null; // Tidak ada data dengan judul yang diberikan
    }

    return TodoLokal(
      id: maps[0]['id'],
      title: maps[0]['title'],
      description: maps[0]['description'],
      deadline: DateTime.parse(maps[0]['deadline']),
    );
  }

  Future<void> deleteTodoByIdLokal(String title) async {
    await _database!.delete(
      tableName,
      where: 'title = ?',
      whereArgs: [title],
    );
    notifyListeners();
  }
}
