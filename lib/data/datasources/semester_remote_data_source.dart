import '../models/attendance_model.dart';
import '../models/semester_model.dart';

import 'base_remote_data_source.dart';

class SemesterRemoteDataSource extends BaseRemoteDataSource {
  Future<List<Semester>> listSemesters() async {
    return getRequest<List<Semester>>(
      '/semestres/listar',
          (data) => (data as List).map((json) => Semester.fromJson(json)).toList(),
    );
  }

  Future<Semester> createSemester(Semester semester) async {
    return postRequest<Semester>(
      '/semestres/crear',
      semester.toJson(),
          (data) => Semester.fromJson(data),
    );
  }

  Future<List<dynamic>> listProgressMonitors(int semestreId) async {
    return getRequest<List<dynamic>>(
      '/monitores/horasCubiertas?semestreId=$semestreId',
          (data) => data as List<dynamic>,
    );
  }

  Future<Semester> updateSemester(Semester semester, int semesterId) async {
    return putRequest<Semester>(
      '/semestres/editar/$semesterId',
      semester.toJson(),
          (data) => Semester.fromJson(data),
    );
  }

  Future<void> deleteSemester(int semesterId) async {
    return deleteRequest('/semestres/eliminar/$semesterId');
  }

  Future<List<Attendance>> listAttendances(int id) async {
    return getRequest<List<Attendance>>(
      '/asistencias/listarAsistencias?semestreId=$id',
          (data) => (data as List).map((json) => Attendance.fromJson(json)).toList(),
    );
  }

  Future<dynamic> fetchSemesterHours(int id) async {
    return getRequest<dynamic>(
      '/monitores/totalesPorSemestre?semestreId=$id',
          (data) => data,
    );
  }
}
