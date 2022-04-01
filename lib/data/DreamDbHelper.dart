
import 'package:memory_notebook/models/DreamModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DreamDbHelper {
  Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initalizeDb();
    }
    return _db!;
  }

  Future<Database> initalizeDb() async {
    String dbPath = join(await getDatabasesPath(), "dream.db");
    var dreamDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return dreamDb;
  }

  void createDb(Database db, int version) async {
    await db.execute("Create table Dreams("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "descriptions TEXT"
        ")");
  }
  Future<List<DreamModel>> getDreams() async{
    Database db=await this.db;
    var result=await db.query("dreams");
    return List.generate(result.length, (i) => DreamModel.fromObject(result[i]));
  }

  Future<int> insert(DreamModel dream) async{
    Database db=await this.db;
    var result=await db.insert("dreams", dream.toMap());
    return result;
  }
  Future<int> delete(int id) async{
    Database db=await this.db;
    var result=await db.rawDelete("delete from dreams where id= $id");
    return result;
  }

  Future<int> update(DreamModel dream) async{
    Database db=await this.db;
    var result=await db.update("dreams", dream.toMap(),where: "id=?",whereArgs: [dream.id]);
    return result;
  }


}
