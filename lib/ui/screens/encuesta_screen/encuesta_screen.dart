import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class EncuestaScreen extends StatefulWidget {
  @override
  _EncuestaScreenState createState() => _EncuestaScreenState();
}

class _EncuestaScreenState extends State<EncuestaScreen> {
  @override
  Widget build(BuildContext context) {
    final Encuesta encuesta =
        ModalRoute.of(context)!.settings.arguments as Encuesta;

    return Scaffold(
      appBar: AppBar(
        title: Text('Encuesta screen'),
        backgroundColor: Color.fromRGBO(59, 210, 127, 1.0),
      ),
    );
  }
}
