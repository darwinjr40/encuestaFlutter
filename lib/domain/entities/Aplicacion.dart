import 'dart:convert';

import 'package:encuestas_system/domain/entities/Pregunta.dart';
import 'package:encuestas_system/domain/entities/Respuesta.dart';

class AplicacionEncuesta {
  AplicacionEncuesta({
    this.idEncuesta,
    this.nombre,
    this.createAt,
    this.updateAt,
    //required this.encuestador,
    required this.respDePreguntas,
  });

  String? idEncuesta;
  String? nombre;
  String? createAt;
  String? updateAt;
  //Encuestador encuestador;
  List<Respuesta> respDePreguntas;

  factory AplicacionEncuesta.fromJson(String str) =>
      AplicacionEncuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AplicacionEncuesta.fromMap(Map<String, dynamic> json) =>
      AplicacionEncuesta(
        idEncuesta: json["id_encuesta"],
        createAt: json["createAt"],
        updateAt: json["updateAt"],
        nombre: json["nombre"],
        //encuestador: Encuestador.fromMap(json["encuestador"]),
        respDePreguntas: List<Respuesta>.from(
            json["respuestas"].map((x) => Pregunta.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_encuesta": idEncuesta,
        "createAt": createAt,
        "updateAt": updateAt,
        "nombre": nombre,
        //"encuestador": encuestador.toMap(),
        "respDePreguntas": List<dynamic>.from(respDePreguntas.map((x) => x.toMap())),
      };
}
