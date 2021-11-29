import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/screens/lista_encuesta/widgets/card_encuesta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaEncuestaScreen extends StatefulWidget {
  //todo: instanciar el provider de la lista de encuestas

  @override
  _ListaEncuestaScreenState createState() => _ListaEncuestaScreenState();
}

class _ListaEncuestaScreenState extends State<ListaEncuestaScreen> {
  int paginaActual = 0;
  List<Widget> _paginas = [];
  List<Encuesta> _encuestas = [];
  List<CardEncuesta> _listaCardEncuestas = [];

  @override
  Widget build(BuildContext context) {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
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
      body: listarEncuestas(context),
      bottomNavigationBar: BottomNavigationBar(
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
          return Container(
            child: ListTile(
              title: Text('No hay encuestas'),
            ),
          );
        }
        return ListView(
          children: _cargarEncuestas(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _cargarEncuestas(List<dynamic>? data, BuildContext? context) {
    print('si hay encuestas');
    return [];
  }

  Future<void> _recargarLista() async {
    _listaCardEncuestas = [];
    setState(() {});
  }
}