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
  bool state = false;

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

  List<CheckBoxState> getCheckBoxStateList() {
    List<CheckBoxState> list = [];
    for (var opcion in widget.pregunta.opciones) {
      CheckBoxState state = new CheckBoxState(opcion: opcion.nombre);
      list.add(state);
    }
    return list;
  }

  Widget opciones(List<String> opciones) {
    return Column(
      children: getOpciones(opciones),
    );
  }

  List<Widget> getOpciones(List<String> opciones) {
    List<Widget> listaOpcionesButton = [];
    List<CheckBoxState> states = getCheckBoxStateList();

    for (var i = 0; i < opciones.length; i++) {
      listaOpcionesButton.add(new CheckBoxOption(opcion: opciones[i]));
      print('se ejecuta el for');
      // listaOpcionesButton.add(Text(opciones[i]));
      /* listaOpcionesButton.add(OpcionSelection(opcion: opciones[i]));
      listaOpcionesButton.add(SizedBox(
        height: 10.0,
      )); */
    }
    return listaOpcionesButton;
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Color.fromRGBO(59, 210, 127, 1),
        value: checkbox.selected, //checkbox.selected,
        title: Text(checkbox.opcion),
        onChanged: (value) {
          print('selected: ${checkbox.selected}');
          print('value: $value ');
          setState(() {
            checkbox.selected = value!;
            print('selected a: ${checkbox.selected}');
          });
        },
      );
}

class CheckBoxState {
  final String opcion;
  bool selected = false;

  CheckBoxState({
    required this.opcion,
    // this.selected = false,
  });

  void setSelect() {
    if (this.selected == true) {
      this.selected = false;
      return;
    }
    this.selected = true;
  }
}
