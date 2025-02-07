import 'package:flutter/material.dart';
import '../../data/models/attendance_model.dart';

class AttendanceTable extends StatelessWidget {
  final List<Attendance>? attendances;
  final bool isLoading;

  const AttendanceTable({
    super.key,
    required this.attendances,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (attendances == null || attendances!.isEmpty)
            ? Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(123, 36, 46, 73),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Aún no hay asistencias registradas por parte de los monitores.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        children: const [
                          SizedBox(
                              width: 90,
                              child: Text('Fecha',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 24),
                          SizedBox(
                              width: 120,
                              child: Text('Nombre',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 24),
                          SizedBox(
                              width: 70,
                              child: Text('Jornada',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    ...attendances!.map((attendance) {
                      final colorScheme = _getRowColors(attendance.estado);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorScheme['background'],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 90,
                                  child: Text(attendance.fecha,
                                      style: TextStyle(
                                          color: colorScheme['text'])),
                                ),
                                const SizedBox(width: 24),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                      '${attendance.nombre} ${attendance.apellido}',
                                      style: TextStyle(
                                          color: colorScheme['text'])),
                                ),
                                const SizedBox(width: 24),
                                SizedBox(
                                  width: 70,
                                  child: Text(attendance.jornada,
                                      style: TextStyle(
                                          color: colorScheme['text'])),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
  }

  Map<String, Color> _getRowColors(String estado) {
    switch (estado) {
      case 'Presente':
        return {
          'background': const Color(0xFFE8F5E9),
          'text': Colors.green.shade800
        };
      case 'Ausente':
        return {
          'background': const Color(0xFFFFEBEE),
          'text': Colors.red.shade800
        };
      case 'Recuperado':
        return {
          'background': const Color(0xFFFFF3E0),
          'text': Colors.orange.shade800
        };
      default:
        return {'background': Colors.white, 'text': Colors.black};
    }
  }
}
