import 'package:sqflite/sqflite.dart';
import "dart:io" as io;
import 'package:path/path.dart';
import 'package:todo_app/models/TaskModel.dart';

class DBHelper {
  static Database _db;
  static const String ID = "id";
  static const String DUE_TO_DAY = "dueToDay";
  static const String DESCRIPTION = "description";
  static const String TITLE = "title";
  static const String TABLE = "tasks";
  static const String DB_NAME = "todo.db";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    return openDatabase(join(await getDatabasesPath(), DB_NAME),
        onCreate: (db, version) async {
      return await db.execute(
          "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $DUE_TO_DAY TEXT, $DESCRIPTION TEXT, $TITLE TEXT)");
    }, version: 1);
  }

  Future<void> insertTask(Task task) async {
    var dbClient = await db;
    await dbClient.insert(TABLE, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(TABLE);
    return List.generate(
        maps.length,
        (index) => Task(
            id: maps[index][ID],
            dueToDay: maps[index][DUE_TO_DAY],
            description: maps[index][DESCRIPTION],
            title: maps[index][TITLE]));
  }
}
