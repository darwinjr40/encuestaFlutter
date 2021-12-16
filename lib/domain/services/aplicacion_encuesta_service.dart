import 'dart:convert';

import 'package:encuestas_system/domain/entities/Respuesta.dart';
import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';

class AplicacionService with ChangeNotifier {
  bool aplicacionMode = false;
  int preguntasTotales = 0;
  AplicacionEncuesta? aplicacion;
  List<Respuesta> respuestas = [];
  Respuesta? existeRespuesta(Pregunta pregunta) {
    for (var respuesta in respuestas) {
      if (respuesta.idPregunta == pregunta.idPregunta) return respuesta;
    }
    return null;
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
          opcions: opciones,
          respuestaText: "",
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
    /*  if (pregunta.tipo == "abierta")  {
      Respuesta? p = existeRespuesta(pregunta);
      Respuesta nuevaRespuesta = new Respuesta(
          idPregunta: pregunta.idPregunta,
          nombrePregunta: pregunta.nombreP,
          opcions: [],
          respuestaText: '');
      if (p == null) {
        nuevaRespuesta.respuestaText = opcion.nombre;
        respuestas.add(nuevaRespuesta);
      } else {
        p.respuestaText = opcion.nombre;
        respuestas.add(nuevaRespuesta);
      }
    } */
    print(jsonEncode(respuestas));
  }

  void eliminarSeleccion(Pregunta pregunta, Opcion opcion) {
    Respuesta? respuesta = existeRespuesta(pregunta);
    if (respuesta == null) return;
    print(respuesta.idPregunta);
    for (int i = 0; i < respuesta.opcions.length; i++) {
      Opcion op = respuesta.opcions[i];
      if (op.idResp == opcion.idResp) {
        respuesta.opcions.removeAt(i);
        print('eliminado :D');
        break;
      }
    }
  }

  void xd(Pregunta pregunta, Opcion opcion) {
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
        opcions: opciones,
        respuestaText: "",
      );
      respuestas.add(nuevaRespuesta);
    } else {
      p.opcions.add(valor);
    }
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

  void cancelar() {
    notifyListeners();
  }

  getValor(String idSeccion, String idPregunta) {}
}
