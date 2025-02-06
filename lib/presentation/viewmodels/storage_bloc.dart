import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageBloc with ChangeNotifier {
  Map<String, dynamic>? _user;
  bool _isLoading = true;

  Map<String, dynamic>? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    _user = userData;

    await prefs.setString('user', userData.toString());
    notifyListeners();
  }

  Future<void> loadUser() async {
    _isLoading = true;

    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      _user = _parseUserFromString(userData);
      _isLoading = false;
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
      final key = split[0].trim();
      final value = split.sublist(1).join(':').trim();
      return MapEntry(key, value);
    });

    return Map<String, dynamic>.fromEntries(entries);
  }
}
