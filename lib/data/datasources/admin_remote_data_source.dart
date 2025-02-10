import 'base_remote_data_source.dart';

class AdminRemoteDataSource extends BaseRemoteDataSource {
  Future<Map<String, dynamic>> listMonitorsPerDay(String day) async {
    return getRequest<Map<String, dynamic>>(
      '/monitores/listarPorDia?dia=$day',
          (data) => data as Map<String, dynamic>,
    );
  }

  Future<List<dynamic>> listProgressMonitors() async {
    return getRequest<List<dynamic>>(
      '/monitores/horasCubiertas',
          (data) => data as List<dynamic>,
    );
  }
}
