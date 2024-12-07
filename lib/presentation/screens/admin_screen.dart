import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../../util/option_menu_validator.dart';
import '../viewmodels/admin_bloc.dart';
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
    Future.microtask(() {
      Provider.of<AdminBloc>(context, listen: false).fetchMonitorPerDay();
      Provider.of<AdminBloc>(context, listen: false).fetchProgressMonitor();
    });
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
