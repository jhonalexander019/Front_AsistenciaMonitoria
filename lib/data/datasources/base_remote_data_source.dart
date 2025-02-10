import 'dart:convert';
import 'dart:async';

import '../../core/custom_http_client.dart';

abstract class BaseRemoteDataSource {
  final CustomHttpClient httpClient = CustomHttpClient();
  final String baseUrl = 'http://192.168.1.7:8080';

  Future<T> getRequest<T>(String endpoint, T Function(dynamic) fromJson) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final response = await httpClient.request('GET', url);

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      return fromJson(jsonDecode(decodedResponse));
    }
    throw Exception(response.body);
  }

  Future<T> postRequest<T>(
      String endpoint, Map<String, dynamic> body, T Function(dynamic) fromJson) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
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
  }

  Future<T> putRequest<T>(
      String endpoint, Map<String, dynamic> body, T Function(dynamic) fromJson) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
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
  }

  Future<void> deleteRequest(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final response = await httpClient.request('DELETE', url);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(response.body);
    }
  }
}
