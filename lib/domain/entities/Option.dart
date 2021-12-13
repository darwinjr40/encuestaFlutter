import 'dart:convert';

class Opcion {
  Opcion({
    required this.idOption,
    required this.nombre,
    required this.selected,
  });

  int idOption;
  String nombre;
  bool selected;

  factory Opcion.fromJson(String str) => Opcion.fromMap(json.decode(str));

  factory Opcion.fromMap(Map<String, dynamic> json) => Opcion(
        idOption: json["id_option"],
        nombre: json["nombre"],
        selected: false,
      );

  factory Opcion.fromString(String nombre) =>
      Opcion(idOption: 1, nombre: nombre, selected: false);

  Map<String, dynamic> toMap() => {
        "id_option": idOption,
        "nombre": nombre,
      };

  bool isSelected() {
    if (selected) return true;
    return false;
  }

  void noSelected() {
    this.selected = false;
  }

  void seleccionar() {
    this.selected = true;
  }
}
