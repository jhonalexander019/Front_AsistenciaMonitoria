import '../../data/models/semester_model.dart';

abstract class SemesterRepository {
  Future<List<Semester>> listSemesters();
  Future<Semester> createSemester(Semester semester);
}
