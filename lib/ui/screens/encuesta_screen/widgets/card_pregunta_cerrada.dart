import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPreguntaCerrada extends StatefulWidget {
  final Pregunta pregunta;

  const CardPreguntaCerrada({Key? key, required this.pregunta});

  @override
  _CardPreguntaCerradaState createState() => _CardPreguntaCerradaState();
}

class _CardPreguntaCerradaState extends State<CardPreguntaCerrada> {
  String opcionSeleccionada = '';
  String selected = 'no response';

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          nombre(widget.pregunta.nombreP),
          opciones(widget.pregunta.opciones),
          Text(widget.pregunta.idPregunta),
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

  Widget opciones(List<Opcion> opciones) {
    return Column(
      children: getOpciones(opciones),
    );
  }

  List<Widget> getOpciones(List<Opcion> opciones) {
    List<Widget> listaOpcionesButton = [];
    for (var i = 0; i < opciones.length; i++) {
      listaOpcionesButton.add(ListTile(
        title: Text(opciones[i].nombre),
        leading: Radio<String>(
          value: opciones[i].nombre,
          groupValue: selected,
          onChanged: (value) {
            final aplicacionService =
                Provider.of<AplicacionService>(context, listen: false);
            if (aplicacionService.aplicacionMode != true) return;
            setState(() {
              //selectedRadio = value as int;
              selected = value as String;
              print(selected);
              aplicacionService.add(widget.pregunta, selected);
            });
          },
          activeColor: Color.fromRGBO(59, 210, 127, 1),
        ),
      ));

      //listaOpcionesButton.add(OpcionSelection(opcion: opciones[i]));
      /* listaOpcionesButton.add(SizedBox(
        height: 10.0,
      )); */
    }
    return listaOpcionesButton;
  }
}

// * YA NO LO UTILIZO:
/* class OpcionSelection extends StatefulWidget {
  final String opcion;

  const OpcionSelection({required this.opcion});
  @override
  _OpcionSelectionState createState() => _OpcionSelectionState();
} */

/* class _OpcionSelectionState extends State<OpcionSelection> {
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
              width: 30.0,
              height: 30.0,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(164, 164, 166, 1.0),
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
                  ),
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(width: 30.0),
            Expanded(
              child: Text(
                widget.opcion,
                style: TextStyle(fontSize: 17.0),
                // overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    );
  }
} */

// * YA NO LO UTILIZO :
/* class OpcionButton extends StatefulWidget {
  final String opcion;

  const OpcionButton({required this.opcion});

  @override
  _OpcionButtonState createState() => _OpcionButtonState();
} */

/* class _OpcionButtonState extends State<OpcionButton> {
  String opcionSeleccionada = '';
  bool isSelected = false;

  Color selected = Color.fromRGBO(59, 210, 127, 1);
  Color noSelected = Color.fromRGBO(255, 255, 255, 1.0);

  Color color = Color.fromRGBO(255, 255, 255, 1.0);
  Color textSelectedColor = Color.fromRGBO(255, 255, 255, 1.0);
  Color textNoSelectedColor = Color.fromRGBO(98, 98, 98, 1.0);

  Color textColor = Color.fromRGBO(98, 98, 98, 1.0);


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

  void cambiarColor() {}
} */
