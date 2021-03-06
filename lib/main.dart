import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/services/aplicacionTimer.dart';
import 'package:encuestas_system/domain/services/aplicacion_encuesta_service.dart';
import 'package:encuestas_system/ui/screens/aplicaciones_screen/lista_aplicaciones_screen.dart';
import 'package:encuestas_system/ui/screens/encuesta_screen/encuesta_no_relacional_screen.dart';
import 'package:encuestas_system/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/services/internet_connection_check.service.dart';
import 'ui/screens/encuesta_screen/encuesta_screen.dart';

void main() => runApp(AppState());

class AppState extends StatefulWidget {
  @override
  _AppStateState createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EncuestaRepository()),
        ChangeNotifierProvider(create: (_) => AplicacionService()),
        ChangeNotifierProvider(create: (_) => ConnectionStatusModel()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final conectionService =
        Provider.of<ConnectionStatusModel>(context, listen: false);
    AplicacionTimer verifAplicaciones = AplicacionTimer();
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'lista_encuesta',
      routes: {
        'lista_encuesta': (_) => ListaEncuestaScreen(),
        'encuesta': (_) => EncuestaScreen(),
        'encuestaNoRelacional': (_) => EncuestaNoRelacionalScreen(),
        'aplicaciones': (_) => ListaAplicacionScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
