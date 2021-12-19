import 'dart:convert';

import 'package:encuestas_system/domain/entities/Pregunta.dart';

class AplicacionEncuesta {
  AplicacionEncuesta({
    required this.idEncuesta,
    required this.createAt,
    required this.updateAt,
    //required this.encuestador,
    required this.preguntas,
  });

  String idEncuesta;
  String createAt;
  String updateAt;
  //Encuestador encuestador;
  List<Pregunta> preguntas;

  factory AplicacionEncuesta.fromJson(String str) =>
      AplicacionEncuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AplicacionEncuesta.fromMap(Map<String, dynamic> json) =>
      AplicacionEncuesta(
        idEncuesta: json["id_encuesta"],
        createAt: json["createAt"],
        updateAt: json["createUpdate"],
        //encuestador: Encuestador.fromMap(json["encuestador"]),
        preguntas: List<Pregunta>.from(
            json["preguntas"].map((x) => Pregunta.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_encuesta": idEncuesta,
        "createAt": createAt,
        "createUpdate": updateAt,
        //"encuestador": encuestador.toMap(),
        "preguntas": List<dynamic>.from(preguntas.map((x) => x.toMap())),
      };
}
