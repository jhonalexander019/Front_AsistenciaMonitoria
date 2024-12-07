import 'dart:convert';

import 'package:http/http.dart' as http;

class AdminRemoteDataSource {
  final String baseUrl = 'http://192.168.1.1:8080';

  Future<Map<String, dynamic>> listMonitorsPerDay(String day) async {
  final Uri url = Uri.parse('$baseUrl/monitores/listarPorDia?dia=$day');
    final response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Error en el inicio de sesión: Credenciales incorrectas');
    }
  }

  Future<List<dynamic>> listProgressMonitors() async {
  final Uri url = Uri.parse('$baseUrl/monitores/horasCubiertas');
    final response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el inicio de sesión: Credenciales incorrectas');
    }
  }

}
