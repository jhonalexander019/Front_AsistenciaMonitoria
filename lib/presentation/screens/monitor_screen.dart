import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../data/models/user_model.dart';
import '../viewmodels/monitor_bloc.dart';
import '../viewmodels/storage_bloc.dart';
import '../widgets/build_error_message_listener.dart';
import 'login_screen.dart';

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({super.key});

  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  late StorageBloc _storageBloc;
  late MonitorBloc _monitorBloc;
  late User user;

  @override
  void initState() {
    super.initState();
    _storageBloc = Provider.of<StorageBloc>(context, listen: false);
    _monitorBloc = Provider.of<MonitorBloc>(context, listen: false);

    user = User.fromJson(_storageBloc.user ?? {});

    _monitorBloc.absentHours(user.id);
  }

  bool _shouldShowAttendanceButton(String assignedDays, double absentHours) {
    final today = DateTime.now();
    final isWeekend =
        today.weekday == DateTime.saturday || today.weekday == DateTime.sunday;
    if (isWeekend) return false;

    final todayShift = _getTodayShift();
    final isDayAssigned = assignedDays.split(', ').contains(todayShift);
    return isDayAssigned || absentHours > 0.0;
  }

  String _getTodayShift() {
    final today = DateTime.now();
    final currentDay = _getDayName(today.weekday);
    final currentShift = today.hour < 12 ? "Mañana" : "Tarde";
    return "$currentDay$currentShift";
  }

  String _getDayName(int weekday) {
    const days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];

    return days[weekday - 1];
  }

  String getAttendanceType(String assignedDays, double absentHours) {
    final todayShift = _getTodayShift();
    bool esDiaAsignado = assignedDays.split(', ').contains(todayShift);

    return (!esDiaAsignado && absentHours > 0.0) ? "Recuperado" : "Presente";
  }

  @override
  Widget build(BuildContext context) {
    final svgImagePath = _getUserImagePath();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Consumer<MonitorBloc>(
          builder: (context, monitorBloc, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgImagePath,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 24),
                Text(
                  '¡Hola ${user.nombre}!',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                (monitorBloc.logOut == true)
                    ? _buildLogoutButton()
                    : _buildAttendanceButton(),
                BuildErrorMessageListener<MonitorBloc>(
                  bloc: monitorBloc,
                  success: monitorBloc.successMessage ?? false,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _getUserImagePath() {
    return user.genero == "Masculino"
        ? 'assets/images/male.svg'
        : 'assets/images/female.svg';
  }

  Widget _buildLogoutButton() {
    return Column(
      children: [
        const Text('El semestre al que fuiste asignado ha finalizado.',
            textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _logout,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(84, 22, 43, 1.0),
            minimumSize: const Size(double.infinity, 40),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: const Text('Cerrar Sesión'),
        ),
      ],
    );
  }

  Widget _buildAttendanceButton() {
    return Selector<MonitorBloc, double>(
      selector: (_, bloc) => bloc.hours?.toDouble() ?? 0.0,
      builder: (_, absentHours, __) {
        final today = DateTime.now();
        final isWeekend = today.weekday == DateTime.saturday ||
            today.weekday == DateTime.sunday;

        if (isWeekend) {
          return const Text(
            "Fin de semana, no puedes registrar asistencias.",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          );
        }

        if (_shouldShowAttendanceButton(
            user.diasAsignados ?? '', absentHours)) {
          return _buildAttendanceColumn(absentHours);
        } else {
          return const Text(
            "Hoy no tienes monitoria asignada, ni horas pendientes por recuperar. ¡Disfruta tu día!",
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget _buildAttendanceColumn(double absentHours) {
    return Column(
      children: [
        const Text(
          'Presiona el botón para marcar tu asistencia',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Consumer<MonitorBloc>(
          builder: (context, monitorBloc, child) {
            return ElevatedButton(
              onPressed: monitorBloc.isLoadingRegisterAttendance
                  ? null
                  : () async {
                      String attendanceType = getAttendanceType(
                          user.diasAsignados ?? '', absentHours);
                      await monitorBloc.registerAttendance(
                          user.id, attendanceType);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(84, 22, 43, 1.0),
                minimumSize: const Size(double.infinity, 40),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: monitorBloc.isLoadingRegisterAttendance
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    )
                  : const Text('Registrar Asistencia'),
            );
          },
        ),
      ],
    );
  }

  void _logout() {
    final adminBloc = Provider.of<StorageBloc>(context, listen: false);
    adminBloc.clearUser();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
