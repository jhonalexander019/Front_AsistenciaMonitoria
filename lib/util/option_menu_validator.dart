import 'package:flutter/material.dart';

import '../presentation/screens/general_screen.dart';
import '../presentation/screens/monitors_screen.dart';
import '../presentation/screens/semester_screen.dart';

class OptionMenuValidator {
  Widget getScreen(int index) {

    final Map<int, Widget> indexRoutes = {
        0: const GeneralScreen(),
        1: const MonitorsScreen(),
        2: const SemesterScreen(),
    };

    return indexRoutes[index] ?? const SizedBox.shrink();
  }
}
