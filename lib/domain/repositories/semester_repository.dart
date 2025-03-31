import '../../data/models/semester_model.dart';

abstract class SemesterRepository {
  Future<List<Semester>> listSemesters();
  Future<Semester> createSemester(Semester semester);
  Future<Semester> updateSemester(Semester semester, int id);
  Future<void> deleteSemester(int id);
  Future<dynamic> fetchSemesterHours(int id);
}
