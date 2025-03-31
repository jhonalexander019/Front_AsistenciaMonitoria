import 'dart:async';
import 'package:flutter/material.dart';

import '../../data/models/assistance_model.dart';
import '../../domain/usecases/assistance_usecase.dart';

class AssistanceBloc with ChangeNotifier {
  final AssistanceUsecase _assistanceUsecase;

  bool _isLoadingAssistance = false;
  bool _isLoadingRegisterAttendance = false;
  List<Assistance> _assistances = [];
  double? _absentHours;
  bool? _logOut = false;

  String? message;
  bool? successMessage;

  bool get isLoadingAssistance => _isLoadingAssistance;
  bool get isLoadingRegisterAttendance => _isLoadingRegisterAttendance;
  List<Assistance>? get assistances => _assistances;
  double? get hours => _absentHours;
  bool? get logOut => _logOut;

  AssistanceBloc(this._assistanceUsecase);

  Future<void> fetchAssistance({int? id}) async {
    _isLoadingAssistance = true;
    _assistances = [];
    try {
      _assistances = await _assistanceUsecase.fetchAssistance(id: id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingAssistance = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> createAssistance(Assistance assistance) async {
    try {
      Assistance newAssistance = await _assistanceUsecase.createAssistance(assistance);
      message = 'Asistencia creada exitosamente';
      successMessage = true;
      _assistances.insert(0, newAssistance);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> updateAssistance(Assistance assistance, int id) async {
    try {
      Assistance updatedAssistance = await _assistanceUsecase.updateAssistance(assistance, id);
      message = 'Asistencia actualizada exitosamente';
      successMessage = true;
      _assistances[_assistances.indexWhere(
              (element) => element.id == updatedAssistance.id)] = updatedAssistance;
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> absentHours(int id) async {
    try {
      _absentHours = await _assistanceUsecase.absentHours(id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      if (message == 'Te encuentras fuera del semestre vigente') {
        _logOut = true;
      }
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  registerAttendance(int id, String attendanceType) async {
    try {
      _isLoadingRegisterAttendance = true;
      bool registerSuccess =
      await _assistanceUsecase.registerAttendance(id, attendanceType);
      if (registerSuccess) {
        message = 'Asistencia registrada exitosamente';
        successMessage = true;
      }
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingRegisterAttendance = false;
      Future.microtask(() => notifyListeners());
    }
  }
}
