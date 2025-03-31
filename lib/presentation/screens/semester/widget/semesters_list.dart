import 'package:flutter/material.dart';

import '../../../../data/models/semester_model.dart';
import '../../../widgets/custom_list_widget_.dart';
import '../profile_semester_screen.dart';

class SemestersList extends StatelessWidget {
  final List<Semester>? semesters;
  final bool isLoading;

  const SemestersList({
    super.key,
    required this.semesters,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListWidget<Semester>(
      items: semesters ?? [],
      isLoading: isLoading,
      dataIsNull: semesters?.isEmpty ?? true,
      onItemTap: (context, semester) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileSemesterScreen(semester: semester),
          ),
        );
      },
      title: "Semestres",
      noDataMessage: "No hay semestres creados.",
      itemBuilder: (semester) {
        return ListTile(
          leading: const Icon(Icons.calendar_today, size: 42),
          title: Text(
            semester.nombre,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle:
          Text("${semester.fechaInicio} hasta ${semester.fechaFin}"),
        );
      },
    );
  }
}
