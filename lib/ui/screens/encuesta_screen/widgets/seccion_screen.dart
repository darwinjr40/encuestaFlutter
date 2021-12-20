import 'dart:convert';
import 'dart:ui';
import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:http/http.dart' as http;
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
import 'package:encuestas_system/domain/services/internet_connection_check.service.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/card_pregunta_abierta.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/card_pregunta_cerrada.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/card_pregunta_multiple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeccionScreen extends StatefulWidget {
  final Seccion seccion;
  final int index;
  final int max;

  const SeccionScreen(
      {required this.seccion, required this.index, required this.max});
  @override
  _SeccionScreenState createState() => _SeccionScreenState();
}

class _SeccionScreenState extends State<SeccionScreen> {
  @override
  Widget build(BuildContext context) {
    final conectionService =
        Provider.of<ConnectionStatusModel>(context, listen: false);
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Row(
            children: [
              nombreSeccion(widget.seccion.nombreS),
              Expanded(child: SizedBox()),
              seccionIndex(),
            ],
          ),
          greenLine(),
          Column(
            children: cargarPreguntas(widget.seccion.preguntas),
          ),
          Row(
            children: [
              Expanded(child: SizedBox()),
              (widget.index == widget.max)
                  ? ElevatedButton(
                      onPressed: () {
                        final aplicacionService =
                            Provider.of<AplicacionService>(context,
                                listen: false);
                        if (aplicacionService.respuestas.length <
                            aplicacionService.preguntasTotales) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Advertencia'),
                              content: Text('Hay preguntas sin responder'),
                              actions: [
                                ElevatedButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ),
                          );
                        } else {
                          //aplicacionService.aplicacion.idEncuesta =
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Encuesta completa'),
                              content: Text(
                                  'Encuesta lista para enviar al servidor'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(59, 210, 127, 1.0))),
                                    child: Text('Enviar'),
                                    onPressed: () async {
                                      var aplicaion =
                                          aplicacionService.aplicacion;
                                      aplicaion.respDePreguntas =
                                          aplicacionService.respuestas;
                                      aplicaion.createAt =
                                          aplicacionService.formatFecha(
                                              DateTime.now().toString());
                                      aplicaion.updateAt =
                                          aplicacionService.formatFecha(
                                              DateTime.now().toString());
                                      print('APLICACION ENCUESTA \n');
                                      //DESARROLLAR EL HILO
                                      if ('HAY CONECCION BELLEZA' ==
                                          'HAY CONECCION BELLEZA') {
                                        await sendAplicacion(aplicaion);
                                      } else {
                                        // GUARDAR EN LA BD LOCAL Y DISPARAR EL HILO
                                      }
                                      Navigator.pushReplacementNamed(
                                          context, 'lista_encuesta');
                                      //Navigator.of(context).pop();
                                    })
                              ],
                            ),
                          );
                        }
                      },
                      child: Text('Finalizar Encuesta'),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(59, 210, 127, 1.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  Widget nombreSeccion(String nombreSeccion) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Container(
        child: Text(
          nombreSeccion,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Future<String> sendAplicacion(AplicacionEncuesta encuestaAplicada) async {
    String urlAplicacion = 'encuestasapp-e3fc3-default-rtdb.firebaseio.com';
    final url = Uri.https(urlAplicacion, 'aplicacion_encuesta.json');
      final respuesta = await http.post(url, body: encuestaAplicada.toJson());
      final resp = json.decode(respuesta.body);
    return resp['name'] as String;
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

  Widget seccionIndex() {
    return Container(
      child: Text('sección ${widget.index} de ${widget.max}'),
    );
  }

  Widget greenLine() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: Container(
        height: 2.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color.fromRGBO(59, 210, 127, 1.0),
        ),
      ),
    );
  }
}
