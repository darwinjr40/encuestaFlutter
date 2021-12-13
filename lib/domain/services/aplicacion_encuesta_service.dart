import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class AplicacionService with ChangeNotifier {
  List<Seccion> secciones = [];
  List<dynamic> _seleccionados = [];

  void add(dynamic option) {
    _seleccionados.add(option);
    notifyListeners();
  }

  void cancelar() {
    _seleccionados = [];
    notifyListeners();
  }
}
