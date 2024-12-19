import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/semester_model.dart';

class SemesterRemoteDataSource {
  final String baseUrl = 'http://192.168.1.3:8080';

  Future<List<Semester>> listSemesters() async {
  final Uri url = Uri.parse('$baseUrl/semestres/listar');
    final response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Semester.fromJson(json)).toList();
    }else{
      throw Exception("Error al obtener los semestres");
    }
  }

  Future<Semester> createSemester(Semester semester) async {
    final Uri url = Uri.parse('$baseUrl/semestres/crear');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json' },
      body: jsonEncode(semester.toJson()),
    );
    if (response.statusCode == 200) {
      return Semester.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error al crear el semestre");
    }
  }

}
