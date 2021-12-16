import 'package:encuestas_system/domain/entities/EncuestaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'encuestas'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE encuestas(id_encuesta TEXT PRIMARY KEY, contenido TEXT)",
      );
    }, version: 1);
  }

  static Future<void> insertEncuesta(Encuesta encuesta, String json) async {
    Database database = await _openDB();
    //return database.insert("encuestas", encuesta.toMap());
    await database.rawInsert("INSERT into encuestas (id_encuesta, contenido)"
        "VALUES (${encuesta.idEncuesta}, $json)");
  }

  static Future<int> delete(Encuesta encuesta) async {
    Database database = await _openDB();
    return database.delete("encuestas",
        where: "id_encuesta = ?", whereArgs: [encuesta.idEncuesta]);
  }

  static Future<int> update(Encuesta encuesta) async {
    Database database = await _openDB();
    return database.update("encuestas", encuesta.toMap(),
        where: "id_encuesta = ?", whereArgs: [encuesta.idEncuesta]);
  }
}
