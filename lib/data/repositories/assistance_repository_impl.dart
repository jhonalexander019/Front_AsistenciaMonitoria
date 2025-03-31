import '../../domain/repositories/assistance_repository.dart';
import '../datasources/assistance_remote_data_source.dart';
import '../models/assistance_model.dart';

class AssistanceRepositoryImpl implements AssistanceRepository {
  final AssistanceRemoteDataSource remoteDataSource;

  AssistanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Assistance>> fetchAssistance({int? id}) async {
    return await remoteDataSource.fetchAssistance(id: id);
  }

  @override
  Future<Assistance> createAssistance(Assistance assistance) async {
    return await remoteDataSource.createAssistance(assistance);
  }

  @override
  Future<Assistance> updateAssistance(Assistance assistance, int id) async {
    return await remoteDataSource.updateAssistance(assistance, id);
  }

  @override
  Future<bool> registerAttendance(int id, String attendanceType) async {
    return await remoteDataSource.registerAttendance(id, attendanceType);
  }

  @override
  Future<double> absentHours(int id) async {
    return await remoteDataSource.absentHours(id);
  }
}
