import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CardEncuesta extends StatelessWidget {
  final Encuesta encuesta;

  const CardEncuesta({Key? key, required this.encuesta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          titulo(encuesta.nombreE),
          greenLine(),
          descripcion(encuesta.descripcion),
          seccionesText(encuesta.cantSecciones),
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

  Widget titulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(
        color: Color.fromRGBO(44, 44, 44, 1.0),
      ),
    );
  }

  Widget greenLine() {
    return Expanded(
      child: Container(
        height: 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color.fromRGBO(59, 210, 127, 1.0),
        ),
      ),
    );
  }

  Widget descripcion(String descripcion) {
    return Container(
      child: Text(
        descripcion,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget seccionesText(int n) {
    return Container(
      child: Text(
        'Secciones: $n',
        style: TextStyle(
          color: Color.fromRGBO(59, 210, 127, 1.0),
        ),
      ),
    );
  }

  Widget verEncuestaButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Center(
        child: Text('Ver Encuesta'),
      ),
    );
  }
}
