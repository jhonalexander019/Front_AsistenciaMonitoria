import 'package:flutter/material.dart';
import '../../data/models/semester_model.dart';
import '../../domain/usecases/semester_usecase.dart';

class SemesterBloc with ChangeNotifier{
  final SemesterUsecase semesterUsecase;

  bool _isLoadingSemesters = true;
  List<Semester> _semesters = [];
  String? errorMessage;

  bool get isLoadingSemesters => _isLoadingSemesters;
  List<Semester>? get semesters => _semesters;

  SemesterBloc(this.semesterUsecase);

  Future<void> fetchSemesters() async {
    try {
      _semesters = await semesterUsecase.listSemesters();
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      _clearMessageAfterDelay();
    } finally {
      _isLoadingSemesters = false;
      Future.microtask(() => notifyListeners());
    }
  }

  Future<void> createSemester(Semester semester) async {
    try {
      Semester flag = await semesterUsecase.createSemester(semester);
      print(flag.toJson());
      _semesters = (await semesterUsecase.listSemesters());
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      _clearMessageAfterDelay();
    } finally {
      Future.microtask(() => notifyListeners());
    }
  }

  void _clearMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 5), () {
      errorMessage = null;
      notifyListeners();
    });
  }
}