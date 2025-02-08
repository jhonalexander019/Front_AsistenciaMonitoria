import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/config.dart';

class AdminRemoteDataSource {
  final String baseUrl = AppConfig.baseUrl;

  Future<Map<String, dynamic>> listMonitorsPerDay(String day) async {
    try {
      final Uri url = Uri.parse('$baseUrl/monitores/listarPorDia?dia=$day');
      final response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception(response.body);
      }
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }

  Future<List<dynamic>> listProgressMonitors() async {
    try {
      final Uri url = Uri.parse('$baseUrl/monitores/horasCubiertas');
      final response = await http.get(
        url,
        headers: {},
      );
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception(response.body);
      }
    } on http.ClientException {
      throw Exception('Error de conexión: el servidor no está disponible.');
    }
  }
}
