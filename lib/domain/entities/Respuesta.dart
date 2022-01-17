import 'package:encuestas_system/domain/entities/models.dart';
import 'dart:convert';

class Respuesta {
  Respuesta({
    required this.idPregunta,
    required this.nombrePregunta,
    required this.tipoPregunta,
    required this.opcions,
    this.respuestaText,
  });

  String idPregunta;
  String nombrePregunta;
  String? tipoPregunta;
  List<Opcion>
      opcions; //* si es cerrada, esa lista solo tiene 1 elemento, si es múltiple tendrá 1 o mas
  String? respuestaText;

  factory Respuesta.fromJson(String str) => Respuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Respuesta.fromMap(Map<String, dynamic> json) => Respuesta(
        idPregunta: json["id_pregunta"],
        nombrePregunta: json["nombre_p"],
        tipoPregunta: json['tipoPregunta'],
        opcions:
            List<Opcion>.from(json["opcions"].map((x) => Opcion.fromMap(x))),
        respuestaText: json["respuesta_text"],
      );

  Map<String, dynamic> toMap() => {
        "id_pregunta": idPregunta,
        "nombre_p": nombrePregunta,
        "tipoPregunta": tipoPregunta,
        "opcions": List<dynamic>.from(opcions.map((x) => x.toMap())),
        "respuesta_text": respuestaText,
      };
}
