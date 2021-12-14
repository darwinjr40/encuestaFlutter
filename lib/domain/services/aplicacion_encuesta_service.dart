import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class AplicacionService with ChangeNotifier {
  bool aplicacionMode = false;

  void add(dynamic option) {
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
