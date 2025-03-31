import 'base_remote_data_source.dart';
import '../models/assistance_model.dart';

class AssistanceRemoteDataSource extends BaseRemoteDataSource {

  Future<List<Assistance>> fetchAssistance({int? id}) async {
    String url = id != null
        ? '/asistencias/listarAsistencias?semestreId=$id'
        : '/asistencias/listarAsistencias';

    return getRequest<List<Assistance>>(
      url,
          (data) => (data as List).map((json) => Assistance.fromJson(json)).toList(),
    );
  }


  Future<Assistance> createAssistance(Assistance assistance) async {
    return postRequest<Assistance>(
      '/asistencias/crear-manual?monitorId=${assistance.monitorId}&jornada=${assistance.jornada}&horas=${assistance.totalHoras}&estado=${assistance.estado}',
      {},
          (data) => Assistance.fromJson(data),
    );
  }

  Future<Assistance> updateAssistance(Assistance assistance, int id) async {
    return putRequest<Assistance>(
      '/asistencias/editar/$id?horas=${assistance.totalHoras}&estado=${assistance.estado}',
      {},
          (data) => Assistance.fromJson(data),
    );
  }

  Future<bool> registerAttendance(int id, String attendanceType) async {
    await postRequest(
      '/asistencias/registrar/$id?state=$attendanceType',
      {},
          (_) => true,
    );
    return true;
  }

  Future<double> absentHours(int id) async {
    return getRequest<double>(
      '/asistencias/horasAusente/$id',
          (data) => double.parse(data.toString()),
    );
  }
}
