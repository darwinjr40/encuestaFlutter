import 'package:encuestas_system/domain/entities/Respuesta.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class AplicacionService with ChangeNotifier {
  bool aplicacionMode = false;
  List<Respuesta> respuestas = [];

  void add(String pregunta, String valor) {
    // *buscar por el id de la pregunta y si es cerrada reemplazar el valor de la única opcion
    notifyListeners();
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
