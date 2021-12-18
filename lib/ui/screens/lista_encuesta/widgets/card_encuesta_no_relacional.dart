import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
import 'package:encuestas_system/domain/services/encuestasDB.dart';
import 'package:encuestas_system/domain/services/internet_connection_check.service.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardEncuestaNoRelacional extends StatefulWidget {
  final Encuesta encuesta;

  const CardEncuestaNoRelacional({required this.encuesta});

  @override
  _CardEncuestaNoRelacionalState createState() =>
      _CardEncuestaNoRelacionalState();
}

class _CardEncuestaNoRelacionalState extends State<CardEncuestaNoRelacional> {
  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: titulo(widget.encuesta.nombreE)),
              downloadButton(context),
            ],
          ),
          greenLine(),
          descripcion(widget.encuesta.descripcion),
          seccionesText(widget.encuesta.cantSecciones),
          Row(
            children: [
              Expanded(child: verEncuestaButton(context)),
              SizedBox(
                width: 5.0,
              ),
              Expanded(child: aplicarEncuestaButton(context)),
            ],
          )
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
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          primary: Color.fromRGBO(61, 61, 61, 1.0),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'encuestaNoRelacional',
              arguments: widget.encuesta);
          final aplicacionService =
              Provider.of<AplicacionService>(context, listen: false);
          aplicacionService.aplicacionMode = false;
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

  Widget aplicarEncuestaButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          side:
              BorderSide(width: 1.2, color: Color.fromRGBO(59, 210, 127, 1.0)),
          primary: Colors.white,
          // primary: Color.fromRGBO(61, 61, 61, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        onPressed: () {
          final aplicacionService =
              Provider.of<AplicacionService>(context, listen: false);
          aplicacionService.aplicacionMode = true;
          Navigator.pushNamed(context, 'encuestaNoRelacional',
              arguments: widget.encuesta);
        },
        child: Center(
          child: Text(
            'Aplicar Encuesta',
            style: TextStyle(
              fontSize: 15.0,
              color: Color.fromRGBO(61, 61, 61, 1.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget downloadButton(BuildContext context) {
    // *si esa encuesta ya está descargado mostrar otro ícono y no hacer nada o preguntar al usuario si
    // *quiere eliminar la encuesta
    return FutureBuilder(
      future: EncuestaDB.existe(widget.encuesta),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        print('bool: ${snapshot.data}');
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(59, 210, 127, 1)),
            ),
          );
        }
        if (snapshot.data!) {
          return Container(
            child: IconButton(
              icon: Icon(
                Icons.download_done_outlined,
                color: Color.fromRGBO(59, 210, 127, 1.0),
              ),
              onPressed: () {
                //descargarEncuesta(widget.encuesta, context);
                //return
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Alerta'),
                    content: Text(
                        '¿Eliminar encuesta del almacenamiento del dispositivo?'),
                    actions: [
                      ElevatedButton(
                          child: Text('Eliminar'),
                          onPressed: () async {
                            //Navigator.of(context).pop();
                            await EncuestaDB.delete(widget.encuesta);
                            setState(() {});
                          })
                    ],
                  ),
                );
                //setState(() {});
                //EncuestaDB.descargarEncuesta(widget.encuesta);
              },
            ),
          );
        } else {
          return Consumer<ConnectionStatusModel>(
            builder: (context, conection, _) {
              return (conection.isOnline)
                  ? Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.file_download,
                          color: Color.fromRGBO(59, 210, 127, 1.0),
                        ),
                        onPressed: () async {
                          await descargarEncuesta(widget.encuesta, context);
                          setState(() {});
                          //EncuestaDB.descargarEncuesta(widget.encuesta);
                        },
                      ),
                    )
                  : Container();
            },
          );
        }
      },
    );
    /* return (await EncuestaDB.existe(widget.encuesta))
        ? Container(
            child: IconButton(
              icon: Icon(
                Icons.file_download,
                color: Color.fromRGBO(59, 210, 127, 1.0),
              ),
              onPressed: () {
                descargarEncuesta(widget.encuesta, context);
                //EncuestaDB.descargarEncuesta(widget.encuesta);
              },
            ),
          )
        : Container(
            child: Text('dsd'),
          ); */
  }

  Future<void> descargarEncuesta(
      Encuesta encuesta, BuildContext context) async {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
    Encuesta e = await encuestaService
        .getEncuestaNoRelacional(widget.encuesta.idEncuesta);
    EncuestaDB.descargarEncuesta(e);
  }
}
