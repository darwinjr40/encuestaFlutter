import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/entities/sqlite/AplicacionSqlite.dart';
import 'package:encuestas_system/domain/services/encuestasDB.dart';
import 'package:sqflite/sqflite.dart';

class AplicacionTimer {
  final periodo = Duration(seconds: 5);
  List<AplicacionEncuesta> listaSubir = [];

  AplicacionTimer() {
    iniciarLoop();
  }

  void iniciarLoop() {
    Timer.periodic(
        this.periodo, (Timer t) => print('verificando aplicaciones'));
  }

  Future<List<AplicacionEncuesta>> getListAplicacionesNoSubidas() async {
    List<AplicacionEncuesta> listaAplicaciones = [];
    List<AplicacionSqlite> lista =
        await EncuestaDB.getAplicaciones(); //* retorna AplicacionesSqlite

    //* convertir a objetos AplicacionEncuesta
    lista.forEach((element) {
      String content = element.content;
      AplicacionEncuesta app = AplicacionEncuesta.fromMap(jsonDecode(content));
      listaAplicaciones.add(app);
      listaSubir.add(app);
    });
    return listaAplicaciones;
  }

  void subirAplicaciones(List<AplicacionEncuesta> aplicaciones) {}

  Future<String> sendAplicacion(AplicacionEncuesta encuestaAplicada) async {
    String urlAplicacion = 'encuestasapp-e3fc3-default-rtdb.firebaseio.com';
    final url = Uri.https(urlAplicacion, 'aplicacion_encuesta.json');
    final respuesta = await http.post(url, body: encuestaAplicada.toJson());
    final resp = json.decode(respuesta.body);
    return resp['name'] as String;
  }

  //todo falta hacer un metodo en la base de datos para actualizar el onServer
}
