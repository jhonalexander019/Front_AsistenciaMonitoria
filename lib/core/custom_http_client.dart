import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class CustomHttpClient {
  final client = http.Client();
  final Duration timeout = Duration(seconds: 5);

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('Sin conexión a internet');
    }
    return true;
  }

  Future<http.Response> _executeRequest(Future<http.Response> Function() request) async {
    await _checkConnectivity();
    return request().timeout(
      timeout,
      onTimeout: () => throw TimeoutException('Tiempo de espera agotado'),
    );
  }

  Future<http.Response> request(
      String method,
      Uri url, {
        Map<String, String>? headers,
        Object? body,
      }) async {
    switch (method.toUpperCase()) {
      case 'GET':
        return _executeRequest(() => client.get(url, headers: headers));
      case 'POST':
        return _executeRequest(() => client.post(url, headers: headers, body: body));
      case 'PUT':
        return _executeRequest(() => client.put(url, headers: headers, body: body));
      case 'DELETE':
        return _executeRequest(() => client.delete(url, headers: headers));
      default:
        throw Exception('Método HTTP no soportado: $method');
    }
  }

  void close() {
    client.close();
  }
}