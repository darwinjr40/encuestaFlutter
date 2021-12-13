import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/screens/lista_encuesta/widgets/card_encuesta.dart';
import 'package:encuestas_system/ui/screens/lista_encuesta/widgets/card_encuesta_no_relacional.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 210, 127, 1.0),
        title: Text(
          'Encuestas',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.replay_outlined),
            onPressed: _recargarLista,
          )
        ],
      ),
      body: _paginaActual == 0
          ? listarEncuestasNoRelacional(context)
          : listarEncuestas(context),
      /* bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        currentIndex: _paginaActual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Relacional',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'No Relacional',
          ),
        ],
      ), */
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
          /* Container(
            padding: EdgeInsets.all(20.0),
            child: ListTile(
              title: Text('No hay encuestas'),
            ),
          ); */
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
    return FutureBuilder(
      future: encuestaService.getListNoRelacional(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: ListTile(
              title: Text('No hay encuestas'),
            ),
          );
        }
        print('si hay encuestas');
        return Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: _cargarEncuestasNoRelacional(snapshot.data, context),
          ),
        );
      },
    );
  }

  List<Widget> _cargarEncuestas(List<dynamic>? data, BuildContext? context) {
    // print(data);
    List<Widget> lista = [];
    print('data');
    _encuestas = [];
    for (var encuesta in data!) {
      _encuestas.add(encuesta);
    }
    print('_encuestas: $_encuestas');
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
    // print(data);
    List<Widget> lista = [];
    print('data');
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
    return lista;
  }

  Future<void> _recargarLista() async {
    _listaCardEncuestas = [];
    setState(() {});
  }
}
