import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CardPreguntaCerrada extends StatefulWidget {
  final Pregunta pregunta;

  const CardPreguntaCerrada({Key? key, required this.pregunta});

  @override
  _CardPreguntaCerradaState createState() => _CardPreguntaCerradaState();
}

class _CardPreguntaCerradaState extends State<CardPreguntaCerrada> {
  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          nombre(widget.pregunta.nombreP),
          opciones(widget.pregunta.opDeResp),
        ],
        /* padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          color: Colors.red,
        ), */
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

  Widget opciones(List<String> opciones) {
    return Column(
      children: getOpciones(opciones),
    );
  }

  List<Widget> getOpciones(List<String> opciones) {
    List<Widget> listaOpcionesButton = [];
    for (var i = 0; i < opciones.length; i++) {
      listaOpcionesButton.add(OpcionButton(opcion: opciones[i]));
    }
    return listaOpcionesButton;
  }
}

class OpcionButton extends StatefulWidget {
  final String opcion;

  const OpcionButton({required this.opcion});

  @override
  _OpcionButtonState createState() => _OpcionButtonState();
}

class _OpcionButtonState extends State<OpcionButton> {
  bool isSelected = false;
  int c = 0;

  Color selected = Color.fromRGBO(59, 210, 127, 1);
  Color noSelected = Color.fromRGBO(255, 255, 255, 1.0);

  Color color = Color.fromRGBO(255, 255, 255, 1.0);
  Color textSelectedColor = Color.fromRGBO(255, 255, 255, 1.0);
  Color textNoSelectedColor = Color.fromRGBO(98, 98, 98, 1.0);

  Color textColor = Color.fromRGBO(98, 98, 98, 1.0);

  //to do:
  //metodo para pintar todos los botones en blanco al seleccionar una opcion diferente
  //metodo para pintar el boton tocado

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!isSelected) {
            color = selected;
            textColor = textSelectedColor;
            isSelected = !isSelected;
          } else {
            color = noSelected;
            textColor = textNoSelectedColor;
            isSelected = !isSelected;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          width: 330.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(164, 164, 166, 1.0),
            ),
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          padding: EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.opcion,
              style: TextStyle(fontSize: 20.0, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
