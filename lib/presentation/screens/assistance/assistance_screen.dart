import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/assistance_bloc.dart';
import '../../viewmodels/monitor_bloc.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/screen_template.dart';
import 'widget/assistance_form.dart';
import 'widget/assistance_list.dart';

class AssistanceScreen extends StatefulWidget {
  const AssistanceScreen({super.key});

  @override
  State<AssistanceScreen> createState() => _AssistanceScreenState();
}

class _AssistanceScreenState extends State<AssistanceScreen> {
  late AssistanceBloc _assistanceBloc;
  late MonitorBloc _monitorBloc;

  @override
  void initState() {
    super.initState();
    _assistanceBloc = Provider.of<AssistanceBloc>(context, listen: false);
    _monitorBloc = Provider.of<MonitorBloc>(context, listen: false);

    _monitorBloc.fetchMonitors();
    _assistanceBloc.fetchAssistance();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate<AssistanceBloc>(
      title: 'Asistencias',
      itemCount: (bloc) => bloc.assistances?.length ?? 0,
      onAdd: () {
        CustomBottomSheet.show(
          context: context,
          title: 'Crear asistencia',
          child: AssistanceForm(
            monitors: _monitorBloc.monitors,
            onCreate: _assistanceBloc.createAssistance,
          ),
        );
      },
      child: (bloc) => AssistanceList(
        assistances: bloc.assistances,
        isLoading: bloc.isLoadingAssistance,
      ),
    );
  }
}
