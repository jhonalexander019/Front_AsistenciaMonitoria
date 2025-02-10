import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_bloc.dart';
import '../widgets/build_error_message_listener.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = Provider.of<LoginBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(42.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Código de Acceso',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Por favor, introduce el código de acceso que se te ha asignado para continuar',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Consumer<LoginBloc>(
                builder: (context, loginBloc, child) {
                  return LoginForm(
                    onLogin: (accessCode) {
                      loginBloc.login(context, accessCode);
                    },
                    isLoading: loginBloc.isLoading,
                  );
                },
              ),
              const SizedBox(height: 10),
              BuildErrorMessageListener<LoginBloc>(
                bloc: _loginBloc,
                success: _loginBloc.successMessage ?? false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
