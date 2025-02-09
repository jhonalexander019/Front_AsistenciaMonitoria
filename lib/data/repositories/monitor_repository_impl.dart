import '../../domain/repositories/monitor_repository.dart';
import '../datasources/monitor_remote_data_source.dart';
import '../models/attendance_model.dart';
import '../models/monitor_model.dart';

class MonitorRepositoryImpl implements MonitorRepository {
  final MonitorRemoteDataSource remoteDataSource;

  MonitorRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Monitor>> listMonitors() async {
    return await remoteDataSource.listMonitors();
  }

  @override
  Future<Monitor> createMonitor(Monitor monitor) async {
    return await remoteDataSource.createMonitor(monitor);
  }

  @override
  Future<Monitor> updateMonitor(Monitor monitor, int id) async {
    return await remoteDataSource.updateMonitor(monitor, id);
  }

  @override
  Future<void> deleteMonitor(int id) async {
    return await remoteDataSource.deleteMonitor(id);
  }

  @override
  Future<bool> registerAttendance(int id, String attendanceType) async {
    return await remoteDataSource.registerAttendance(id, attendanceType);
  }

  @override
  Future<double> absentHours(int id) async {
    return await remoteDataSource.absentHours(id);
  }

  @override
  Future<List<Attendance>> listAttendances() async {
    return await remoteDataSource.listAttendances();
  }
}
