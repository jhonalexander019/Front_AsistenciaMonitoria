import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageBloc with ChangeNotifier {

  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;

  /// Guardar datos del usuario en el almacenamiento local
  Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    _user = userData;

    // Guardar los datos como un JSON string
    await prefs.setString('user', userData.toString());
    notifyListeners(); // Notifica a los widgets interesados
  }

  /// Cargar datos del usuario desde el almacenamiento local
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      // Convierte el JSON string a un Map
      _user = _parseUserFromString(userData);
    } else {
      _user = null;
    }
    notifyListeners();
  }

  /// Limpiar datos del usuario
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _user = null;
    notifyListeners();
  }

  /// Convierte el string almacenado en JSON a un Map
  Map<String, dynamic> _parseUserFromString(String userString) {
    // Aquí puedes usar jsonDecode si guardas el JSON como un String válido
    // (esto es más seguro que almacenar solo un string básico)
    final sanitizedString = userString.replaceAll(RegExp(r"[{}]"), "");
    final entries = sanitizedString.split(',').map((e) {
      final split = e.split(':');
      return MapEntry(split[0].trim(), split[1].trim());
    });
    return Map<String, dynamic>.fromEntries(entries);
  }

}