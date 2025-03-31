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

  Future<dynamic> fetchSemesterHours(int id) async {
    return getRequest<dynamic>(
      '/monitores/totalesPorSemestre?semestreId=$id',
          (data) => data,
    );
  }
}
