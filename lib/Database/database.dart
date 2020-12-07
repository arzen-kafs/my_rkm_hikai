import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final chapterTABLE = 'chapter';
final lectureTABLE = 'lecture';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "rkmhikai.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $chapterTABLE ("
        "chapterNo VARCHAR(255) PRIMARY KEY, "
        "title TEXT, "
        "ebook TEXT, "
        "items INTEGER "
        ")");

    await database.execute("CREATE TABLE $lectureTABLE ("
        "id INTEGER PRIMARY KEY, "
        "lectureId TEXT, "
        "content TEXT, "
        "title TEXT, "
        "file TEXT, "
        "description TEXT, "
        "chapterNo VARCHAR(255) "
        ")");
  }
}
