import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_data_source.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> listMonitorsPerDay(String day) async {
    
    return await remoteDataSource.listMonitorsPerDay(day);
  }

  @override
  Future<List<dynamic>> listProgressMonitors() async {
    return await remoteDataSource.listProgressMonitors();
  }
}
