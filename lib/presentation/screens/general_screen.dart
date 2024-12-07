import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/admin_bloc.dart';
import '../widgets/alert_message.dart';
import '../widgets/app_bar_content.dart';
import '../widgets/data_container.dart';
import '../widgets/control_de_horas.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    super.initState();
    final adminBloc = Provider.of<AdminBloc>(context, listen: false);
    adminBloc.fetchMonitorPerDay();
    adminBloc.fetchProgressMonitor();
    print(adminBloc.progressMonitors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          title: const SizedBox.shrink(),
          flexibleSpace: AppBarContent(title: 'Horario'),
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
                  DataContainer(
                    isLoading: adminBloc.isLoadingMonitorPerDay,
                    dataIsNull: adminBloc.monitorPerDay == null,
                    mananaList:
                        (adminBloc.monitorPerDay?["Mañana"] ?? []) as List<dynamic>,
                    tardeList:
                        (adminBloc.monitorPerDay?["Tarde"] ?? []) as List<dynamic>,
                  ),
                  const SizedBox(height: 20),
                  ControlDeHorasSection(
                    isLoading: adminBloc.isLoadingProgressMonitor,
                    dataIsNull: adminBloc.progressMonitors == null,
                    horasList: adminBloc.progressMonitors ?? [],
                  ),
                  if (adminBloc.errorMessage != null)
                AlertMessage(message: adminBloc.errorMessage!, isSuccess: false), 
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
