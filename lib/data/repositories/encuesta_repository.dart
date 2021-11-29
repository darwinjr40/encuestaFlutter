import 'package:encuestas_system/domain/entities/EncuestaModel.dart';
import 'package:encuestas_system/domain/repositories/abstract_encuesta.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EncuestaRepository extends ChangeNotifier
    implements AbstractEncuestaRepository {
  @override
  Future<Encuesta> getEncuestaRelacional(int id) {
    // TODO: implement getEncuestaRelacional
    throw UnimplementedError();
  }

  @override
  Future<Encuesta> getEncuestaNoRelacional(int id) {
    // TODO: implement getEncuestaNoRelacional
    throw UnimplementedError();
  }

  @override
  Future<List<Encuesta>> getListNoRelacional() {
    // TODO: implement getListNoRelacional
    throw UnimplementedError();
  }

  @override
  Future<List<Encuesta>> getListRelacional() async {
    List<Encuesta> listaEncuestas = [];

    var response = await http.get(Uri.parse(
        'https://encuesta-login-web.herokuapp.com/API/encuestas/A/listaDeEncuestas'));

    var jsonResponse = convert.jsonDecode(response.body);

    for (var item in jsonResponse) {
      Encuesta encuesta = Encuesta.fromMap(item);
      listaEncuestas.add(encuesta);
    }
    //print(listaActuaciones);
    return listaEncuestas;
  }
}
