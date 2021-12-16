import 'dart:convert';

class Encuestador {
  Encuestador({
    required this.idEncuestador,
    required this.nombre,
    required this.ci,
    required this.fechaNac,
  });

  String idEncuestador;
  String nombre;
  String ci;
  String fechaNac;

  factory Encuestador.fromJson(String str) =>
      Encuestador.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Encuestador.fromMap(Map<String, dynamic> json) => Encuestador(
        idEncuestador: json["id_encuestador"],
        nombre: json["nombre"],
        ci: json["ci"],
        fechaNac: json["fecha_nac"],
      );

  Map<String, dynamic> toMap() => {
        "id_encuestador": idEncuestador,
        "nombre": nombre,
        "ci": ci,
        "fecha_nac": fechaNac,
      };
}
