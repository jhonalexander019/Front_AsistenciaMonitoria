import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/semester_model.dart';
import '../../viewmodels/admin_bloc.dart';
import '../../viewmodels/assistance_bloc.dart';
import '../../viewmodels/semester_bloc.dart';
import '../assistance/widget/assistance_list.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../office/widget/time_control.dart';
import 'widget/hours_semester_cards.dart';
import 'widget/semester_form.dart';

class ProfileSemesterScreen extends StatefulWidget {
  final Semester semester;

  const ProfileSemesterScreen({super.key, required this.semester});

  @override
  ProfileSemesterScreenState createState() => ProfileSemesterScreenState();
}

class ProfileSemesterScreenState extends State<ProfileSemesterScreen> {
  final GlobalKey _key = GlobalKey();

  late SemesterBloc _semesterBloc;
  late AdminBloc _adminBloc;
  late AssistanceBloc _assistanceBloc;

  @override
  void initState() {
    super.initState();

    _semesterBloc = Provider.of<SemesterBloc>(context, listen: false);
    _adminBloc = Provider.of<AdminBloc>(context, listen: false);
    _assistanceBloc = Provider.of<AssistanceBloc>(context, listen: false);

    _adminBloc.fetchProgressMonitor(semestreId: widget.semester.id!);
    _assistanceBloc.fetchAssistance(id: widget.semester.id!);
    _semesterBloc.fetchSemesterHours(widget.semester.id!);
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
            Text(
              'Semester ${widget.semester.nombre}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    CustomBottomSheet.show(
                      context: context,
                      title: 'Editar semestre',
                      child: SemesterForm(
                        onCreate: (semester) {
                          _semesterBloc.updateSemester(
                              semester, widget.semester.id!);
                        },
                        semestre: widget.semester,
                      ),
                    );
                  },
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _semesterBloc.deleteSemester(widget.semester.id!);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SemesterBloc>(
          builder: (context, semesterBloc, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HoursSemesterCards(hoursSemester: semesterBloc.hoursSemester),
                  const SizedBox(height: 20),
                  TimeControl(
                    isLoading: _adminBloc.isLoadingProgressMonitor,
                    dataIsNull: _adminBloc.progressMonitors?.isEmpty ?? true,
                    horasList: _adminBloc.progressMonitors ?? [],
                  ),
                  const SizedBox(height: 20),
                  const Text("Asistencias", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  AssistanceList(assistances: _assistanceBloc.assistances!, isLoading: _assistanceBloc.isLoadingAssistance),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
