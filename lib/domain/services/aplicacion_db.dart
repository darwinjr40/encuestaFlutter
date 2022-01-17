import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/entities/EncuestaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AplicacionDB {
  static Future<Database> _openDB() async {
    print('+++++++CREANDO LA BASE DE DATOS+++++++');
    return openDatabase(join(await getDatabasesPath(), 'encuestas'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE aplicaciones(id INTEGER PRIMARY KEY, contenido TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insertAplicacion(
      AplicacionEncuesta aplicacion, String json) async {
    Database database = await _openDB();
    return database.insert("aplicaciones", aplicacion.toMap());
    //await database.rawInsert("INSERT into aplicaciones (id_encuesta, contenido)"
    //    "VALUES (${aplicacion.idEncuesta}, $json)");
  }

  /* static Future<int> delete(AplicacionEncuesta aplicacion) async {
    Database database = await _openDB();
    return database.delete("encuestas",
        where: "id_encuesta = ?", whereArgs: [aplicacion.idAplicacion]);
  } */

  static Future<int> update(Encuesta encuesta) async {
    Database database = await _openDB();
    return database.update("encuestas", encuesta.toMap(),
        where: "id_encuesta = ?", whereArgs: [encuesta.idEncuesta]);
  }
}
