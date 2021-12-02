import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/card_pregunta_abierta.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/card_pregunta_cerrada.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/card_pregunta_multiple.dart';
import 'package:flutter/material.dart';

class SeccionScreen extends StatefulWidget {
  final Seccion seccion;

  const SeccionScreen({required this.seccion});
  @override
  _SeccionScreenState createState() => _SeccionScreenState();
}

class _SeccionScreenState extends State<SeccionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: [
          nombreSeccion(widget.seccion.nombreS),
          Column(
            children: cargarPreguntas(widget.seccion.preguntas),
          )
        ],
      ),
    );
  }

  Widget nombreSeccion(String nombreSeccion) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Text(nombreSeccion),
      ),
    );
  }

  List<Widget> cargarPreguntas(List<Pregunta> preguntas) {
    List<Widget> preguntasCard = [];
    for (var pregunta in preguntas) {
      if (pregunta.tipo == 'simple')
        preguntasCard.add(CardPreguntaCerrada(pregunta: pregunta));
      if (pregunta.tipo == 'multiple')
        preguntasCard.add(CardPreguntaMultiple(pregunta: pregunta));
      if (pregunta.tipo == 'abierta')
        preguntasCard.add(CardPreguntaAbierta(pregunta: pregunta));

      preguntasCard.add(SizedBox(height: 20.0));
    }

    return preguntasCard;
  }
}
