import 'dart:convert';

import 'package:encuestas_system/domain/entities/Pregunta.dart';

class AplicacionEncuesta {
  AplicacionEncuesta({
    this.idEncuesta,
    this.nombre,
    this.createAt,
    this.updateAt,
    //required this.encuestador,
    this.preguntas,
  });

  String? idEncuesta;
  String? nombre;
  String? createAt;
  String? updateAt;
  //Encuestador encuestador;
  List<Pregunta>? preguntas;

  factory AplicacionEncuesta.fromJson(String str) =>
      AplicacionEncuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AplicacionEncuesta.fromMap(Map<String, dynamic> json) =>
      AplicacionEncuesta(
        idEncuesta: json["id_encuesta"],
        createAt: json["createAt"],
        updateAt: json["createUpdate"],
        nombre: json["nombre"],
        //encuestador: Encuestador.fromMap(json["encuestador"]),
        preguntas: List<Pregunta>.from(
            json["preguntas"].map((x) => Pregunta.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_encuesta": idEncuesta,
        "createAt": createAt,
        "createUpdate": updateAt,
        "nombre": nombre,
        //"encuestador": encuestador.toMap(),
        "preguntas": List<dynamic>.from(preguntas!.map((x) => x.toMap())),
      };
}
