import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/config.dart';
import '../models/attendance_model.dart';
import '../models/monitor_model.dart';

class MonitorRemoteDataSource {
  final String baseUrl = AppConfig.baseUrl;

  Future<List<Monitor>> listMonitors() async {
    try {
      final Uri url = Uri.parse('$baseUrl/monitores/listarSemestre');
      final response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonList = jsonDecode(decodedResponse);
        return jsonList.map((json) => Monitor.fromJson(json)).toList();
      } else {
        throw Exception(response.body);
      }
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }

  Future<Monitor> createMonitor(Monitor monitor) async {
    try {
      final Uri url = Uri.parse('$baseUrl/monitores/crear');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(monitor.toJson()),
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        print('decodedResponse: $decodedResponse');
        print('response.body: ${response.body}');

        return Monitor.fromJson(jsonDecode(decodedResponse));
      }
      throw Exception(response.body);
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }

  Future<Monitor> updateMonitor(Monitor monitor, int id) async {
    try {
      final Uri url = Uri.parse('$baseUrl/monitores/actualizarPerfil/${id}');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(monitor.toJson()),
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        return Monitor.fromJson(jsonDecode(decodedResponse));
      }
      throw Exception(response.body);
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }

  Future<void> deleteMonitor(int id) async {
    try {
      final Uri url = Uri.parse('$baseUrl/monitores/eliminar/${id}');
      final response = await http.delete(
        url,
        headers: {},
      );
      if (response.statusCode == 204) {
        return;
      }
      throw Exception(response.body);
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }

  Future<bool> registerAttendance(int id, String attendanceType) async {
    try {
      final Uri url = Uri.parse('$baseUrl/asistencias/registrar/${id}?state=${attendanceType}');
      final response = await http.post(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        return true;
      }
    throw Exception(response.body);
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }

  Future<double> absentHours(int id) async {
    try {
      final Uri url = Uri.parse('$baseUrl/asistencias/horasAusente/${id}');
      final response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        return double.parse(utf8.decode(response.bodyBytes));
      }
      throw Exception(response.body);
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }

  Future<List<Attendance>> listAttendances() async {
    try {
      final Uri url = Uri.parse('$baseUrl/asistencias/listarAsistencias');
      final response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonList = jsonDecode(decodedResponse);
        return jsonList.map((json) => Attendance.fromJson(json)).toList();
      } else {
        throw Exception(response.body);
      }
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }
}
