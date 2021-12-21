import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/entities/sqlite/AplicacionSqlite.dart';
import 'package:encuestas_system/domain/services/encuestasDB.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'internet_connection_check.service.dart';

class AplicacionTimer extends ChangeNotifier {
  final periodo = Duration(seconds: 5);
  AplicacionTimer() {
    iniciarLoop();
  }

  void iniciarLoop() {
    /* final conectionService =
        Provider.of<ConnectionStatusModel>(_, listen: false); */
    Timer.periodic(this.periodo, (Timer t) => subirAplicaciones());
  }

  void detenerLoop() {}

  Future<List<AplicacionEncuesta>> getListAplicacionesNoSubidas() async {
    List<AplicacionEncuesta> listaAplicaciones = [];
    List<AplicacionSqlite> lista = await EncuestaDB
        .getAplicacionesNoSubidas(); //* retorna AplicacionesSqlite
    //* convertir a objetos AplicacionEncuesta
    lista.forEach((element) {
      String content = element.content;
      AplicacionEncuesta app = AplicacionEncuesta.fromMap(jsonDecode(content));
      listaAplicaciones.add(app);
    });
    return listaAplicaciones;
  }

  Future subirAplicaciones() async {
    String urlVeryEncuesta = 'encuesta-login-web.herokuapp.com';
    List<AplicacionEncuesta> aplicaciones =
        await getListAplicacionesNoSubidas();

    if (aplicaciones.length == 0) return;
    aplicaciones.forEach((encuestaAGuargdar) async {
      if (!ConnectionStatusModel.isOnline) return;
      String id = encuestaAGuargdar.id!;
      print('id de la app a guardar: $id');
      final url = Uri.https(
          urlVeryEncuesta, '/API/encuestas/B/existeAplicacionEncuesta/$id');
      final existe = await http.get(url);
      bool existeFinal = jsonDecode(existe.body);
      if (!existeFinal) {
        //SI ES FALSO HAY QUE SUBIRLO
        //guardar la encuesta

        sendAplicacion(encuestaAGuargdar);
        EncuestaDB.updateOnServer(encuestaAGuargdar.id!);
      }

      print('ID_ENCUESTA SQL: ${encuestaAGuargdar.id}, $existeFinal');
    });
    notifyListeners();
  }

  Future<String> sendAplicacion(AplicacionEncuesta encuestaAplicada) async {
    String urlAplicacion = 'encuestasapp-e3fc3-default-rtdb.firebaseio.com';
    final url = Uri.https(urlAplicacion, 'aplicacion_encuesta.json');
    final respuesta = await http.post(url, body: encuestaAplicada.toJson());
    final resp = json.decode(respuesta.body);
    return resp['name'] as String;
  }
}
