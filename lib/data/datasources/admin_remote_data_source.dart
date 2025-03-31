import 'base_remote_data_source.dart';

class AdminRemoteDataSource extends BaseRemoteDataSource {
  Future<Map<String, dynamic>> listMonitorsPerDay(String day) async {
    return getRequest<Map<String, dynamic>>(
      '/monitores/listarPorDia?dia=$day',
          (data) => data as Map<String, dynamic>,
    );
  }

  Future<List<dynamic>> listProgressMonitors({int? semestreId}) async {
    final String url = semestreId != null
        ? '/monitores/horasCubiertas?semestreId=$semestreId'
        : '/monitores/horasCubiertas';

    return getRequest<List<dynamic>>(
      url,
          (data) => data as List<dynamic>,
    );
  }

}
