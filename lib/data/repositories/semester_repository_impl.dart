import '../../domain/repositories/semester_repository.dart';
import '../datasources/semester_remote_data_source.dart';
import '../models/attendance_model.dart';
import '../models/semester_model.dart';

class SemesterRepositoryImpl implements SemesterRepository {
  final SemesterRemoteDataSource remoteDataSource;

  SemesterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Semester>> listSemesters() async {
    return await remoteDataSource.listSemesters();
  }

  @override
  Future<Semester> createSemester(Semester semester) async {
    return await remoteDataSource.createSemester(semester);
  }

  @override
  Future<List<dynamic>> listProgressMonitors(int semestreId) async {
    return await remoteDataSource.listProgressMonitors(semestreId);
  }

  @override
  Future<Semester> updateSemester(Semester semester, int id) async {
    return await remoteDataSource.updateSemester(semester, id);
  }

  @override
  Future<void> deleteSemester(int id) async {
    return await remoteDataSource.deleteSemester(id);
  }

  @override
  Future<List<Attendance>> listAttendances(int id) async {
    return await remoteDataSource.listAttendances(id);
  }

  @override
  Future<dynamic> fetchSemesterHours(int id) async {
    return await remoteDataSource.fetchSemesterHours(id);
  }
}
