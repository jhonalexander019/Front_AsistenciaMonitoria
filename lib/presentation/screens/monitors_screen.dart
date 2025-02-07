import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/monitor_bloc.dart';
import '../viewmodels/semester_bloc.dart';
import '../widgets/app_bar_content.dart';
import '../widgets/build_error_message_listener.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/monitor_list.dart';
import '../widgets/monitor_form.dart';

class MonitorsScreen extends StatefulWidget {
  const MonitorsScreen({super.key});

  @override
  State<MonitorsScreen> createState() => _MonitorsScreenState();
}

class _MonitorsScreenState extends State<MonitorsScreen> {
  late SemesterBloc _semesterBloc;
  late MonitorBloc _monitorBloc;

  @override
  void initState() {
    super.initState();
    _semesterBloc = Provider.of<SemesterBloc>(context, listen: false);
    _monitorBloc = Provider.of<MonitorBloc>(context, listen: false);
    _fetchData();
  }

  void _fetchData() {
      _semesterBloc.fetchSemesters();
      _monitorBloc.fetchMonitors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          flexibleSpace: const AppBarContent(title: 'Monitores'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MonitorBloc>(
          builder: (_, monitorBloc, __) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Monitores creados: ${monitorBloc.monitors?.length ?? 0}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        CustomBottomSheet.show(
                          context: context,
                          title: 'Crear monitor',
                          child: MonitorForm(
                            semesters: _semesterBloc.semesters ?? [],
                            onCreate: _monitorBloc.createMonitor,
                          ),
                        );
                      },
                      child: const Icon(Icons.add_circle, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MonitorList(
                  isLoading: monitorBloc.isLoadingSemesters,
                  dataIsNull: monitorBloc.monitors?.isEmpty ?? true,
                  monitorList: monitorBloc.monitors ?? [],
                ),
                BuildErrorMessageListener<MonitorBloc>(
                  bloc: monitorBloc,
                  success: monitorBloc.successMessage ?? false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
