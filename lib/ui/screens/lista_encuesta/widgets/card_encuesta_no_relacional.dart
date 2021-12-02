import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CardEncuestaNoRelacional extends StatelessWidget {
  final Encuesta encuesta;

  const CardEncuestaNoRelacional({required this.encuesta});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          titulo(encuesta.nombreE),
          greenLine(),
          descripcion(encuesta.descripcion),
          seccionesText(encuesta.cantSecciones),
          verEncuestaButton(context),
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
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          titulo,
          style:
              TextStyle(color: Color.fromRGBO(44, 44, 44, 1.0), fontSize: 20.0),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget greenLine() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: 1.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color.fromRGBO(59, 210, 127, 1.0),
        ),
      ),
    );
  }

  Widget descripcion(String descripcion) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            descripcion,
            style: TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(123, 123, 123, 1.0)),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget seccionesText(int n) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Secciones: $n',
            style: TextStyle(
              color: Color.fromRGBO(59, 210, 127, 1.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget verEncuestaButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            Color.fromRGBO(61, 61, 61, 1.0),
          ),
        ),

        /* style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(61, 61, 61, 1.0),
        ), */
        onPressed: () {
          Navigator.pushNamed(context, 'encuestaNoRelacional', arguments: encuesta);
        },
        child: Center(
          child: Text(
            'Ver Encuesta',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
