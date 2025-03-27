import 'dart:convert';
import 'dart:async';
import 'dart:io'; // Para capturar SocketException
import 'package:http/http.dart' as http;

import '../../core/custom_http_client.dart';

abstract class BaseRemoteDataSource {
  final CustomHttpClient httpClient = CustomHttpClient();
  final String baseUrl = 'http://172.15.0.61:8080/AsistenciaMonitor';

  Future<T> getRequest<T>(String endpoint, T Function(dynamic) fromJson) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await httpClient.request('GET', url);

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        return fromJson(jsonDecode(decodedResponse));
      }
      throw Exception(response.body);
    } on SocketException catch (e) {
      throw Exception("${e.message}");
    } on http.ClientException catch (e) {
      throw Exception("Error en la solicitud HTTP: ${e.message}");
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<T> postRequest<T>(
      String endpoint, Map<String, dynamic> body, T Function(dynamic) fromJson) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await httpClient.request(
        'POST',
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        return fromJson(jsonDecode(decodedResponse));
      }
      throw Exception(response.body);
    } on SocketException catch (e) {
      throw Exception("${e.message}");
    } on http.ClientException catch (e) {
      throw Exception("Error en la solicitud HTTP: ${e.message}");
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<T> putRequest<T>(
      String endpoint, Map<String, dynamic> body, T Function(dynamic) fromJson) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await httpClient.request(
        'PUT',
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        return fromJson(jsonDecode(decodedResponse));
      }
      throw Exception(response.body);
    } on SocketException catch (e) {
      throw Exception("${e.message}");
    } on http.ClientException catch (e) {
      throw Exception("Error en la solicitud HTTP: ${e.message}");
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<void> deleteRequest(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await httpClient.request('DELETE', url);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(response.body);
      }
    } on SocketException catch (e) {
      throw Exception("${e.message}");
    } on http.ClientException catch (e) {
      throw Exception("Error en la solicitud HTTP: ${e.message}");
    } catch (e) {
      throw Exception("$e");
    }
  }
}
