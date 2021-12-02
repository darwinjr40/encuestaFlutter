import 'dart:convert';

import 'package:encuestas_system/domain/entities/Pregunta.dart';

class Seccion {
  Seccion({
    this.idSeccion,
    required this.nombreS,
    required this.preguntas,
    required this.cantPreguntas,
  });

  int? idSeccion;
  String nombreS;
  List<Pregunta> preguntas;
  int cantPreguntas;

  factory Seccion.fromJson(String str) => Seccion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Seccion.fromMap(Map<String, dynamic> json) => Seccion(
        idSeccion: json["id_seccion"],
        nombreS: json["nombre_s"],
        preguntas: List<Pregunta>.from(
            json["preguntas"].map((x) => Pregunta.fromMap(x))),
        cantPreguntas: json["cant_preguntas"],
      );

  Map<String, dynamic> toMap() => {
        "id_seccion": idSeccion,
        "nombre_s": nombreS,
        "preguntas": List<dynamic>.from(preguntas.map((x) => x.toMap())),
        "cant_preguntas": cantPreguntas,
      };
}
