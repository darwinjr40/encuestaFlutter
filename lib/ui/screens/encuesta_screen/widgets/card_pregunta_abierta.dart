import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
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
    return CardContainer(
      child: Column(
        children: [
          nombre(widget.pregunta.nombreP),
          SizedBox(height: 15.0),
          campoRespuesta(),
        ],
      ),
    );
  }

  Widget nombre(String titulo) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          titulo,
          style: TextStyle(
            color: Color.fromRGBO(44, 44, 44, 1.0),
            fontSize: 20.0,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget campoRespuesta() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(164, 164, 166, 1.0),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: TextField(
        maxLines: 10,
        cursorColor: Color.fromRGBO(44, 44, 44, 1.0),
      ),
    );
  }
}
