class AplicacionSqlite {
  //final int? id;
  String? id;
  final String content;
  int onServer = 0; //* 0 si no está en el server, 1 si ya está subido

  AplicacionSqlite({this.id, required this.content, required this.onServer});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "content": content,
      "onServer": onServer,
    };
  }

  @override
  String toString() {
    return " idAplicacion: ${this.id}, content: ${this.content}, en server = ${this.onServer}";
  }
}
