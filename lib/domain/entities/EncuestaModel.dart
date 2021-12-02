import 'dart:convert';

import 'package:encuestas_system/domain/entities/Seccion.dart';

class Encuesta {
  Encuesta({
    required this.idEncuesta,
    required this.nombreE,
    required this.descripcion,
    this.secciones,
    required this.cantSecciones,
    required this.estado,
  });

  int idEncuesta;
  String nombreE;
  String descripcion;
  List<Seccion>? secciones;
  int cantSecciones;
  bool estado;

  factory Encuesta.fromJson(String str) => Encuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Encuesta.fromMap(Map<String, dynamic> json) => Encuesta(
        idEncuesta: json["id_encuesta"],
        nombreE: json["nombre_e"],
        descripcion: json['descripcion'],
        secciones: (json['seccion'] != null)
            ? List<Seccion>.from(json["seccion"].map((x) => Seccion.fromMap(x)))
            : [],
        cantSecciones: json["cant_secciones"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id_encuesta": idEncuesta,
        "nombre_e": nombreE,
        "seccion": List<dynamic>.from(secciones!.map((x) => x.toMap())),
        "cant_secciones": cantSecciones,
      };
}
