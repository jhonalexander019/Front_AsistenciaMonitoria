import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageBloc with ChangeNotifier {

  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;

  Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    _user = userData;

    await prefs.setString('user', userData.toString());
    notifyListeners();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      _user = _parseUserFromString(userData);
    } else {
      _user = null;
    }
    notifyListeners();
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _user = null;
    notifyListeners();
  }

  Map<String, dynamic> _parseUserFromString(String userString) {
    final sanitizedString = userString.replaceAll(RegExp(r"[{}]"), "");
    final entries = sanitizedString.split(',').map((e) {
      final split = e.split(':');
      return MapEntry(split[0].trim(), split[1].trim());
    });
    return Map<String, dynamic>.fromEntries(entries);
  }

}