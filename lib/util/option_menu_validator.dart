import 'package:flutter/material.dart';

import '../presentation/screens/general_screen.dart';
import '../presentation/screens/monitors_screen.dart';
import '../presentation/widgets/semestres_panel.dart';

class OptionMenuValidator {
  Widget getScreen(int index) {

    final Map<int, Widget> indexRoutes = {
        0: const GeneralScreen(),
        1: const MonitorsScreen(),
        2: const SemestresPanel(),
    };

    return indexRoutes[index] ?? const SizedBox.shrink();
  }
}
