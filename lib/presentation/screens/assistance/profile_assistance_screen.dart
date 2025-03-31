import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/assistance_model.dart';
import '../../viewmodels/assistance_bloc.dart';
import '../../viewmodels/monitor_bloc.dart';
import 'widget/assistance_form.dart';

class ProfileAssistanceScreen extends StatefulWidget {
  final Assistance assistance;

  const ProfileAssistanceScreen({super.key, required this.assistance});

  @override
  ProfileAssistanceScreenState createState() => ProfileAssistanceScreenState();
}

class ProfileAssistanceScreenState extends State<ProfileAssistanceScreen> {
  final GlobalKey _key = GlobalKey();

  late AssistanceBloc _assistanceBloc;
  late MonitorBloc _monitorBloc;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _assistanceBloc = Provider.of<AssistanceBloc>(context, listen: false);
    _monitorBloc = Provider.of<MonitorBloc>(context, listen: false);

    if (_monitorBloc.monitors.isEmpty) {
      _monitorBloc.fetchMonitors();
    }
  }

  @override
  Widget build(BuildContext context) {

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
              Expanded(
                child: Text(
                  "Asistencia ${widget.assistance.nombre} ${widget.assistance.apellido}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    child: const Icon(Icons.edit),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AssistanceForm(
                  monitors: _monitorBloc.monitors,
                  onCreate: (assistance) {
                    _assistanceBloc.updateAssistance(assistance, widget.assistance.id!);
                    Navigator.pop(context);
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  showSubmitButton: _isEditing,
                  assistance: widget.assistance,
                ),
              ],
            ),
          ),
        ));
  }
}
