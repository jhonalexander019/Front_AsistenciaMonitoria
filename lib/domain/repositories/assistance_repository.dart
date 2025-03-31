import '../../data/models/assistance_model.dart';

abstract class AssistanceRepository {
  Future<List<Assistance>> fetchAssistance({int? id});
  Future<Assistance> createAssistance(Assistance assistance);
  Future<Assistance> updateAssistance(Assistance assistance, int id);
  Future<bool> registerAttendance(int id, String attendanceType);
  Future<double> absentHours(int id);
}
