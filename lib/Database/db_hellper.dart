import 'package:flutter_to_do_app/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHellper {
  static Database? _db;

  static final int _version = 1;
  static final String _tableName = "task";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'tasks.db';

      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("Creating a new one");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT ,"
          "title STRING , "
          " notes TEXT , dateTime STRING , startTime STRING, endTime STRING , remind INTEGER , repeating STRING , setColor INTEGER ,  isComplete INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  // Insert Data Into Database
  static Future<int> insert(TaskModel? tasks) async {
    print("Inserted");

    return await _db?.insert(_tableName, tasks!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query function in DBHellper");
    print("Data Are $query");
    return await _db!.query(_tableName);
  }

  static Delete(TaskModel task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  // Task isComplete
  static Update(int id) async {
    return await _db!.rawUpdate('''
     UPDATE $_tableName
     SET isComplete = ?
     WHERE id=?
    ''', [1, id]);
  }
}
