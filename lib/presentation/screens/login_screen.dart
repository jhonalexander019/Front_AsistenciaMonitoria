import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_bloc.dart';
import '../widgets/alert_message.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
        final loginBloc = Provider.of<LoginBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(42.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Codigo de Acceso',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                'Por favor, introduce el codigo de acceso que se te ha asignado para continuar',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
               LoginForm(
                onLogin: (accessCode) {
                  loginBloc.login(context, accessCode);
                },
              ),
              const SizedBox(height: 10),
              if (loginBloc.errorMessage != null)
                AlertMessage(message: loginBloc.errorMessage!, isSuccess: false),           
            ],
          ),
        ),
      ),
    );
  }
}