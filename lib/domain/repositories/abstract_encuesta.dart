import 'package:encuestas_system/domain/entities/models.dart';

abstract class AbstractEncuestaRepository {
  Future<Encuesta> getEncuestaRelacional(String id);

  Future<Encuesta> getEncuestaNoRelacional(String id);

  Future<List<Encuesta>> getListRelacional();

  Future<List<Encuesta>> getListNoRelacional();
}
