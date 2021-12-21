import 'package:encuestas_system/domain/entities/Aplicacion.dart';
import 'package:encuestas_system/domain/services/aplicacion_db.dart';
import 'package:encuestas_system/domain/services/encuestasDB.dart';
import 'package:encuestas_system/ui/screens/aplicaciones_screen/widgets/card_aplicacion.dart';
import 'package:encuestas_system/ui/widgets/card_container.dart';
import 'package:encuestas_system/ui/widgets/menu_lateral.dart';
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
      drawer: Drawer(
        child: MenuLateral(),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 210, 127, 1.0),
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
          //print('snap: ${snapshot.data}');
          List<AplicacionEncuesta> listaAplicacion = [];
          for (var e in snapshot.data!) {
            var response = e.content;
            //print(response);
            var jsonResponse = convert.jsonDecode(response!);
            print('aplicacionn json response: $jsonResponse');
            AplicacionEncuesta enc = AplicacionEncuesta.fromMap(jsonResponse);
            listaAplicacion.add(enc);
          }
          return Container(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: _cargarAplicaciones(listaAplicacion, context),
            ),
          );
        });
  }

  _cargarAplicaciones(List? data, BuildContext context) {
    List<Widget> lista = [];
    _aplicaciones = [];
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
