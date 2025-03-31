import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/admin_bloc.dart';
import '../../viewmodels/storage_bloc.dart';
import '../../widgets/app_bar_content.dart';
import '../../widgets/build_error_message_listener.dart';
import 'widget/time_control.dart';
import '../login/login_screen.dart';
import 'widget/monitor_per_day.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  late AdminBloc _adminBloc;

  @override
  void initState() {
    super.initState();
    _adminBloc = Provider.of<AdminBloc>(context, listen: false);

    _adminBloc.fetchProgressMonitor();
    _adminBloc.fetchMonitorPerDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          title: const SizedBox.shrink(),
          flexibleSpace: const AppBarContent(title: 'Horario'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AdminBloc>(
          builder: (context, adminBloc, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      final adminBloc =
                          Provider.of<StorageBloc>(context, listen: false);
                      adminBloc.clearUser();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.grey,
                    ),
                  ),
                  MonitorPerDay(
                    isLoading: adminBloc.isLoadingMonitorPerDay,
                    dataIsNull: adminBloc.monitorPerDay?.isEmpty ?? true,
                    mananaList: (adminBloc.monitorPerDay?["Mañana"] ?? [])
                        as List<dynamic>,
                    tardeList: (adminBloc.monitorPerDay?["Tarde"] ?? [])
                        as List<dynamic>,
                  ),
                  const SizedBox(height: 20),
                  TimeControl(
                    isLoading: adminBloc.isLoadingProgressMonitor,
                    dataIsNull: adminBloc.progressMonitors?.isEmpty ?? true,
                    horasList: adminBloc.progressMonitors ?? [],
                  ),
                  BuildErrorMessageListener<AdminBloc>(
                    bloc: adminBloc,
                    success: adminBloc.successMessage ?? false,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
