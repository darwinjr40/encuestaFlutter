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
        SizedBox(height: 7.0),
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
      // listaOpcionesButton.add(Text(opciones[i]));
      listaOpcionesButton.add(OpcionSelection(opcion: opciones[i]));
      listaOpcionesButton.add(SizedBox(
        height: 10.0,
      ));
    }
    return listaOpcionesButton;
  }

  Widget opcion(String opcion) {
    return Container(
      child: Row(
        children: [],
      ),
    );
  }
}

class OpcionSelection extends StatefulWidget {
  final String opcion;

  const OpcionSelection({required this.opcion});
  @override
  _OpcionSelectionState createState() => _OpcionSelectionState();
}

class _OpcionSelectionState extends State<OpcionSelection> {
  bool isSelected = false;

  Color selected = Color.fromRGBO(59, 210, 127, 1);
  Color noSelected = Color.fromRGBO(255, 255, 255, 1.0);

  Color color = Color.fromRGBO(255, 255, 255, 1.0);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!isSelected) {
            color = selected;
            isSelected = !isSelected;
          } else {
            color = noSelected;
            isSelected = !isSelected;
          }
        });
      },
      child: Container(
        child: Row(
          children: [
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(164, 164, 166, 1.0),
                ),
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            SizedBox(width: 30.0),
            Text(
              widget.opcion,
              style: TextStyle(fontSize: 17.0),
            )
          ],
        ),
      ),
    );
  }
}
