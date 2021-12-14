import 'dart:convert';

class Opcion {
  Opcion({
    required this.idResp,
    required this.nombre,
  });

  String idResp;
  String nombre;

  factory Opcion.fromJson(String str) => Opcion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Opcion.fromMap(Map<String, dynamic> json) => Opcion(
        idResp: json["id_resp"],
        nombre: json["nombre_resp"],
      );

  Map<String, dynamic> toMap() => {
        "id_resp": idResp,
        "nombre_resp": nombre,
      };
}
