import 'package:flutter/material.dart';

import '../../domain/usecases/admin_usecase.dart';

class AdminBloc extends ChangeNotifier {
  final AdminUseCase adminUsecase;

  bool _isLoadingMonitorPerDay = true;
  bool _isLoadingProgressMonitor = true;
  Map<String, dynamic>? _monitorPerDay;
  List<dynamic>? _progressMonitors;
  String? message;
  bool? successMessage;

  bool get isLoadingMonitorPerDay => _isLoadingMonitorPerDay;
  bool get isLoadingProgressMonitor => _isLoadingProgressMonitor;
  Map<String, dynamic>? get monitorPerDay => _monitorPerDay;
  List<dynamic>? get progressMonitors => _progressMonitors;

  AdminBloc(this.adminUsecase);

  Future<void> fetchMonitorPerDay() async {
    _monitorPerDay = null;
    final dayOfWeek = _getDayOfWeek();
    try {
      _isLoadingMonitorPerDay = true;

      if (dayOfWeek == 'Sábado' || dayOfWeek == 'Domingo') {
        _monitorPerDay = null;
      } else {
        _monitorPerDay = await adminUsecase.listMonitorsPerDay(dayOfWeek);
      }
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingMonitorPerDay = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> fetchProgressMonitor() async {
    _progressMonitors = null;
    try {
      _isLoadingProgressMonitor = true;
      _progressMonitors = await adminUsecase.listProgressMonitors();
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingProgressMonitor = false;
      Future.microtask(() => notifyListeners());
    }
  }

  String _getDayOfWeek() {
    final now = DateTime.now();
    const days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];
    return days[now.weekday - 1];
  }
}
