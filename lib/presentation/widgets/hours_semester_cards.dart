import 'package:flutter/material.dart';

class HoursSemesterCards extends StatelessWidget {
  final dynamic hoursSemester;

  const HoursSemesterCards({super.key, required this.hoursSemester});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildHourCard(
          icon: Icons.watch_later_rounded,
          label: 'Realizadas',
          value: hoursSemester?['totalHorasTrabajadas']?.toString() ?? '0.0',
        ),
        _buildHourCard(
          icon: Icons.watch_later_rounded,
          label: 'Asignadas',
          value: hoursSemester?['totalHorasAsignadas']?.toString() ?? '0.0',
        ),
      ],
    );
  }

  Widget _buildHourCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(123, 36, 46, 73),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
