import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
import 'package:encuestas_system/domain/services/encuestasDB.dart';
import 'package:encuestas_system/domain/services/internet_connection_check.service.dart';
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
    return WillPopScope(
      onWillPop: () async {
        if (!aplicacionService.aplicacionMode) return true;
        final shouldPop = await _onWillPopScope(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
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
                      duration: Duration(milliseconds: 250),
                      curve: Curves.ease);
                }), // Text('secciones'),
            IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (indexPageView + 1 < encuesta.cantSecciones)
                    indexPageView++;
                  print("indexPageView: $indexPageView");
                  pageController.animateToPage(indexPageView,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.ease);
                })
          ],
        ),
        body: listarSeccionesNoRelacionales(context, encuesta),
      ),
    );
  }

  Widget listarSeccionesNoRelacionales(
      BuildContext context, Encuesta encuesta) {
    final encuestaService =
        Provider.of<EncuestaRepository>(context, listen: false);
    final conectionService =
        Provider.of<ConnectionStatusModel>(context, listen: false);
    return FutureBuilder(
      future: (conectionService.isOnline)
          ? encuestaService.getEncuestaNoRelacional(encuesta.idEncuesta)
          : EncuestaDB.getEncuestaById(encuesta.idEncuesta),
      builder: (context, AsyncSnapshot<Encuesta> snapshot) {
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

  List<Widget> _cargarSecciones(Encuesta data, BuildContext context) {
    List<Widget> listaSeccionesPage = [];
    final aplicacionService =
        Provider.of<AplicacionService>(context, listen: false);
    int index = 1;
    Encuesta encuesta = data;
    int cantidadPreguntas = 0;
    for (var seccion in encuesta.secciones) {
      listaSeccionesPage.add(KeepAlivePage(
        child: SeccionScreen(
          index: index,
          seccion: seccion,
          max: encuesta.cantSecciones,
        ),
      ));

      cantidadPreguntas += seccion.cantPreguntas;
      index++;
    }
    var applicacionEncuesta = aplicacionService.aplicacion;
    aplicacionService.preguntasTotales = cantidadPreguntas;
    applicacionEncuesta.idEncuesta = encuesta.idEncuesta;
    applicacionEncuesta.nombre = encuesta.nombreE;
    return listaSeccionesPage;
  }
  Future<bool?> _onWillPopScope(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                  '¿ Seguro que quieres salir sin terminar de aplicar la encuesta ? '),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(59, 210, 127, 1.0))),
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('No'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(255, 1, 1, 1.0))),
                  onPressed: () {
                    final aplicacionService =
                        Provider.of<AplicacionService>(context, listen: false);
                    Navigator.pop(context, true);
                    aplicacionService.respuestas = [];
                  },
                  child: Text('Si'),
                )
              ],
            ));
  }
}

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);

    return widget.child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
