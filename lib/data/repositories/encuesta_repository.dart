import 'package:encuestas_system/domain/entities/EncuestaModel.dart';
import 'package:encuestas_system/domain/repositories/abstract_encuesta.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EncuestaRepository extends ChangeNotifier
    implements AbstractEncuestaRepository {
  @override
  Future<List<Encuesta>> getListNoRelacional() async {
    List<Encuesta> listaEncuestasNoRelacional = [];
    var response = await http.get(Uri.parse(
        'https://encuesta-login-web.herokuapp.com/API/encuestas/B/listaDeEncuestas'));
    var jsonResponse = convert.jsonDecode(response.body);
    for (var item in jsonResponse) {
      Encuesta encuesta = Encuesta.fromMap(item);
      listaEncuestasNoRelacional.add(encuesta);
    }
    //print('json response List No Relacional: $jsonResponse');
    return listaEncuestasNoRelacional;
  }

  @override
  Future<Encuesta> getEncuestaNoRelacional(String id) async {
    Encuesta encuesta;

    var response = await http.get(Uri.parse(
        'https://encuesta-login-web.herokuapp.com/API/encuestas/B/getEncuesta/$id'));

    var jsonResponse = convert.jsonDecode(response.body);
    //print('json response Una Encuesta No Relacional: $jsonResponse');

    encuesta = Encuesta.fromMap(jsonResponse);
    print('encuesta no relacional: $jsonResponse');
    return encuesta;
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
    return listaEncuestas;
  }

  @override
  Future<Encuesta> getEncuestaRelacional(String id) async {
    Encuesta encuesta;
    int idEntero = int.parse(id);
    var response = await http.get(Uri.parse(
        'https://encuesta-login-web.herokuapp.com/API/encuestas/A/getEncuesta/$idEntero'));

    var jsonResponse = convert.jsonDecode(response.body);
    //print('json response: $jsonResponse');

    encuesta = Encuesta.fromMap(jsonResponse);
    /* print(
        'cantidad de secciones en la respuesta json: ${encuesta.secciones.length}'); */
    return encuesta;
  }
}
