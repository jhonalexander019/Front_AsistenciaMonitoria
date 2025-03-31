import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/monitor_bloc.dart';
import '../../viewmodels/semester_bloc.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/screen_template.dart';
import 'widget/monitor_form.dart';
import 'widget/monitors_list.dart';

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
    return ScreenTemplate<MonitorBloc>(
      title: 'Monitores',
      itemCount: (bloc) => bloc.monitors.length,
      onAdd: () {
        CustomBottomSheet.show(
          context: context,
          title: 'Crear monitor',
          child: MonitorForm(
            semesters: _semesterBloc.semesters ?? [],
            onCreate: _monitorBloc.createMonitor,
          ),
        );
      },
      child: (bloc) => MonitorsList(
        monitors: bloc.monitors,
        isLoading: bloc.isLoadingMonitors,
      ),
    );
  }
}
