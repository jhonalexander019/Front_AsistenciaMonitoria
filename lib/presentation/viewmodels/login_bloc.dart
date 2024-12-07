import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/user_model.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../util/login_validator.dart';
import '../screens/admin_screen.dart';
import '../screens/monitor_screen.dart';
import 'storage_bloc.dart';

class LoginBloc with ChangeNotifier {
  final LoginUseCase loginUsecase;
  String? errorMessage;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  LoginBloc(this.loginUsecase);

  Future<void> login(BuildContext context, int accessCode) async {

    final emailError = LoginValidator.validateAccessCode(accessCode);
    if (emailError != null) {
      errorMessage = emailError;
      notifyListeners();
      _clearMessageAfterDelay();
      return;
    }

    try {
      User user = await loginUsecase(accessCode);

      Provider.of<StorageBloc>(context, listen: false).saveUser(user.toJson());

      _isLoading = false;
      notifyListeners();
      
      // Redirigir según el rol del usuario
      Widget nextScreen =
          user.rol == 'Monitor' ? const MonitorScreen() : const AdminScreen();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      _clearMessageAfterDelay();
    }
    notifyListeners();
  }

  void _clearMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 5), () {
      errorMessage = null;
      notifyListeners();
    });
  }
}
