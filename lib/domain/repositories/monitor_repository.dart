import '../../data/models/monitor_model.dart';

abstract class MonitorRepository {
  Future<List<Monitor>> listMonitors();
  Future<Monitor> createMonitor(Monitor monitor);
  Future<Monitor> updateMonitor(Monitor monitor, int id);
  Future<void> deleteMonitor(int id);
}
