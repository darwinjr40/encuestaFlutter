import 'package:encuestas_system/domain/entities/models.dart';
import 'dart:convert';

class Respuesta {
  Respuesta({
    required this.idPregunta,
    required this.nombrePregunta,
    required this.opcions,
    required this.respuestaText,
  });

  int idPregunta;
  String nombrePregunta;
  List<Opcion> opcions;
  String respuestaText;

  factory Respuesta.fromJson(String str) => Respuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Respuesta.fromMap(Map<String, dynamic> json) => Respuesta(
        idPregunta: json["id_pregunta"],
        nombrePregunta: json["nombre_pregunta"],
        opcions:
            List<Opcion>.from(json["opcions"].map((x) => Opcion.fromMap(x))),
        respuestaText: json["respuesta_text"],
      );

  Map<String, dynamic> toMap() => {
        "id_pregunta": idPregunta,
        "nombre_pregunta": nombrePregunta,
        "opcions": List<dynamic>.from(opcions.map((x) => x.toMap())),
        "respuesta_text": respuestaText,
      };
}
