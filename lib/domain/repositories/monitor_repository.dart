import 'package:front_asistencia_monitoria/data/models/attendance_model.dart';

import '../../data/models/monitor_model.dart';

abstract class MonitorRepository {
  Future<List<Monitor>> listMonitors();
  Future<Monitor> createMonitor(Monitor monitor);
  Future<Monitor> updateMonitor(Monitor monitor, int id);
  Future<void> deleteMonitor(int id);
  Future<bool> registerAttendance(int id, String attendanceType);
  Future<double> absentHours(int id);
  Future<List<Attendance>> listAttendances();
}
