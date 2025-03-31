import '../../domain/repositories/monitor_repository.dart';
import '../datasources/monitor_remote_data_source.dart';
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


}
