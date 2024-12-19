import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthRemoteDataSource {
  final String baseUrl = 'http://192.168.1.3:8080';

  Future<User> login(int accessCode) async {
  final Uri url = Uri.parse('$baseUrl/sesion/login?codigo=$accessCode');
    final response = await http.post(
      url,
      headers: {},
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error en el inicio de sesión: Credenciales incorrectas');
    }
  }

}
