import 'package:encuestas_system/data/repositories/encuesta_repository.dart';
import 'package:encuestas_system/domain/entities/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelacionalList extends StatelessWidget {
  final List<Encuesta> listaEncuesta;

  const RelacionalList({Key? key, required this.listaEncuesta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<EncuestaRepository>(context, listen: false);
    return Container();
  }
}
