import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_asistencia_monitoria/data/models/attendance_model.dart';
import '../../data/models/monitor_model.dart';
import '../../domain/usecases/monitor_usecase.dart';

class MonitorBloc with ChangeNotifier {
  final MonitorUsecase monitorUsecase;

  bool _isLoadingSemesters = false;
  bool _isLoadingAttendances = false;
  bool _isLoadingRegisterAttendance = false;
  List<Monitor> _monitors = [];
  List<Attendance> _attendances = [];
  String? message;
  bool? successMessage;
  double? _absentHours;
  bool? _logOut = false;

  bool get isLoadingSemesters => _isLoadingSemesters;
  bool get isLoadingAttendances => _isLoadingAttendances;
  bool get isLoadingRegisterAttendance => _isLoadingRegisterAttendance;
  List<Monitor>? get monitors => _monitors;
  List<Attendance>? get attendances => _attendances;
  double? get hours => _absentHours;
  bool? get logOut => _logOut;

  set isLoadingRegisterAttendance(bool value) {
    _isLoadingRegisterAttendance = value;
    notifyListeners();
  }

  MonitorBloc(this.monitorUsecase);

  Future<void> fetchMonitors() async {
    _monitors = [];
    try {
      _isLoadingSemesters = true;
      _monitors = await monitorUsecase.listMonitors();
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingSemesters = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> createMonitor(Monitor monitor) async {
    try {
      Monitor newMonitor = await monitorUsecase.createMonitor(monitor);
      message = 'Monitor creado exitosamente';
      successMessage = true;
      _monitors.add(newMonitor);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> updateMonitor(Monitor monitor, int id) async {
    try {
      Monitor updatedMonitor = await monitorUsecase.updateMonitor(monitor, id);
      message = 'Monitor actualizado exitosamente';
      successMessage = true;
      _monitors[_monitors.indexWhere(
          (element) => element.id == updatedMonitor.id)] = updatedMonitor;
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> deleteMonitor(int id) async {
    try {
      await monitorUsecase.deleteMonitor(id);
      message = 'Monitor eliminado exitosamente';
      successMessage = true;
      _monitors.removeWhere((element) => element.id == id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  registerAttendance(int id, String attendanceType) async {
    try {
      isLoadingRegisterAttendance = true;
      bool registerSuccess =
      await monitorUsecase.registerAttendance(id, attendanceType);
      if (registerSuccess) {
        message = 'Asistencia registrada exitosamente';
        successMessage = true;
      }
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      isLoadingRegisterAttendance = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> absentHours(int id) async {
    try {
      _absentHours = await monitorUsecase.absentHours(id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      print('message: $message');
      if (message == 'Te encuentras fuera del semestre vigente') {
        _logOut = true;
      }
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> attendanceHistory() async {
    _isLoadingAttendances = true;
    _attendances = [];
    try {
      _attendances = await monitorUsecase.listAttendances();
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingAttendances = false;
      Future.microtask(() => notifyListeners());
    }
  }
}
