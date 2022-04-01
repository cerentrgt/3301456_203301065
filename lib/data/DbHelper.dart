import 'package:memory_notebook/models/MemoryItemModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
   Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initalizeDb();
    }
    return _db!;
  }

  Future<Database> initalizeDb() async {
    String dbPath = join(await getDatabasesPath(), "memory.db");
    var memoryDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return memoryDb;
  }

  void createDb(Database db, int version) async {
    await db.execute("Create table Memories("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "date TEXT,"
        "mostRecentText Text,"
        ")");
  }
  Future<List<MemoryItemModel>> getMemories() async{
    Database db=await this.db;
    var result=await db.query("memories");
    return List.generate(result.length, (i) => MemoryItemModel.fromObject(result[i]));
  }

  Future<int> insert(MemoryItemModel memory) async{
    Database db=await this.db;
    var result=await db.insert("memories", memory.toMap());
    return result;
  }
  Future<int> delete(int id) async{
    Database db=await this.db;
    var result=await db.rawDelete("delete from memories where id= $id");
    return result;
  }

  Future<int> update(MemoryItemModel memory) async{
    Database db=await this.db;
    var result=await db.update("memories", memory.toMap(),where: "id=?",whereArgs: [memory.id]);
    return result;
  }


}
