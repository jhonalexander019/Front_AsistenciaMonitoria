import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/semester_bloc.dart';
import '../widgets/alert_message.dart';
import '../widgets/app_bar_content.dart';
import '../widgets/semester_form.dart';
import '../widgets/semester_list.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({super.key});

  @override
  _SemesterScreenState createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  @override
  void initState() {
    super.initState();
    final semesterBloc = Provider.of<SemesterBloc>(context, listen: false);
    semesterBloc.fetchSemesters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          title: const SizedBox.shrink(),
          flexibleSpace: AppBarContent(title: 'Semestres'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Semestres creados: ${semesterBloc.semesters?.length ?? 0}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              builder: (context) {
                                final semesterbloc = Provider.of<SemesterBloc>(context, listen: false);
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  child: SemesterForm(
                                    onCreate: (semester) {
                                      semesterbloc.createSemester(semester);
                                    },
                                  ),
                                );
                              });
                        },
                        child: Container(
                          child: const Icon(Icons.add_circle, size: 30),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SemesterList(
                    isLoading: semesterBloc.isLoadingSemesters,
                    dataIsNull: semesterBloc.semesters?.isEmpty ?? true,
                    semesterList: semesterBloc.semesters ?? [],
                  ),
                  if (semesterBloc.errorMessage != null)
                    AlertMessage(
                        message: semesterBloc.errorMessage!, isSuccess: false),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
