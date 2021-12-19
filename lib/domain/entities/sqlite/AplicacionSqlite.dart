class AplicacionSqlite {
  //final int? id;
  final String id;
  final String content;
  bool onServer = false;

  AplicacionSqlite(
      {required this.id, required this.content, required this.onServer});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      //"id": id,
      "id": id,
      "content": content,
    };
  }

  @override
  String toString() {
    return " idAplicacion: ${this.id}, content: ${this.content}";
  }
}
