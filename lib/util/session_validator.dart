import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/admin_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/monitor_screen.dart';
import '../presentation/viewmodels/storage_bloc.dart';

class SessionValidator extends StatefulWidget {
  const SessionValidator({super.key});

  @override
  _SessionValidatorState createState() => _SessionValidatorState();
}

class _SessionValidatorState extends State<SessionValidator> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
  await Provider.of<StorageBloc>(context, listen: false).loadUser();
  setState(() {
    _isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Consumer<StorageBloc>(
            builder: (context, storageBloc, child) {
              final user = storageBloc.user;
              if (user == null) {
                return const LoginScreen();
              }

              final codigo = user['codigo'];
              final rol = user['rol'];

              if (codigo != null && rol != null) {
                if (rol == 'Monitor') {
                  return const MonitorScreen();
                } else if (rol == 'Admin') {
                  return const AdminScreen();
                }
              }

              return const LoginScreen();
            },
          );
  }
}
