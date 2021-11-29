import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;

class ModeloEncuestaService extends ChangeNotifier {
  String response = '';

  Future<void> cargarEncuestas() async {
    final resp = await rootBundle.loadString('list_model_encuestas.json');
    response = resp;
  }
}
