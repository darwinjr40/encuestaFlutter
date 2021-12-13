import 'dart:convert';

import 'package:encuestas_system/domain/entities/Option.dart';

class Pregunta {
  Pregunta({
    required this.idPregunta,
    required this.nombreP,
    required this.tipo,
    required this.opDeResp,
    required this.opciones,
  });

  String idPregunta;
  String nombreP;
  String tipo;
  List<String> opDeResp;
  List<Opcion> opciones;

  factory Pregunta.fromJson(String str) => Pregunta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pregunta.fromMap(Map<String, dynamic> json) => Pregunta(
        idPregunta: json["id_pregunta"].toString(),
        nombreP: json["nombre_p"],
        tipo: json["tipo"],
        opDeResp: List<String>.from(json["op_de_resp"].map((x) => x)),
        opciones: List<Opcion>.from(
            json["op_de_resp"].map((x) => Opcion.fromString(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_pregunta": idPregunta.toString(),
        "nombre_p": nombreP,
        "tipo": tipo,
        "op_de_resp": List<dynamic>.from(opDeResp.map((x) => x)),
        //"opciones": List<dynamic>.from(opciones.map((x) => x.toMap())),
      };
}
