import 'dart:convert';

import 'package:encuestas_system/domain/entities/Option.dart';
import 'package:encuestas_system/domain/entities/Pregunta.dart';

import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckBoxOption extends StatefulWidget {
  const CheckBoxOption({required this.pregunta, required this.opcion});

  @override
  _CheckBoxOptionState createState() => _CheckBoxOptionState();
  final Opcion opcion;
  final Pregunta pregunta;
}

class _CheckBoxOptionState extends State<CheckBoxOption> {
  bool selected = false;

  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Color.fromRGBO(59, 210, 127, 1),
      value: this.selected, //checkbox.selected,
      title: Text(widget.opcion.nombre),
      onChanged: (value) {
        List<Opcion> opcionesSelecionadas = [];
        setState(() {
          this.selected = value!;
          final aplicacionService =
              Provider.of<AplicacionService>(context, listen: false);
          if (selected) {
            aplicacionService.seleccionar(widget.pregunta, widget.opcion);
          } else {
            aplicacionService.eliminarSeleccion(widget.pregunta, widget.opcion);
            print(jsonEncode(aplicacionService.respuestas));
          }
        });
      },
    );
  }
}
