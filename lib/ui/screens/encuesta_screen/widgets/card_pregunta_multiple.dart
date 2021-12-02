import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CardPreguntaMultiple extends StatefulWidget {
  final Pregunta pregunta;

  const CardPreguntaMultiple({required this.pregunta});

  @override
  _CardPreguntaMultipleState createState() => _CardPreguntaMultipleState();
}

class _CardPreguntaMultipleState extends State<CardPreguntaMultiple> {
  @override
  Widget build(BuildContext context) {
    return CardContainer(
        child: Column(
      children: [
        nombre(widget.pregunta.nombreP),
        opciones(widget.pregunta.opDeResp),
      ],
    ));
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

  Widget opciones(List<String> opciones) {
    return Column(
      children: getOpciones(opciones),
    );
  }

  List<Widget> getOpciones(List<String> opciones) {
    List<Widget> listaOpcionesButton = [];
    for (var i = 0; i < opciones.length; i++) {
      listaOpcionesButton.add(Text(opciones[i]));
    }
    return listaOpcionesButton;
  }
}
