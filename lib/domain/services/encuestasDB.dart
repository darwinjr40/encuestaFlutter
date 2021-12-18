import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:encuestas_system/domain/entities/EncuestaModel.dart';
import 'package:encuestas_system/domain/entities/sqlite/EncuestaSqlite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class EncuestaDB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'encuestas.db'),
        onCreate: (db, version) {
      return db.execute(
        "create table encuestas (id_encuesta TEXT, content TEXT); ",
      );
    }, version: 1);
  }

  static Future<int> insertEncuesta(Encuesta encuesta) async {
    Database database = await _openDB();
    /* await database.rawInsert("INSERT into encuestas (id ,id_encuesta, content)"
        "VALUES (11101, \"as\", \"dsfs\")"); */
    String a = json.encode(encuesta.toMap());
    EncuestaSqlite encuestaSqlite = new EncuestaSqlite(
        idEncuesta: encuesta.idEncuesta, content: encuesta.toJson());
    print('se pudo');
    return database.insert("encuestas", encuestaSqlite.toMap());
    /* for (var i = 1; i < 10; i++) {
      await database
          .rawInsert("INSERT into encuestas (id ,id_encuesta, content)"
              "VALUES (${i * 1000} , \"as\", \"dsfs\")");
    } */
    //EncuestaSqlite encuestaSqlite =
    //new EncuestaSqlite(null, encuesta.idEncuesta, encuesta.toJson());
    /* await database.rawInsert("INSERT into encuestas (id, content)"
        "VALUES (${encuestaSqlite.id}, ${encuestaSqlite.content})"); */
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

  static Future<void> createTableEncuestas() async {
    Database database = await _openDB();
    return database
        .execute("create table encuestas (id_encuesta TEXT, content TEXT); ");
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
}
