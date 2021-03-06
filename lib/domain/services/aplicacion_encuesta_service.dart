import 'dart:convert';

import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/entities/Respuesta.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class AplicacionService with ChangeNotifier {
  bool aplicacionMode = false;
  int preguntasTotales = 0;
  AplicacionEncuesta aplicacion = new AplicacionEncuesta(respDePreguntas: []);
  List<Respuesta> respuestas = [];

  Respuesta? existeRespuesta(Pregunta pregunta) {
    for (var respuesta in respuestas) {
      if (respuesta.idPregunta == pregunta.idPregunta) return respuesta;
    }
    print('existeRespuesta');
    return null;
  }

  void eliminarRespuesta(Pregunta pregunta) {
    for (int i = 0; i < this.respuestas.length; i++) {
      if (respuestas[i].idPregunta == pregunta.idPregunta) {
        this.respuestas.removeAt(i);
        break;
      }
    }
    print('eliminarRespuesta');
  }

  void seleccionar(Pregunta pregunta, Opcion opcion) {
    Respuesta? p = existeRespuesta(pregunta);
    if (pregunta.tipo == "simple") {
      if (p == null) {
        List<Opcion> opciones = [];
        opciones.add(opcion);
        Respuesta nuevaRespuesta = new Respuesta(
          idPregunta: pregunta.idPregunta,
          nombrePregunta: pregunta.nombreP,
          tipoPregunta: 'simple',
          opcions: opciones,
        );
        respuestas.add(nuevaRespuesta);
      }
      if (p != null) {
        p.opcions = [];
        p.opcions.add(opcion);
      }
    }
    if (pregunta.tipo == "multiple") {
      addSeleccion(pregunta, opcion);
    }
    if (pregunta.tipo == "abierta") {
      Respuesta? p = existeRespuesta(pregunta);
      Respuesta nuevaRespuesta = new Respuesta(
          idPregunta: pregunta.idPregunta,
          nombrePregunta: pregunta.nombreP,
          tipoPregunta: 'abierta',
          opcions: [],
          respuestaText: '');
      if (p == null) {
        nuevaRespuesta.respuestaText = opcion.nombre;
        respuestas.add(nuevaRespuesta);
      } else {
        if (p.respuestaText!.length > 0) {
          p.respuestaText = opcion.nombre;
        }
        if (p.respuestaText == '') eliminarRespuesta(pregunta);
      }
    }
    print('Seleccionar');

    print(jsonEncode(respuestas));
  }

  void eliminarSeleccion(Pregunta pregunta, Opcion opcion) {
    Respuesta? respuesta = existeRespuesta(pregunta);
    if (respuesta == null) return;
    if (respuesta.opcions.length > 0) {
      for (int i = 0; i < respuesta.opcions.length; i++) {
        Opcion op = respuesta.opcions[i];
        if (op.idResp == opcion.idResp) {
          respuesta.opcions.removeAt(i);
          break;
        }
      }
      if (respuesta.opcions.length == 0) eliminarRespuesta(pregunta);
    }
    print('eliminar seleccion');
  }

  void xd(Pregunta pregunta, Opcion opcion) {
    print('xd');
    if (pregunta.tipo != 'multiple') return;
  }

  void addSeleccion(Pregunta pregunta, Opcion valor) {
    Respuesta? p = existeRespuesta(pregunta);
    if (p == null) {
      List<Opcion> opciones = [];
      opciones.add(valor);
      Respuesta nuevaRespuesta = new Respuesta(
        idPregunta: pregunta.idPregunta,
        nombrePregunta: pregunta.nombreP,
        tipoPregunta: 'multiple',
        opcions: opciones,
      );
      respuestas.add(nuevaRespuesta);
    } else {
      p.opcions.add(valor);
    }
    print('addSeleccion');
  }

  void imprimirRespuestas() {
    print('APLICACION DE LA ENCUESTA: ');
    for (var respuesta in respuestas) {
      print(
          'id pregunta: ${respuesta.idPregunta}, nombre: ${respuesta.nombrePregunta}');

      print('Opciones seleccionadas:');
      for (var opcion in respuesta.opcions) {
        print('id: ${opcion.idResp}, nombre: ${opcion.nombre}');
      }
    }
  }

  String formatFecha(String date) {
    var fecha = date.substring(0, 10);
    var hora = date.substring(11, 19);
    var year = fecha.split('-');
    return '${year[0]}-${year[1]}-${year[2]} $hora';
  }

  void cancelar() {
    notifyListeners();
  }

  getValor(String idSeccion, String idPregunta) {}
}
