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
              selected = value as String;
              aplicacionService.seleccionar(widget.pregunta, opciones[i]);
            });
          },
          activeColor: Color.fromRGBO(59, 210, 127, 1),
        ),
      ));
    }
    return listaOpcionesButton;
  }
}
