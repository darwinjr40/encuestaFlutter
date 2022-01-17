import 'dart:convert';

import 'package:encuestas_system/domain/entities/Seccion.dart';

class Encuesta {
  Encuesta({
    required this.idEncuesta,
    required this.nombreE,
    required this.descripcion,
    required this.secciones,
    required this.cantSecciones,
    required this.cantAplicaciones,
    required this.estado,
    required this.fechaLimite,
  });

  String idEncuesta;
  String nombreE;
  String descripcion;
  List<Seccion> secciones;
  int cantSecciones;
  int cantAplicaciones;
  bool estado;
  String fechaLimite;

  factory Encuesta.fromJson(String str) => Encuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Encuesta.fromMap(Map<String, dynamic> json) => Encuesta(
        idEncuesta: json["id_encuesta"].toString(),
        nombreE: json["nombre_e"],
        descripcion: json['descripcion'],
        secciones: (json['seccion'] != null)
            ? List<Seccion>.from(json["seccion"].map((x) => Seccion.fromMap(x)))
            : [],
        cantSecciones: json["cant_secciones"],
        cantAplicaciones: json["cant_aplicaciones"],
        estado: json["estado"],
        fechaLimite: json["fechaLimite"],
      );

  Map<String, dynamic> toMap() => {
        "id_encuesta": idEncuesta,
        "nombre_e": nombreE,
        "descripcion": descripcion,
        "seccion": List<dynamic>.from(secciones.map((x) => x.toMap())),
        "estado": estado,
        "cant_secciones": cantSecciones,
        "cant_aplicaciones": cantAplicaciones,
        "fechaLimite": fechaLimite,
      };
}
