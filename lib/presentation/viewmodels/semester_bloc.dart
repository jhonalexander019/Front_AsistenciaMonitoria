import 'package:flutter/material.dart';
import '../../data/models/semester_model.dart';
import '../../domain/usecases/semester_usecase.dart';

class SemesterBloc with ChangeNotifier {
  final SemesterUsecase _semesterUsecase;

  bool _isLoadingSemesters = true;

  List<Semester> _semesters = [];

  dynamic _hoursSemester;

  String? message;
  bool? successMessage;

  bool get isLoadingSemesters => _isLoadingSemesters;
  dynamic get hoursSemester => _hoursSemester;
  List<Semester>? get semesters => _semesters;

  SemesterBloc(this._semesterUsecase);

  Future<void> fetchSemesters() async {
    _semesters = [];
    try {
      _isLoadingSemesters = true;
      _semesters = await _semesterUsecase.listSemesters();
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
      Semester newSemester = await _semesterUsecase.createSemester(semester);
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

  Future<void> updateSemester(Semester semester, int id) async {
    try {
      Semester updatedSemester =
          await _semesterUsecase.updateSemester(semester, id);
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
      await _semesterUsecase.deleteSemester(id);
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
      _hoursSemester = await _semesterUsecase.fetchSemesterHours(id);
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }
}
