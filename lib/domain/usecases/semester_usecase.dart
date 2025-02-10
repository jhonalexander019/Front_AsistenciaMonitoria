import '../../data/models/attendance_model.dart';
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

  Future<List<dynamic>> listProgressMonitors(int semestreId) async {
    return await repository.listProgressMonitors(semestreId);
  }

  Future<Semester> updateSemester(Semester semester, int id) async {
    return await repository.updateSemester(semester, id);
  }

  Future<void> deleteSemester(int id) async {
    return await repository.deleteSemester(id);
  }

  Future<List<Attendance>> listAttendances(int id) async {
    return await repository.listAttendances(id);
  }

  Future<dynamic> fetchSemesterHours(int id) async {
    return await repository.fetchSemesterHours(id);
  }
}
