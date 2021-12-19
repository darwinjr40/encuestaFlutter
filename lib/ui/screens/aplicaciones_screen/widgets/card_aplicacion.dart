import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

class CardAplicacion extends StatefulWidget {
  final AplicacionEncuesta aplicacion;
  bool status;
  CardAplicacion({Key? key, required this.aplicacion, required this.status})
      : super(key: key);

  @override
  _CardAplicacionState createState() => _CardAplicacionState();
}

class _CardAplicacionState extends State<CardAplicacion> {
  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Row(
        children: [
          Column(
            children: [
              titulo(widget.aplicacion.nombre!),
              fecha(widget.aplicacion.createAt!),
            ],
          ),
          iconoServer(widget.status),
        ],
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

  Widget fecha(String createAt) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(createAt),
      ),
    );
  }

  Widget hora(String hora) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(hora),
      ),
    );
  }

  Widget iconoServer(bool status) {
    return Container(
      color: Colors.red,
      child: (status)
          ? Icon(Icons.arrow_back_ios_outlined)
          : Icon(Icons.arrow_circle_down),
    );
  }
}
