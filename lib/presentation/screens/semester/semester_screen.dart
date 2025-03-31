import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/semester_bloc.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/screen_template.dart';
import 'widget/semester_form.dart';
import 'widget/semesters_list.dart';

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
    return ScreenTemplate<SemesterBloc>(
      title: 'Semestres',
      itemCount: (bloc) => bloc.semesters?.length ?? 0,
      onAdd: () {
        CustomBottomSheet.show(
          context: context,
          title: 'Crear semestre',
          child: SemesterForm(
            onCreate: _semesterBloc.createSemester,
          ),
        );
      },
      child: (bloc) => SemestersList(
        semesters: bloc.semesters,
        isLoading: bloc.isLoadingSemesters
      ),
    );
  }
}
