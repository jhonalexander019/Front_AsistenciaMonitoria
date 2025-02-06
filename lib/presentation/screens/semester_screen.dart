import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/semester_bloc.dart';
import '../widgets/app_bar_content.dart';
import '../widgets/build_error_message_listener.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/semester_form.dart';
import '../widgets/semester_list.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  late SemesterBloc _semesterBloc;

  @override
  void initState() {
    super.initState();
    _semesterBloc = Provider.of<SemesterBloc>(context, listen: false);

    if (_semesterBloc.semesters == null || _semesterBloc.semesters!.isEmpty) {
      _semesterBloc.fetchSemesters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          flexibleSpace: const AppBarContent(title: 'Semestres'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SemesterBloc>(

          builder: (_, semesterBloc, __) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Semestres creados: ${semesterBloc.semesters?.length ?? 0}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        CustomBottomSheet.show(
                          context: context,
                          title: 'Crear semestre',
                          child: SemesterForm(
                            onCreate: _semesterBloc.createSemester,
                          ),
                        );
                      },
                      child: const Icon(Icons.add_circle, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SemesterList(
                  isLoading: semesterBloc.isLoadingSemesters,
                  dataIsNull: semesterBloc.semesters?.isEmpty ?? true,
                  semesterList: semesterBloc.semesters ?? [],
                ),
                BuildErrorMessageListener<SemesterBloc>(
                  bloc: semesterBloc,
                  success: semesterBloc.successMessage ?? false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
