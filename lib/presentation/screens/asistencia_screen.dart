import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/monitor_bloc.dart';
import '../widgets/app_bar_content.dart';
import '../widgets/attendance_table.dart'; // Importamos el nuevo widget

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({super.key});

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  @override
  void initState() {
    super.initState();
    final monitorBloc = Provider.of<MonitorBloc>(context, listen: false);
    monitorBloc.attendanceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          flexibleSpace: const AppBarContent(title: 'Asistencias'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MonitorBloc>(
          builder: (context, monitorBloc, child) {
            return AttendanceTable(attendances: monitorBloc.attendances!, isLoading: monitorBloc.isLoadingAttendances);
          },
        ),
      ),
    );
  }
}
