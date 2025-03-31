import 'dart:async';

import 'package:flutter/material.dart';
import '../../data/models/monitor_model.dart';
import '../../domain/usecases/monitor_usecase.dart';

class MonitorBloc with ChangeNotifier {
  final MonitorUsecase _monitorUsecase;

  bool _isLoadingMonitors = false;
  List<Monitor> _monitors = [];
  String? message;
  bool? successMessage;

  bool get isLoadingMonitors => _isLoadingMonitors;
  List<Monitor> get monitors => _monitors;

  MonitorBloc(this._monitorUsecase);

  Future<void> fetchMonitors() async {
    _monitors = [];
    try {
      _isLoadingMonitors = true;
      _monitors = await _monitorUsecase.listMonitors();
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingMonitors = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> createMonitor(Monitor monitor) async {
    try {
      Monitor newMonitor = await _monitorUsecase.createMonitor(monitor);
      message = 'Monitor creado exitosamente';
      successMessage = true;
      _monitors.insert(0, newMonitor);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> updateMonitor(Monitor monitor, int id) async {
    try {
      Monitor updatedMonitor = await _monitorUsecase.updateMonitor(monitor, id);
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
      await _monitorUsecase.deleteMonitor(id);
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
}
