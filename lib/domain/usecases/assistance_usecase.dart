import '../../data/models/assistance_model.dart';
import '../repositories/assistance_repository.dart';

class AssistanceUsecase {
  final AssistanceRepository repository;

  AssistanceUsecase(this.repository);

  Future<List<Assistance>> fetchAssistance({int? id}) async {
    return await repository.fetchAssistance(id: id);
  }

  Future<Assistance> createAssistance(Assistance assistance) async {
    return await repository.createAssistance(assistance);
  }

  Future<Assistance> updateAssistance(Assistance assistance, int id) async {
    return await repository.updateAssistance(assistance, id);
  }

  Future<double> absentHours(int id) async {
    return await repository.absentHours(id);
  }

  Future<bool> registerAttendance(int id, String attendanceType) async {
    return await repository.registerAttendance(id, attendanceType);
  }
}
