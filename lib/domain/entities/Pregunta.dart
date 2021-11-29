import 'dart:convert';

class Pregunta {
  Pregunta({
    required this.idPregunta,
    required this.nombreP,
    required this.tipo,
    required this.opDeResp,
  });

  int idPregunta;
  String nombreP;
  String tipo;
  List<String> opDeResp;

  factory Pregunta.fromJson(String str) => Pregunta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pregunta.fromMap(Map<String, dynamic> json) => Pregunta(
        idPregunta: json["id_pregunta"],
        nombreP: json["nombre_p"],
        tipo: json["tipo"],
        opDeResp: List<String>.from(json["op_de_resp"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id_pregunta": idPregunta,
        "nombre_p": nombreP,
        "tipo": tipo,
        "op_de_resp": List<dynamic>.from(opDeResp.map((x) => x)),
      };
}
