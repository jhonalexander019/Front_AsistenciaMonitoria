import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../util/option_menu_validator.dart';
import '../widgets/navigator_bar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_CO', null);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final optionMenuValidator = OptionMenuValidator();
    final selectedScreen = optionMenuValidator.getScreen(_currentIndex);

    return Scaffold(
      body: selectedScreen,
      bottomNavigationBar: NavigatorBar(
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
