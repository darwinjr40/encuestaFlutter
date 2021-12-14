import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
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
  int indexPageView = 0;
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final aplicacionService =
        Provider.of<AplicacionService>(context, listen: false);
    final Encuesta encuesta =
        ModalRoute.of(context)!.settings.arguments as Encuesta;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: (aplicacionService.aplicacionMode)
            ? Text('Aplicando encuesta')
            : Text('Vista Encuesta'),
        backgroundColor: (aplicacionService.aplicacionMode)
            ? Color.fromRGBO(59, 210, 127, 1.0)
            : Color.fromRGBO(0, 0, 0, 1.0),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (indexPageView > 0) indexPageView--;
                print("indexPageView: $indexPageView");
                pageController.animateToPage(indexPageView,
                    duration: Duration(milliseconds: 250), curve: Curves.ease);
              }), // Text('secciones'),
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (indexPageView + 1 < encuesta.cantSecciones) indexPageView++;
                print("indexPageView: $indexPageView");
                pageController.animateToPage(indexPageView,
                    duration: Duration(milliseconds: 250), curve: Curves.ease);
              })
        ],
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
        return Container(
          padding: EdgeInsets.all(10.0),
          child: PageView(
            onPageChanged: (index) {
              indexPageView = index;
            },
            controller: pageController,
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
    for (var seccion in encuesta.secciones!) {
      listaSeccionesPage.add(SeccionScreen(
        index: index,
        seccion: seccion,
        max: encuesta.cantSecciones,
      ));
      index++;
    }
    return listaSeccionesPage;
  }
}
