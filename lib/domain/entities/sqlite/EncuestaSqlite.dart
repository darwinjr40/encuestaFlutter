import 'package:sqflite/sqflite.dart';

class EncuestaSqlite {
  //final int? id;
  final String? idEncuesta;
  final String? content;

  EncuestaSqlite({required this.idEncuesta, required this.content});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      //"id": id,
      "id_encuesta": idEncuesta,
      "content": content,
    };
  }

  @override
  String toString() {
    return " idEncuesta: ${this.idEncuesta}, content: ${this.content}";
  }
}
