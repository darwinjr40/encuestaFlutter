import 'package:encuestas_system/domain/entities/models.dart';

abstract class AbstractEncuestaRepository {
  Future<Encuesta> getEncuestaRelacional(int id);

  Future<Encuesta> getEncuestaNoRelacional(int id);

  Future<List<Encuesta>> getListRelacional();

  Future<List<Encuesta>> getListNoRelacional();
}
