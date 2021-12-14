import 'package:encuestas_system/domain/entities/Respuesta.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class AplicacionService with ChangeNotifier {
  bool aplicacionMode = false;
  List<Respuesta> respuestas = [];

  void add(Pregunta pregunta, String valor) {
    if (pregunta.tipo == "simple") {
      Opcion opActual = new Opcion(idResp: "", nombre: valor);
      Respuesta respuestaActual = new Respuesta(
          idPregunta: pregunta.idPregunta,
          nombrePregunta: pregunta.nombreP,
          opcions: [opActual],
          respuestaText: "");
      respuestas.add(respuestaActual);
      imprimirRespuestas();
    }
    // *buscar por el id de la pregunta y si es cerrada reemplazar el valor de la única opcion
    //print('id: ${pregunta.idPregunta}, valor: ${valor}');
    notifyListeners();
  }

  void imprimirRespuestas() {
    for (var respuesta in respuestas) {
      print(
          'id pregunta: ${respuesta.idPregunta}, nombre: ${respuesta.nombrePregunta}');
      for (var opcion in respuesta.opcions) {
        print('id: ${opcion.idResp}, nommbre: ${opcion.nombre}');
      }
    }
  }

  void seleccionar(Pregunta pregunta, String valor) {
    for (var respuesta in respuestas) {}
  }

  void cancelar() {
    notifyListeners();
  }

  getValor(String idSeccion, String idPregunta) {}
}

class SeccionPregunta {
  final String idSeccion;
  final String idPregunta;

  SeccionPregunta(this.idSeccion, this.idPregunta);
}
