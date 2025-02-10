import 'package:flutter/material.dart';
import '../../data/models/attendance_model.dart';
import '../../data/models/semester_model.dart';
import '../../domain/usecases/semester_usecase.dart';

class SemesterBloc with ChangeNotifier {
  final SemesterUsecase semesterUsecase;

  bool _isLoadingSemesters = true;
  bool _isLoadingAttendances = true;
  bool _isLoadingProgressMonitor = true;

  List<Semester> _semesters = [];
  List<Attendance> _attendances = [];
  List<dynamic>? _progressMonitors;

  dynamic _hoursSemester;

  String? message;
  bool? successMessage;

  bool get isLoadingSemesters => _isLoadingSemesters;
  bool get isLoadingAttendances => _isLoadingAttendances;
  dynamic get hoursSemester => _hoursSemester;
  List<Semester>? get semesters => _semesters;
  List<Attendance>? get attendances => _attendances;
  List<dynamic>? get progressMonitors => _progressMonitors;
  bool get isLoadingProgressMonitor => _isLoadingProgressMonitor;

  SemesterBloc(this.semesterUsecase);

  Future<void> fetchSemesters() async {
    _semesters = [];
    try {
      _isLoadingSemesters = true;

      _semesters = await semesterUsecase.listSemesters();
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingSemesters = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> createSemester(Semester semester) async {
    try {
      Semester newSemester = await semesterUsecase.createSemester(semester);
      message = 'Semestre creado exitosamente';
      successMessage = true;
      _semesters.add(newSemester);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> fetchProgressMonitor(int semestreId) async {
    _isLoadingProgressMonitor = true;
    _progressMonitors = null;

    try {
      _progressMonitors =
          await semesterUsecase.listProgressMonitors(semestreId);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingProgressMonitor = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> updateSemester(Semester semester, int id) async {
    try {
      Semester updatedSemester =
          await semesterUsecase.updateSemester(semester, id);
      message = 'Semestre actualizado exitosamente';
      successMessage = true;
      _semesters[_semesters.indexWhere(
          (element) => element.id == updatedSemester.id)] = updatedSemester;
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> deleteSemester(int id) async {
    try {
      await semesterUsecase.deleteSemester(id);
      message = 'Semestre eliminado exitosamente';
      successMessage = true;

      _semesters.removeWhere((element) => element.id == id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> fetchSemesterHours (int id) async {
    try {
      _hoursSemester = await semesterUsecase.fetchSemesterHours(id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingProgressMonitor = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> attendanceHistory(int id) async {
    _isLoadingAttendances = true;
    _attendances = [];
    try {
      _attendances = await semesterUsecase.listAttendances(id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      _isLoadingAttendances = false;
      Future.microtask(() => notifyListeners());
    }
  }
}
