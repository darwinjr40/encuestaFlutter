import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/checkbox.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CardPreguntaMultiple extends StatefulWidget {
  final Pregunta pregunta;
  CardPreguntaMultiple({required this.pregunta});

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
        SizedBox(height: 7.0),
        opciones(widget.pregunta, widget.pregunta.opciones),
        Text(widget.pregunta.idPregunta),
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

  Widget opciones(Pregunta pregunta, List<Opcion> opciones) {
    return Column(
      children: getOpciones(pregunta, opciones),
    );
  }

  List<Widget> getOpciones(Pregunta pregunta, List<Opcion> opciones) {
    List<Widget> listaOpcionesButton = [];

    for (var i = 0; i < opciones.length; i++) {
      listaOpcionesButton
          .add(new CheckBoxOption(pregunta: pregunta, opcion: opciones[i]));
    }
    return listaOpcionesButton;
  }
}
