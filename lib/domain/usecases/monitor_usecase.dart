import '../../data/models/monitor_model.dart';
import '../repositories/monitor_repository.dart';

class MonitorUsecase {
  final MonitorRepository repository;

  MonitorUsecase(this.repository);

  Future<List<Monitor>> listMonitors() async {
    return await repository.listMonitors();
  }

  Future<Monitor> createMonitor(Monitor monitor) async {
    return await repository.createMonitor(monitor);
  }

  Future<Monitor> updateMonitor(Monitor monitor, int id) async {
    return await repository.updateMonitor(monitor, id);
  }

  Future deleteMonitor(int id) async {
    return await repository.deleteMonitor(id);
  }
  

}
