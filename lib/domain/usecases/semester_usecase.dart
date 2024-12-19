import '../../data/models/semester_model.dart';
import '../repositories/semester_repository.dart';

class SemesterUsecase {
  final SemesterRepository repository;

  SemesterUsecase(this.repository);

  Future<List<Semester>> listSemesters() async {
    return await repository.listSemesters();
  }

  Future<Semester> createSemester(Semester semester) async {
    return await repository.createSemester(semester);
  }
}
