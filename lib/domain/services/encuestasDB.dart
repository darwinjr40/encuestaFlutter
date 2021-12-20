import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/entities/sqlite/AplicacionSqlite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:encuestas_system/domain/entities/EncuestaModel.dart';
import 'package:encuestas_system/domain/entities/sqlite/EncuestaSqlite.dart';
import 'package:path/path.dart';

class EncuestaDB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'encuestas.db'),
        onCreate: (db, version) {
      return db.execute(
        "create table encuestas (id_encuesta TEXT, content TEXT); create table aplicaciones (id TEXT, content TEXT, onServer INTEGER)",
      );
    }, version: 1);
  }

  static Future<int> insertEncuesta(Encuesta encuesta) async {
    Database database = await _openDB();
    EncuestaSqlite encuestaSqlite = new EncuestaSqlite(
        idEncuesta: encuesta.idEncuesta, content: encuesta.toJson());
    //print('se pudo');
    return database.insert("encuestas", encuestaSqlite.toMap());
  }

  static Future<int> delete(Encuesta encuesta) async {
    Database database = await _openDB();
    return database.delete("encuestas",
        where: "id_encuesta = ?", whereArgs: [encuesta.idEncuesta]);
  }

  static Future<void> deleteEncuestas() async {
    Database database = await _openDB();
    return database.execute('drop table IF EXISTS encuestas');
  }

  static Future<void> deleteAplicaciones() async {
    Database database = await _openDB();
    return database.execute('drop table IF EXISTS aplicaciones');
  }

  static Future<void> createTableEncuestas() async {
    Database database = await _openDB();
    return database
        .execute("create table encuestas (id_encuesta TEXT, content TEXT); ");
  }

  static Future<void> createTableAplicaciones() async {
    Database database = await _openDB();
    return database.execute(
        "create table aplicaciones (id TEXT , content TEXT, onServer INTEGER)");
  }

  /* static Future<int> update(Encuesta encuesta) async {
    Database database = await _openDB();
    return database.update("encuestas", encuesta.toMap(),
        where: "id_encuesta = ?", whereArgs: [encuesta.idEncuesta]);
  } */

  static Future<List<EncuestaSqlite>> getEncuestas() async {
    Database database = await _openDB();
    final List<Map<dynamic, dynamic>> encuestasMap =
        await database.query("encuestas");
    return List.generate(
      encuestasMap.length,
      (i) => EncuestaSqlite(
          //id: encuestasMap[i]['id'],
          idEncuesta: encuestasMap[i]['id_encuesta'],
          content: encuestasMap[i]['content']),
    );
  }

  static Future<List<AplicacionSqlite>> getAplicaciones() async {
    Database database = await _openDB();
    final List<Map<dynamic, dynamic>> aplicacionesMap =
        await database.query("aplicaciones");
    return List.generate(
      aplicacionesMap.length,
      (i) => AplicacionSqlite(
          id: aplicacionesMap[i]['id'], //aplicacionesMap[i]['id'],
          content: aplicacionesMap[i]['content'],
          onServer: aplicacionesMap[i]['onServer']),
    );
  }

  static Future<List<AplicacionSqlite>> getAplicacionesNoSubidas() async {
    Database database = await _openDB();
    final List<Map<dynamic, dynamic>> aplicacionesMap =
        await database.query("aplicaciones", where: "aplicaciones.onServer = ?", whereArgs: [0]);
    return List.generate(
      aplicacionesMap.length,
      (i) => AplicacionSqlite(
          id: aplicacionesMap[i]['id'], //aplicacionesMap[i]['id'],
          content: aplicacionesMap[i]['content'],
          onServer: aplicacionesMap[i]['onServer']),
    );
  }

  static Future<int> descargarEncuesta(Encuesta encuesta) async {
    Database database = await _openDB();

    //todo verificar si ya existe en la bd
    List<Map> list = await database.rawQuery(
        'SELECT * FROM encuestas where id_encuesta = "${encuesta.idEncuesta}"');
    print('existen registro: ${list.length}');
    if (list.length > 0) return 0;

    EncuestaSqlite encuestaSqlite = new EncuestaSqlite(
        idEncuesta: encuesta.idEncuesta, content: encuesta.toJson());
    print('encuesta descargada');
    return database.insert("encuestas", encuestaSqlite.toMap());
  }

  static Future<bool> existe(Encuesta encuesta) async {
    Database database = await _openDB();
    List<Map> list = await database.rawQuery(
        'SELECT * FROM encuestas where id_encuesta = "${encuesta.idEncuesta}"');
    print(list.length);
    if (list.length > 0) return true;
    return false;
  }

  static Future<Encuesta> getEncuestaById(String id) async {
    Database database = await _openDB();
    List<Map<String, dynamic>> list = await database
        .rawQuery('SELECT * FROM encuestas where id_encuesta = "$id"');
    return Encuesta.fromJson(list[0]['content']);
  }

  static Future<int> saveAplicacion(AplicacionEncuesta aplicacion) async {
    Database database = await _openDB();

    AplicacionSqlite aplicacionSqlite = new AplicacionSqlite(
        id: aplicacion.id, content: aplicacion.toJson(), onServer: 0);
    print('aplicación almacenada');
    return database.insert("aplicaciones", aplicacionSqlite.toMap());
  }

  static Future<Encuesta> getAplicacionById(int id) async {
    Database database = await _openDB();
    List<Map<String, dynamic>> list = await database
        .rawQuery('SELECT * FROM aplicaciones where id_encuesta = "$id"');
    return Encuesta.fromJson(list[0]['content']);
  }

  static Future<void> updateOnServer(String id, bool b) async {
    Database database = await _openDB();
    return database.execute('');
  }
}
