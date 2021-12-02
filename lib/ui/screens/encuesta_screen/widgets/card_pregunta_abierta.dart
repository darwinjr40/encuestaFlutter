import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class CardPreguntaAbierta extends StatefulWidget {
  final Pregunta pregunta;

  const CardPreguntaAbierta({Key? key, required this.pregunta})
      : super(key: key);

  @override
  _CardPreguntaAbiertaState createState() => _CardPreguntaAbiertaState();
}

class _CardPreguntaAbiertaState extends State<CardPreguntaAbierta> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
