import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../data/models/monitor_model.dart';
import '../viewmodels/monitor_bloc.dart';
import '../viewmodels/semester_bloc.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/monitor_form.dart';
import '../widgets/monitor_schedule_form.dart';

class ProfileMonitorScreen extends StatefulWidget {
  final Monitor monitor;

  const ProfileMonitorScreen({super.key, required this.monitor});

  @override
  _ProfileMonitorScreenState createState() => _ProfileMonitorScreenState();
}

class _ProfileMonitorScreenState extends State<ProfileMonitorScreen> {
  GlobalKey _key = GlobalKey();

  late SemesterBloc _semesterBloc;
  late MonitorBloc _monitorBloc;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    _semesterBloc = Provider.of<SemesterBloc>(context, listen: false);
    _monitorBloc = Provider.of<MonitorBloc>(context, listen: false);

    if (_semesterBloc.semesters == null || _semesterBloc.semesters!.isEmpty) {
      _semesterBloc.fetchSemesters();
    }
  }

  void _updateSchedule(Monitor schedule) {
    _monitorBloc.updateMonitor(schedule, widget.monitor.id!);
    setState(() {
      widget.monitor.diasAsignados = schedule.diasAsignados;
      _key = GlobalKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final svgImagePath = widget.monitor.genero == "Masculino"
        ? 'assets/images/male.svg'
        : 'assets/images/female.svg';

    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Perfil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _monitorBloc.deleteMonitor(widget.monitor.id!);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    });

                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  svgImagePath,
                  height: 100,
                  width: 100,
                ),
                GestureDetector(
                  onTap: () {
                    CustomBottomSheet.show(
                      context: context,
                      title: 'Horario',
                      child: MonitorScheduleForm(
                        schedule: widget.monitor.diasAsignados ?? "",
                        onUpdate: (schedule) {
                          _updateSchedule(schedule);
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(84, 22, 43, 1.000),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Asignar Horario",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            MonitorForm(
              semesters: _semesterBloc.semesters ?? [],
              onCreate: (monitor) {
                _monitorBloc.updateMonitor(monitor, widget.monitor.id!);
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              showSubmitButton: _isEditing,
              monitor: widget.monitor,
            ),
          ],
        ),
      ),
    );
  }
}
