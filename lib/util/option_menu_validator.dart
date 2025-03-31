import 'package:flutter/material.dart';

import '../presentation/screens/assistance/assistance_screen.dart';
import '../presentation/screens/office/general_screen.dart';
import '../presentation/screens/monitor/monitors_screen.dart';
import '../presentation/screens/semester/semester_screen.dart';

class OptionMenuValidator {
  Widget getScreen(int index) {

    final Map<int, Widget> indexRoutes = {
        0: const GeneralScreen(),
        1: const MonitorsScreen(),
        2: const SemesterScreen(),
        3: const AssistanceScreen(),
    };

    return indexRoutes[index] ?? const SizedBox.shrink();
  }
}
