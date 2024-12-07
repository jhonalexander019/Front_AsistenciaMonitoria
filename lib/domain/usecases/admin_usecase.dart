import '../repositories/admin_repository.dart';

class AdminUseCase {
  final AdminRepository repository;

  AdminUseCase(this.repository);

  Future<Map<String, dynamic>> listMonitorsPerDay(String day) async {
    return await repository.listMonitorsPerDay(day);
  }

  Future<List<dynamic>> listProgressMonitors() async {
    return await repository.listProgressMonitors();
  }
}
