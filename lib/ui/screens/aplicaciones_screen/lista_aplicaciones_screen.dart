import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/services/aplicacion_db.dart';
import 'package:encuestas_system/domain/services/encuestasDB.dart';
import 'package:encuestas_system/ui/screens/aplicaciones_screen/widgets/card_aplicacion.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ListaAplicacionScreen extends StatefulWidget {
  const ListaAplicacionScreen({Key? key}) : super(key: key);

  @override
  _ListaAplicacionScreenState createState() => _ListaAplicacionScreenState();
}

class _ListaAplicacionScreenState extends State<ListaAplicacionScreen> {
  @override
  List<AplicacionEncuesta> _aplicaciones = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicaciones hechas'),
      ),
      body: listarAplicaciones(),
    );
  }

  Widget listarAplicaciones() {
    return FutureBuilder(
        future: EncuestaDB.getAplicaciones(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(59, 210, 127, 1)),
              ),
            );
          }
          if (snapshot.data!.length < 1)
            return Center(
              child: Text('No hay aplicaciones para mostrar'),
            );

          List<AplicacionEncuesta> listaAplicacion = [];
          for (var e in snapshot.data!) {
            var response = e.content;
            var jsonResponse = convert.jsonDecode(response!);
            AplicacionEncuesta enc = AplicacionEncuesta.fromMap(jsonResponse);
            listaAplicacion.add(enc);
          }
          return Container(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: _cargarAplicaciones(snapshot.data, context),
            ),
          );
        });
  }

  _cargarAplicaciones(List? data, BuildContext context) {
    List<Widget> lista = [];
    for (var aplicacion in data!) {
      _aplicaciones.add(aplicacion);
    }
    for (var aplicacion in _aplicaciones) {
      lista.add(CardAplicacion(aplicacion: aplicacion, status: false));
      lista.add(SizedBox(
        height: 20,
      ));
    }
    //EncuestaDB.deleteEncuestas();
    //EncuestaDB.createTableEncuestas();
    return lista;
  }
}
