import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/seccion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class EncuestaScreen extends StatefulWidget {
  @override
  _EncuestaScreenState createState() => _EncuestaScreenState();
}

class _EncuestaScreenState extends State<EncuestaScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final Encuesta encuesta =
        ModalRoute.of(context)!.settings.arguments as Encuesta;

    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Encuesta screen'),
        backgroundColor: Color.fromRGBO(59, 210, 127, 1.0),
      ),
      body: listarSecciones(context, encuesta),
      /* body: PageView(
        children: listarSecciones(context),
      ), */
    );
  }

  Widget listarSecciones(BuildContext context, Encuesta encuesta) {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
    return FutureBuilder(
      future: encuestaService.getEncuestaRelacional(encuesta.idEncuesta),
      builder: (context, AsyncSnapshot<Encuesta> snapshot) {
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
              title: Text('No hay secciones'),
            ),
          ); */
        }
        print('si hay secciones');
        return Container(
          // color: Colors.red,
          padding: EdgeInsets.all(10.0),
          child: PageView(
            children: _cargarSecciones(snapshot.data!,
                context) /* [
              Container(color: Colors.green),
              Container(color: Colors.purple),
              Container(color: Colors.black),
            ] */
            ,
          ),
        );
      },
    );
  }

  List<Widget> _cargarSecciones(Encuesta data, BuildContext? context) {
    List<Widget> listaSeccionesPage = [];
    Encuesta encuesta = data;
    print('cargar secciones: $data');
    print('cantidad de secciones: ${encuesta.secciones!.length}');
    for (var seccion in encuesta.secciones!) {
      listaSeccionesPage.add(SeccionScreen(
        seccion: seccion,
      ));
      print('seccion: $seccion');
    }
    print('data: $data');
    print('listaSeccionesPage: $listaSeccionesPage');
    return listaSeccionesPage;
  }
}
