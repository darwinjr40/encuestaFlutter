import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/services/services.dart';
import 'package:encuestas_system/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'lista_encuesta',
      routes: {
        'lista_encuesta': (_) => ListaEncuestaScreen(),
        'encuesta': (_) => EncuestaScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
