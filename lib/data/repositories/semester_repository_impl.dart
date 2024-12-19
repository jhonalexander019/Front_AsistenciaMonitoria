import '../../domain/repositories/semester_repository.dart';
import '../datasources/semester_remote_data_source.dart';
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
}
