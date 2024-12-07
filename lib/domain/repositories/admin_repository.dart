
abstract class AdminRepository {
  Future<Map<String, dynamic>> listMonitorsPerDay(String day);
  Future<List<dynamic>> listProgressMonitors();
}
