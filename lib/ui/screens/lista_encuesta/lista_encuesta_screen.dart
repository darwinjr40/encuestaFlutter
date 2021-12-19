import 'dart:convert' as convert;
import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/domain/entities/sqlite/EncuestaSqlite.dart';
import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
import 'package:encuestas_system/domain/services/encuestasDB.dart';
import 'package:encuestas_system/domain/services/internet_connection_check.service.dart';
import 'package:encuestas_system/ui/screens/lista_encuesta/widgets/card_encuesta.dart';
import 'package:encuestas_system/ui/screens/lista_encuesta/widgets/card_encuesta_no_relacional.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class ListaEncuestaScreen extends StatefulWidget {
  @override
  _ListaEncuestaScreenState createState() => _ListaEncuestaScreenState();
}

class _ListaEncuestaScreenState extends State<ListaEncuestaScreen> {
  int _paginaActual = 0;
  //List<Widget> _paginas = [];
  List<Encuesta> _encuestas = [];
  List<CardEncuesta> _listaCardEncuestas = [];

  @override
  void initState() {
    super.initState();
    final aplicacionService =
        Provider.of<AplicacionService>(context, listen: false);
    aplicacionService.respuestas = [];
  }

  @override
  Widget build(BuildContext context) {
    final conectionService =
        Provider.of<ConnectionStatusModel>(context, listen: false);
    return Scaffold(
      drawer: Drawer(
        child: getDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 210, 127, 1.0),
        title: Text(
          'Encuestas',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.remove_red_eye_outlined),
            onPressed: () async {
              print('encuestas en la bd:');
              List<EncuestaSqlite> encuestasEnLaBD =
                  await EncuestaDB.getEncuestas();
              if (encuestasEnLaBD.length < 1) return;
              print(
                  'cantidad de registros en la tabla encuestas: ${encuestasEnLaBD.length}');
              encuestasEnLaBD.forEach((element) {
                print(element.toString());
                print('***********************');
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.replay_outlined),
            onPressed: _recargarLista,
          ),
        ],
      ),
      body: listarEncuestasNoRelacional(context),
    );
  }

  Container getDrawer() {
    return Container(
      margin: EdgeInsets.only(top: 300.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'lista_encuesta');
              },
              child: Text('Lista Encuestas'),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'aplicaciones');
              },
              child: Text('Aplicaciones'),
            ),
          ),
        ],
      ),
    );
  }

  Widget listarEncuestas(BuildContext context) {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
    return FutureBuilder(
      future: encuestaService.getListRelacional(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(59, 210, 127, 1)),
            ),
          );
        }
        print('si hay encuestas');
        return Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: _cargarEncuestas(snapshot.data, context),
          ),
        );
      },
    );
  }

  Widget listarEncuestasNoRelacional(BuildContext context) {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
    return Consumer<ConnectionStatusModel>(builder: (context, conection, _) {
      return (conection.isOnline)
          ? FutureBuilder(
              future: encuestaService.getListNoRelacional(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(59, 210, 127, 1)),
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children:
                        _cargarEncuestasNoRelacional(snapshot.data, context),
                  ),
                );
              },
            )
          : FutureBuilder(
              future: EncuestaDB.getEncuestas(),
              builder: (context, AsyncSnapshot<List<EncuestaSqlite>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(59, 210, 127, 1),
                      ),
                    ),
                  );
                }
                //print('lista de la base de datos snapshot: ${snapshot.data}');
                List<Encuesta> listaBD = [];
                for (var e in snapshot.data!) {
                  var response = e.content;
                  //print(response);
                  var jsonResponse = convert.jsonDecode(response!);
                  print('json response: $jsonResponse');
                  Encuesta enc = Encuesta.fromMap(jsonResponse);
                  listaBD.add(enc);
                }
                print('listaDB: $listaBD');
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children: _cargarEncuestasNoRelacionalBD(listaBD),
                  ),
                );
              },
            );
      /* Container(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  _cargarEncuestasDB(context),
                ],
              ),
            ); */
    });
  }

  List<Widget> _cargarEncuestas(List<dynamic>? data, BuildContext? context) {
    List<Widget> lista = [];

    _encuestas = [];
    for (var encuesta in data!) {
      _encuestas.add(encuesta);
    }
    for (var encuesta in _encuestas) {
      lista.add(CardEncuesta(encuesta: encuesta));
      lista.add(SizedBox(
        height: 20,
      ));
    }

    return lista;
  }

  List<Widget> _cargarEncuestasNoRelacional(
      List<dynamic>? data, BuildContext? context) {
    List<Widget> lista = [];

    //print('data');
    _encuestas = [];
    for (var encuesta in data!) {
      _encuestas.add(encuesta);
    }
    print('_encuestas: $_encuestas');
    for (var encuesta in _encuestas) {
      lista.add(CardEncuestaNoRelacional(encuesta: encuesta));
      lista.add(SizedBox(
        height: 20,
      ));
    }
    //EncuestaDB.deleteAplicaciones();
    //EncuestaDB.deleteEncuestas();
    //EncuestaDB.createTableAplicaciones();
    //EncuestaDB.createTableEncuestas();
    return lista;
  }

  Widget _cargarEncuestasDB(BuildContext context) {
    List<Widget> lista = [];
    return FutureBuilder(
        future: EncuestaDB.getEncuestas(),
        builder: (context, AsyncSnapshot<List<EncuestaSqlite>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(59, 210, 127, 1),
                ),
              ),
            );
          }
          //print('lista de la base de datos snapshot: ${snapshot.data}');
          List<Encuesta> listaBD = [];
          for (var e in snapshot.data!) {
            var response = e.content;
            //print(response);
            var jsonResponse = convert.jsonDecode(response!);
            print('json response: $jsonResponse');
            Encuesta enc = Encuesta.fromMap(jsonResponse);
            listaBD.add(enc);
          }
          print('listaDB: $listaBD');
          return ListView(
            children: _cargarEncuestasNoRelacionalBD(listaBD),
          );
        });
  }

  List<Widget> _cargarEncuestasNoRelacionalBD(List<dynamic>? data) {
    List<Widget> lista = [];
    _encuestas = [];
    for (var encuesta in data!) {
      _encuestas.add(encuesta);
    }
    for (var encuesta in _encuestas) {
      lista.add(CardEncuestaNoRelacional(encuesta: encuesta));
      lista.add(SizedBox(
        height: 20,
      ));
    }
    //EncuestaDB.deleteEncuestas();
    //EncuestaDB.createTableEncuestas();
    return lista;
  }

  Future<void> descargarEncuesta(
      Encuesta encuesta, BuildContext context) async {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
    Encuesta e =
        await encuestaService.getEncuestaNoRelacional(encuesta.idEncuesta);
    EncuestaDB.insertEncuesta(e);
  }

  Future<void> _recargarLista() async {
    _listaCardEncuestas = [];
    setState(() {});

    //List<Map> result = await db.rawQuery('SELECT * FROM encueestas');
  }
}
