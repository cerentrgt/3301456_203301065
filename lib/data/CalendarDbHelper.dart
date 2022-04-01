import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Calendar.dart';

class CalendarDbHelper {
  Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initalizeDb();
    }
    return _db!;
  }

  Future<Database> initalizeDb() async {
    String dbPath = join(await getDatabasesPath(), "calendar.db");
    var calendarDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return calendarDb;
  }

  void createDb(Database db, int version) async {
    await db.execute("Create table Calendars("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "date TEXT,"
        "descriptions Text"
        ")");
  }

  Future<List<Calendar>> getCalendars() async {
    Database db = await this.db;
    var result = await db.query("calendars");
    return List.generate(result.length, (i) => Calendar.fromObject(result[i]));
  }

  Future<int> insert(Calendar calendar) async {
    Database db = await this.db;
    var result = await db.insert("calendars", calendar.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from calendars where id= $id");
    return result;
  }

  Future<int> update(Calendar calendar) async {
    Database db = await this.db;
    var result = await db.update("calendars", calendar.toMap(),
        where: "id=?", whereArgs: [calendar.id]);
    return result;
  }
}
