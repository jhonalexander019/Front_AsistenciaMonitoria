import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/admin_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/monitor_screen.dart';
import '../presentation/viewmodels/storage_bloc.dart';

class SessionValidator extends StatelessWidget {
  const SessionValidator({super.key});

  @override
  Widget build(BuildContext context) {
    final storageBloc = Provider.of<StorageBloc>(context, listen: false);

    return FutureBuilder<void>(
      future: storageBloc.loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = storageBloc.user;
        if (user == null) {
          return const LoginScreen();
        }

        final rol = user['rol'];
        if (rol == 'Monitor') {
          return const MonitorScreen();
        } else if (rol == 'Admin') {
          return const AdminScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
