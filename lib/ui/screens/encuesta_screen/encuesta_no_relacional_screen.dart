import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/widgets/seccion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class EncuestaNoRelacionalScreen extends StatefulWidget {
  @override
  _EncuestaNoRelacionalScreenState createState() =>
      _EncuestaNoRelacionalScreenState();
}

class _EncuestaNoRelacionalScreenState
    extends State<EncuestaNoRelacionalScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final Encuesta encuesta =
        ModalRoute.of(context)!.settings.arguments as Encuesta;
    return Scaffold(
      appBar: AppBar(
        title: Text('Encuesta screen'),
        backgroundColor: Color.fromRGBO(59, 210, 127, 1.0),
      ),
      body: listarSeccionesNoRelacionales(context, encuesta),
    );
  }

  Widget listarSeccionesNoRelacionales(
      BuildContext context, Encuesta encuesta) {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
    return FutureBuilder(
      future: encuestaService.getEncuestaNoRelacional(encuesta.idEncuesta),
      builder: (context, AsyncSnapshot<Encuesta> snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(59, 210, 127, 1)),
            ),
          );
        }
        print('si hay secciones');
        return Container(
          padding: EdgeInsets.all(10.0),
          child: PageView(
            children: _cargarSecciones(snapshot.data!, context),
          ),
        );
      },
    );
  }

  List<Widget> _cargarSecciones(Encuesta data, BuildContext? context) {
    List<Widget> listaSeccionesPage = [];
    int index = 1;
    Encuesta encuesta = data;
    print(encuesta);
    //print('cargar secciones: $data');
    //print('cantidad de secciones: ${encuesta.secciones!.length}');
    for (var seccion in encuesta.secciones!) {
      listaSeccionesPage.add(SeccionScreen(
        index: index,
        seccion: seccion,
        max: encuesta.cantSecciones,
      ));
      index++;
      print('seccion: $seccion');
    }
    print('data: $data');
    print('listaSeccionesPage: $listaSeccionesPage');
    return listaSeccionesPage;
  }
}
