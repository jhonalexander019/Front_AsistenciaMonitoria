import 'base_remote_data_source.dart';
import '../models/attendance_model.dart';
import '../models/monitor_model.dart';

class MonitorRemoteDataSource extends BaseRemoteDataSource {
  Future<List<Monitor>> listMonitors() async {
    return getRequest<List<Monitor>>(
      '/monitores/listarSemestre',
          (data) => (data as List).map((json) => Monitor.fromJson(json)).toList(),
    );
  }

  Future<Monitor> createMonitor(Monitor monitor) async {
    return postRequest<Monitor>(
      '/monitores/crear',
      monitor.toJson(),
          (data) => Monitor.fromJson(data),
    );
  }

  Future<Monitor> updateMonitor(Monitor monitor, int id) async {
    return putRequest<Monitor>(
      '/monitores/actualizarPerfil/$id',
      monitor.toJson(),
          (data) => Monitor.fromJson(data),
    );
  }

  Future<void> deleteMonitor(int id) async {
    return deleteRequest('/monitores/eliminar/$id');
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

  Future<List<Attendance>> listAttendances() async {
    return getRequest<List<Attendance>>(
      '/asistencias/listarAsistencias',
          (data) => (data as List).map((json) => Attendance.fromJson(json)).toList(),
    );
  }
}
